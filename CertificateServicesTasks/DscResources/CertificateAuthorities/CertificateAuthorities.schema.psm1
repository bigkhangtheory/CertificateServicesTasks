<#
    .DESCRIPTION
        This DSC configuration is used to configure an ADCS Certificate Authority.
    .PARAMETER CAType
        Specifies the type of certification authority to install.
    .PARAMETER Credential
        To install an enterprise certification authority, the computer must be joined to an Active Directory Domain Services domain and a user account that is a member of the Enterprise Admin group is required.

        To install a standalone certification authority, a user account that is a member of Domain Admins is required.
    .PARAMETER Ensure
        Specifies whether the Certificate Authority should be installed or uninstalled.
    .PARAMETER CACommonName
        Specifies the certification authority common name.
    .PARAMETER CADistinguishedNameSuffix
        Specifies the certification authority distinguished name suffix.
    .PARAMETER CertFile
        Specifies the file name of certification authority PKCS 12 formatted certificate file.
    .PARAMETER CertFilePassword
        Specifies the password for certification authority certificate file.
    .PARAMETER CertificateID
        Specifies the thumbprint or serial number of certification authority certificate.
    .PARAMETER CryptoProviderName
        The name of the cryptographic service provider or key storage provider that is used to generate or store the private key for the CA.
    .PARAMETER DatabaseDirectory
        Specifies the folder location of the certification authority database.
    .PARAMETER HashAlgorithmName
        Specifies the signature hash algorithm used by the certification authority.
    .PARAMETER IgnoreUnicode
        Specifies that Unicode characters are allowed in certification authority name string.
    .PARAMETER KeyContainerName
        Specifies the name of an existing private key container.
    .PARAMETER KeyLength
        Specifies the bit length for new certification authority key.
    .PARAMETER LogDirectory
        Specifies the folder location of the certification authority database log.
    .PARAMETER OutputCertRequestFile
        Specifies the folder location for certificate request file.
    .PARAMETER OverwriteExistingCAinDS
        Specifies that the computer object in the Active Directory Domain Service domain should be overwritten with the same computer name.
    .PARAMETER OverwriteExistingDatabase
        Specifies that the existing certification authority database should be overwritten.
    .PARAMETER OverwriteExistingKey
        Overwrite existing key container with the same name
    .PARAMETER ParentCA
        Specifies the configuration string of the parent certification authority that will certify this CA.
    .PARAMETER ValidityPeriod
        Specifies the validity period of the certification authority certificate in hours, days, weeks, months or years.
        
        If this is a subordinate CA, do not use this parameter, because the validity period is determined by the parent CA.
    .PARAMETER ValidityPeriodUnits
        Validity period of the certification authority certificate.
        
        If this is a subordinate CA, do not specify this parameter because the validity period is determined by the parent CA.
#>
configuration CertificateAuthorities {
    param
    (
        [Parameter(Mandatory = $true)]
        [ValidateSet('EnterpriseRootCA', 'EnterpriseSubordinateCA', 'StandaloneRootCA', 'StandaloneSubordinateCA')]
        [System.String]
        $CAType,

        [Parameter(Mandatory = $true)]
        [System.Management.Automation.PSCredential]
        [System.Management.Automation.Credential()]
        $Credential,

        [Parameter()]
        [ValidateSet('Present', 'Absent')]
        [System.String]
        $Ensure = 'Present',

        [Parameter()]
        [System.String]
        $CACommonName,

        [Parameter()]
        [System.String]
        $CADistinguishedNameSuffix,

        [Parameter()]
        [System.String]
        $CertFile,

        [Parameter()]
        [System.Management.Automation.PSCredential]
        $CertFilePassword,

        [Parameter()]
        [System.String]
        $CertificateID,

        [Parameter()]
        [System.String]
        $CryptoProviderName,

        [Parameter()]
        [System.String]
        $DatabaseDirectory,

        [Parameter()]
        [System.String]
        $HashAlgorithmName,

        [Parameter()]
        [System.Boolean]
        $IgnoreUnicode,

        [Parameter()]
        [System.String]
        $KeyContainerName,

        [Parameter()]
        [System.UInt32]
        $KeyLength,

        [Parameter()]
        [System.String]
        $LogDirectory,

        [Parameter()]
        [System.String]
        $OutputCertRequestFile,

        [Parameter()]
        [System.Boolean]
        $OverwriteExistingCAinDS,

        [Parameter()]
        [System.Boolean]
        $OverwriteExistingDatabase,

        [Parameter()]
        [System.Boolean]
        $OverwriteExistingKey,

        [Parameter()]
        [System.String]
        $ParentCA,

        [Parameter()]
        [ValidateSet('Hours', 'Days', 'Months', 'Years')]
        [System.String]
        $ValidityPeriod,

        [Parameter()]
        [System.UInt32]
        $ValidityPeriodUnits,

        [Parameter()]
        [System.Collections.Hashtable]
        $AdvancedSettings
    )
    
    <#
        Import required modules
    #>
    Import-DscResource -Module xPSDesiredStateConfiguration
    Import-DscResource -Module ActiveDirectoryCSDsc

    <#
        Install required features
    #>
    xWindowsFeature ADCSCertAuthority
    {
        Ensure = 'Present'
        Name   = 'ADCS-Cert-Authority'
    }
    xWindowsFeature ADCSCertManagement
    {
        Ensure    = 'Present'
        Name      = 'RSAT-ADCS-Mgmt'
        DependsOn = '[xWindowsFeature]ADCSCertAuthority'
    }
    

    <#
        Create DSC resource for Certificate Authority
    #>

    # if not specified, ensure 'Present'
    if (-not $PSBoundParameters.ContainsKey('Ensure'))
    {
        $PSBoundParameters.Add('Ensure', 'Present')
    }

    # add required parameters
    $PSBoundParameters.Add('IsSingleInstance', 'Yes')

    $PSBoundParameters.Remove('InstanceName')
    $PSBoundParameters.Remove('AdvancedSettings')

    # this resource depends on installation of Certificate Authority
    #$PSBoundParameters.Add('DependsOn', '[xWindowsFeature]ADCSCertAuthority')

    # create resource
    $Splatting = @{
        ResourceName  = 'AdcsCertificationAuthority'
        ExecutionName = "CA_$CAType"
        Properties    = $PSBoundParameters
        NoInvoke      = $true
    }
    (Get-DscSplattedResource @Splatting).Invoke($PSBoundParameters)


    <#
        If specified, configure the advanced settings of the Active Directory Certificate Services instance
    #>
    if ($AdvancedSettings)
    {
        # remove case sensitivity of ordered Dictionary or Hashtables
        $AdvancedSettings = @{ } + $AdvancedSettings

        # add required parameter
        $AdvancedSettings.IsSingleInstance = 'Yes'

        # this resource depends on Certificate Authority
        $AdvancedSettings.DependsOn = "[AdcsCertificationAuthority]CA_$CAType"

        # create DSC resource for ADCS advanced settings
        $Splatting = @{
            ResourceName  = 'AdcsCertificationAuthoritySettings'
            ExecutionName = "CA_$($CAType)_AdvancedSettings"
            Properties    = $AdvancedSettings
            NoInvoke      = $true
        }
        (Get-DscSplattedResource @Splatting).Invoke($AdvancedSettings)
    }
} #end configuration
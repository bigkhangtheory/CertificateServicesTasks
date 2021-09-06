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
    .LINK
        https://github.com/dsccommunity/ActiveDirectoryCSDsc/wiki/AdcsCertificationAuthority
    .NOTES
        Author:     Khang M. Nguyen
#>
#Requires -Module ActiveDirectoryCSDsc


configuration CertificateAuthorities {
    param
    (
        [Parameter(Mandatory = $true)]
        [ValidateSet('EnterpriseRootCA', 'EnterpriseSubordinateCA', 'StandaloneRootCA', 'StandaloneSubordinateCA')]
        [System.String]
        $CAType,

        [Parameter(Mandatory = $true)]
        [ValidateNotNullOrEmpty()]
        [System.Management.Automation.PSCredential]
        [System.Management.Automation.Credential()]
        $Credential,

        [Parameter()]
        [ValidateSet('Present', 'Absent')]
        [System.String]
        $Ensure = 'Present',

        [Parameter()]
        [ValidateNotNullOrEmpty()]
        [System.String]
        $CACommonName,

        [Parameter()]
        [ValidatePattern('^((DC=[^,]+,?)+)$')]
        [System.String]
        $CADistinguishedNameSuffix,

        [Parameter()]
        [ValidateNotNullOrEmpty()]
        [System.String]
        $CertFile,

        [Parameter()]
        [ValidateNotNullOrEmpty()]
        [System.Management.Automation.PSCredential]
        $CertFilePassword,

        [Parameter()]
        [ValidateNotNullOrEmpty()]
        [System.String]
        $CertificateID,

        [Parameter()]
        [ValidateSet(
            'Microsoft Base Smart Card Crypto Provider',
            'Microsoft Enhanced Cryptographic Provider v1.0',
            'ECDSA_P256#Microsoft Smart Card Key Storage Provider',
            'ECDSA_P521#Microsoft Smart Card Key Storage Provider',
            'RSA#Microsoft Software Key Storage Provider',
            'Microsoft Base Cryptographic Provider v1.0',
            'ECDSA_P521#Microsoft Software Key Storage Provider',
            'ECDSA_P256#Microsoft Software Key Storage Provider',
            'Microsoft Strong Cryptographic Provider',
            'ECDSA_P384#Microsoft Software Key Storage Provider',
            'Microsoft Base DSS Cryptographic Provider',
            'RSA#Microsoft Smart Card Key Storage Provider',
            'DSA#Microsoft Software Key Storage Provider',
            'ECDSA_P384#Microsoft Smart Card Key Storage Provider'
        )]
        [System.String]
        $CryptoProviderName,

        [Parameter()]
        [ValidateSet(
            'SHA256', 'SHA384', 'SHA512', 'SHA1',
            'MD5', 'MD4', 'MD2'
        )]
        [System.String]
        $HashAlgorithmName,

        [Parameter()]
        [ValidateSet( 512, 1024, 2048, 4096 )]
        [System.UInt32]
        $KeyLength,

        [Parameter()]
        [System.String]
        $KeyContainerName,

        [Parameter()]
        [System.String]
        $DatabaseDirectory,

        [Parameter()]
        [System.Boolean]
        $IgnoreUnicode,

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
    xWindowsFeature AddAdcsCertAuthority
    {
        Ensure = 'Present'
        Name   = 'ADCS-Cert-Authority'
    }
    xWindowsFeature AddAdcsCertManagement
    {
        Ensure    = 'Present'
        Name      = 'RSAT-ADCS-Mgmt'
        DependsOn = '[xWindowsFeature]ADCSCertAuthority'
    }
    
    <#
        Parameters for DSC resource 'AdcsCertificationAuthority'
    #>
    $adcsCertificationAuthority = @(
        'CAType',
        'Credential',
        'Ensure',
        'CACommonName',
        'CADistinguishedNameSuffix',
        'CertFile',
        'CertFilePassword',
        'CertificateID'
        'CryptoProviderName',
        'DatabaseDirectory',
        'HashAlgorithmName',
        'IgnoreUnicode',
        'KeyContainerName',
        'KeyLength',
        'LogDirectory',
        'OutputCertRequestFile',
        'OverwriteExistingCAinDS',
        'OverwriteExistingDatabase',
        'OverwriteExistingKey',
        'ParentCA',
        'ValidityPeriod',
        'ValidityPeriodUnits'
    )

    <#
        Create DSC resource for Certificate Authority
    #>

    # store matching parameters into hashtable
    $properties = New-Object -TypeName System.Collections.Hashtable
    
    # enumerate script parameters, add matches to hashtable
    foreach ($item in ($PSBoundParameters.GetEnumerator() | Where-Object -Property Key -In -Value $adcsCertificationAuthority))
    {
        $properties.Add($item.Key, $item.Value)
    }

    # if not specified, ensure 'Present'
    if (-not $properties.ContainsKey('Ensure'))
    {
        $properties.Ensure = 'Present'
    }

    # add required parameters
    $properties.IsSingleInstance = 'Yes'

    # this resource depends on installation of Certificate Authority
    $properties.DependsOn = '[xWindowsFeature]AddAdcsCertAuthority'

    # create resource
    $Splatting = @{
        ResourceName  = 'AdcsCertificationAuthority'
        ExecutionName = "CA_$CAType"
        Properties    = $properties
        NoInvoke      = $true
    }
    (Get-DscSplattedResource @Splatting).Invoke($properties)


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
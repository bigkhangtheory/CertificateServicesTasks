<#
    .DESCRIPTION
        This DSC configuration is used to configure the URIs in the Authority Information Access and Online Responder OCSP extensions of certificates issued by an Active Directory Certificate Authority.
    .PARAMETER AuthorityInformationAccess
        Specifies the list of URIs that should be included in the AIA extension of the issued certificate.
    .PARAMETER OnlineResponderOCSP
        Specifies the list of URIs that should be included in the Online Responder OCSP extension of the issued certificate.
    .PARAMETER AllowServiceRestart
        Allows the Certificate Authority service to be restarted if changes are made. Defaults to false.
#>
#Requires -Module ActiveDirectoryCSDsc
#Requires -Module xPSDesiredStateConfiguration


configuration CertificateAuthorityExtensions
{
    param
    (
        [Parameter()]
        [ValidateNotNullOrEmpty()]
        [ValidateScript(
            {
                foreach ($uri in $_)
                {
                    if ( ($uri -as [System.Uri]).AbsoluteURI -eq $null )
                    {
                        throw "ERROR: Entry $uri is not a valid URI."
                    }
                }
                return $true
            }
        )]
        [System.String[]]
        $AuthorityInformationAccess,

        [Parameter()]
        [ValidateNotNullOrEmpty()]
        [ValidateScript(
            {
                foreach ($uri in $_)
                {
                    if ( ($uri -as [System.Uri]).AbsoluteURI -eq $null )
                    {
                        throw "ERROR: Entry $uri is not a valid URI."
                    }
                }
                return $true
            }
        )]
        [System.String[]]
        $OnlineResponderOCSP,

        [Parameter()]
        [ValidateNotNullOrEmpty()]
        [System.Boolean]
        $AllowServiceRestart = $false
    )

    <#
        Import required modules
    #>
    Import-DscResource -ModuleName xPSDesiredStateConfiguration
    Import-DscResource -ModuleName ActiveDirectoryCSDsc


    <#
        Ensure installation of Ceriticate Authority
    #>
    xWindowsFeature AddAdcsCertAuthority
    {
        Name   = 'ADCS-Cert-Authority'
        Ensure = 'Present'
    }

    <#
        Create DSC resource for AIA and OSCP URIs
    #>
    $properties = @{
        IsSingleInstance    = 'Yes'
        AllowRestartService = $AllowRestartService
        DependsOn           = '[xWindowsFeature]AddAdcsCertAuthority'
    }

    # if specified, add list of URIs to be included in the AIA extension
    if ($AuthorityInformationAccess)
    {
        $properties.AiaUri = @() + $AuthorityInformationAccess
    }

    # if specified, add list of URIs to be included in the Online Responder OCSP extension
    if ($OnlineResponderOCSP)
    {
        $properties.OcspUri = @() + $OnlineResponderOCSP
    }

    $Splatting = @{
        ResourceName  = 'AdcsAuthorityInformationAccess'
        ExecutionName = 'Set_AIA_Extensions'
        Properties    = $properties
        NoInvoke      = $true
    }
    (Get-DscSplattedResource @Splatting).Invoke($properties)
} #end configuration
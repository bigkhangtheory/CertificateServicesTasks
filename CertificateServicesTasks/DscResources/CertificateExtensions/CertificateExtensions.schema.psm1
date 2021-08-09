<#
    .DESCRIPTION
        This DSC configuration is used to configure the URIs in the Authority Information Access and Online Responder OCSP extensions of certificates issued by an Active Directory Certificate Authority.
    .PARAMETER AIA
        Specifies the list of URIs that should be included in the AIA extension of the issued certificate.
    .PARAMETER OCSP
        Specifies the list of URIs that should be included in the Online Responder OCSP extension of the issued certificate.
    .PARAMETER AllowServiceRestart
        Allows the Certificate Authority service to be restarted if changes are made. Defaults to false.
#>
#Requires -Module ActiveDirectoryCSDsc
#Requires -Module xPSDesiredStateConfiguration

configuration CertificateExtensions
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
        $AIA,

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
        $OCSP,

        [Parameter()]
        [ValidateNotNullOrEmpty()]
        [System.Boolean]
        $AllowServiceRestart = $false
    )

    <#
        Import required modules
    #>
    Import-DscResource -Module xPSDesiredStateConfiguration
    Import-DscResource -Module ActiveDirectoryCSDsc


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
    $myExtensions = @{
        IsSingleInstance    = 'Yes'
        AllowRestartService = $AllowRestartService
        DependsOn           = '[xWindowsFeature]AddAdcsCertAuthority'
    }

    # if specified, add list of URIs to be included in the AIA extension
    if ($AIA)
    {
        $myExtensions.AiaUri = @() + $AIA
    }

    # if specified, add list of URIs to be included in the Online Responder OCSP extension
    if ($OCSP)
    {
        $myExtensions.OcspUri = @() + $OCSP
    }

    $Splatting = @{
        ResourceName  = 'AdcsAuthorityInformationAccess'
        ExecutionName = 'Set_AIA_OCSP'
        Properties    = $myExtensions
        NoInvoke      = $true
    }
    (Get-DscSplattedResource @Splatting).Invoke($myExtensions)
} #end configuration
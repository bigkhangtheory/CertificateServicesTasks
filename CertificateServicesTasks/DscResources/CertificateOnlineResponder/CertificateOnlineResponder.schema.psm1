<#
    .DESCRIPTION
        This DSC resource is used to install an ADCS Online Responder.
    .PARAMETER Credential
        If the Online Responder service is configured to use Standalone certification authority, then an account that is a member of the local Administrators on the CA is required.

        If the Online Responder service is configured to use an Enterprise CA, then an account that is a member of Domain Admins is required.
    .PARAMETER Ensure
        Specifies whether the Online Responder feature should be installed or uninstalled.
    .LINK
        https://github.com/dsccommunity/ActiveDirectoryCSDsc/wiki/AdcsOnlineResponder
    .NOTES
        Author:     Khang M. Nguyen
        Created:    2021-09-03
#>
#Requires -Module ActiveDirectoryCSDsc
#Requires -Module xPSDesiredStateConfiguration


configuration CertificateOnlineResponder
{
    param
    (
        [Parameter(Mandatory)]
        [ValidateNotNullOrEmpty()]
        [System.Management.Automation.PSCredential]
        [System.Management.Automation.Credential()]
        $Credential,

        [Parameter()]
        [ValidateSet('Present', 'Absent')]
        [System.String]
        $Ensure = 'Present'
    )


    <#
        Import required modules
    #>
    Import-DscResource -Module xPSDesiredStateConfiguration
    Import-DscResource -Module ActiveDirectoryCSDsc


    <#
        Ensure installation of ADCS-Online-Cert
    #>
    xWindowsFeature AddAdcsOnlineCert
    {
        Name       = 'ADCS-Online-Cert'
        Ensure     = 'Present'
    }


    <#
        Create DSC resource
    #>
    AdcsOnlineResponder AddOnlineResponder
    {
        IsSingleInstance = 'Yes'
        Credential       = $Credential
        Ensure           = $Ensure
        DependsOn        = '[xWindowsFeature]AddAdcsOnlineCert'
    }
} #end configuration
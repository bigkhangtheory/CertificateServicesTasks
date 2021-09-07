<#
    .DESCRIPTION
        This resource can be used to install an ADCS Certificate Enrollment Policy Web Service on the server after the feature has been installed on the server.
    .PARAMETER AcceptConnections

    .PARAMETER AuthenticationType

    .PARAMETER SslCertThumbprint

    .PARAMETER Credential

    .PARAMETER KeybasedRenewal

    .PARAMETER Ensure
#>
#Requires -Module ActiveDirectoryCsDsc
#Requires -Module xPSDesiredStateConfiguration

configuration CertificateEnrollmentPolicyWebService
{
    param
    (
        [Parameter()]
        [System.Boolean]
        $AcceptConnections,

        [Parameter()]
        [ValidateSet('Certificate', 'Kerberos', 'Username')]
        [System.String]
        $AuthenticationType,

        [Parameter(Mandatory)]
        [ValidateNotNullOrEmpty()]
        [System.String]
        $SslCertThumbprint,

        [Parameter()]
        [System.Management.Automation.PSCredential]
        $Credential,

        [Parameter()]
        [System.Boolean]
        $KeyBasedRenewal,

        [Parameter()]
        [ValidateSet('Present', 'Absent')]
        $Ensure
    )

    <#
        Import required modules
    #>
    Import-DscResource -ModuleName xPSDesiredStateConfiguration
    Import-DscResource -ModuleName ActiveDirectoryCSDsc

    <#
        Install required features
    #>
    xWindowsFeature AdcsEnrollWebPol
    {
        Name   = 'ADCS-Enroll-Web-Pol'
        Ensure = 'Present'
    }

    <#
        If 'AcceptConnections' is specified, configure the new instance
    #>
    if ($AcceptConnections)
    {
        # if not specified, ensure 'Present'
        if (-not $Ensure)
        {
            $Ensure = 'Present'
        }

        # create execution name for the resource
        $executionName = "Enrollment_$AuthenticationType"

        # create DSC resource
        AdcsEnrollmentPolicyWebService "$executionName"
        {
            AuthenticationType = $AuthenticationType
            SslCertThumbprint  = $SslCertThumbprint
            Credential         = $Credential
            KeyBasedRenewal    = $KeyBasedRenewal
            Ensure             = $Ensure
            DependsOn          = '[xWindowsFeature]AdcsEnrollWebPol'
        }
    } #end if
} #end configuration
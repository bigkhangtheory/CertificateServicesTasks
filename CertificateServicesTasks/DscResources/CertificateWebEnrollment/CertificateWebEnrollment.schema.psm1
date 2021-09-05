<#
    .DESCRIPTION
        This DSC resource is used to install an ADCS Web Enrollment service.
    .PARAMETER CAConfig
        The Web Enrollment role service to a CA specified by <CAComputerName>\<CACommonName>

        Do not specify this if there is a local CA installed.
    .PARAMETER Credential
        If the Web Enrollment service is configured to use Standalone certification authority, then an account that is a member of the local Administrators on the CA is required.

        If the Web Enrollment service is configured to use an Enterprise CA, then an account that is a member of Domain Admins is required.
    .PARAMETER Ensure
        Specifies whether the Web Enrollment feature should be installed or uninstalled.
    .LINK
        https://github.com/dsccommunity/ActiveDirectoryCSDsc/wiki/AdcsWebEnrollment
    .NOTES
        Author:     Khang M. Nguyen
        Created:    2021-09-03
#>
#Requires -Module ActiveDirectoryCSDsc
#Requires -Module xPSDesiredStateConfiguration


configuration CertificateWebEnrollment
{
    param
    (
        [Parameter()]
        [ValidateNotNullOrEmpty()]
        [System.String]
        $CAConfig,

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
        Ensure installation of ADCS-Web-Enrollment
    #>
    xWindowsFeature AddAdcsWebEnrollment
    {
        Name       = 'ADCS-Web-Enrollment'
        Ensure     = 'Present'
        Credential = $Credential
    }


    <#
        Create DSC resource
    #>

    # create hashtable for parameters
    $properties = @{
        IsSingleInstance = 'Yes'
        Credential       = $Credential
        Ensure           = $Ensure
        DependsOn        = '[xWindowsFeature]AddAdcsWebEnrollment'
    }

    # if specified, add CAConfig
    if ($CAConfig)
    {
        $properties.CAConfig = $CAConfig
    }

    # create DSC resource
    $Splatting = @{
        ResourceName  = 'AdcsWebEnrollment'
        ExecutionName = 'AddWebEnrollmentConfig'
        Properties    = $properties
        NoInvoke      = $true
    }
    (Get-DscSplattedResource @Splatting).Invoke($properties)
} #end configuration
# AdcsWebEnrollment

## Parameters

| Parameter | Attribute | DataType | Description | Allowed Values |
| --- | --- | --- | --- | --- |
| **IsSingleInstance** | Key | String | Specifies the resource is a single instance, the value must be 'Yes' | Yes |
| **CAConfig** | Write | String | CAConfig parameter string. Do not specify this if there is a local CA installed. | |
| **Credential** | Required | PSCredential | If the Web Enrollment service is configured to use Standalone certification authority, then an account that is a member of the local Administrators on the CA is required. If the Web Enrollment service is configured to use an Enterprise CA, then an account that is a member of Domain Admins is required. | |
| **Ensure** | Write | String | Specifies whether the Web Enrollment feature should be installed or uninstalled. | Present, Absent |

## Description

This resource can be used to install the ADCS Web Enrollment service after the
feature has been installed on the server.
Using this DSC Resource to configure an ADCS Certificate Authority assumes that
the ```ADCS-Web-Enrollment``` feature has already been installed.
For more information on Web Enrollment services, see [this article on TechNet](https://technet.microsoft.com/en-us/library/cc732517.aspx).

## Examples

### Example 1

This example will add the Active Directory Certificate Services Certification
Authority Web Enrollment feature to a server and configure it as a web
enrollment server.

```powershell
Configuration AdcsWebEnrollment_InstallWebEnrollment_Config
{
    param
    (
        [Parameter(Mandatory = $true)]
        [ValidateNotNullorEmpty()]
        [System.Management.Automation.PSCredential]
        $Credential
    )

    Import-DscResource -Module ActiveDirectoryCSDsc

    Node localhost
    {
        WindowsFeature ADCS-Web-Enrollment
        {
            Ensure = 'Present'
            Name   = 'ADCS-Web-Enrollment'
        }

        AdcsWebEnrollment WebEnrollment
        {
            Ensure           = 'Present'
            IsSingleInstance = 'Yes'
            Credential       = $Credential
            DependsOn        = '[WindowsFeature]ADCS-Web-Enrollment'
        }
    }
}
```


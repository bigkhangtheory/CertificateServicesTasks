# AdcsOnlineResponder

## Parameters

| Parameter | Attribute | DataType | Description | Allowed Values |
| --- | --- | --- | --- | --- |
| **IsSingleInstance** | Key | String | Specifies the resource is a single instance, the value must be 'Yes' | Yes |
| **Credential** | Required | PSCredential | If the Online Responder service is configured to use Standalone certification authority, then an account that is a member of the local Administrators on the CA is required. If the Online Responder service is configured to use an Enterprise CA, then an account that is a member of Domain Admins is required. | |
| **Ensure** | Write | String | Specifies whether the Online Responder feature should be installed or uninstalled. | Present, Absent |

## Description

This resource can be used to install an ADCS Online Responder after the feature
has been installed on the server.
Using this DSC Resource to configure an ADCS Certificate Authority assumes that
the ```ADCS-Online-Responder``` feature has already been installed.
For more information on ADCS Online Responders, see [this article on TechNet](https://technet.microsoft.com/en-us/library/cc725958.aspx).

## Examples

### Example 1

This example will add the Active Directory Certificate Services Online Responder
feature to a server and configure it as an Online Certificate Status Protocol (OCSP)
server.

```powershell
Configuration AdcsOnlineResponder_InstallOnlineResponder_Config
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
        WindowsFeature ADCS-Online-Cert
        {
            Ensure = 'Present'
            Name   = 'ADCS-Online-Cert'
        }

        AdcsOnlineResponder OnlineResponder
        {
            Ensure           = 'Present'
            IsSingleInstance = 'Yes'
            Credential       = $Credential
            DependsOn        = '[WindowsFeature]ADCS-Online-Cert'
        }
    }
}
```


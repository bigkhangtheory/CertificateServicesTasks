# AdcsTemplate

## Parameters

| Parameter | Attribute | DataType | Description | Allowed Values |
| --- | --- | --- | --- | --- |
| **Name** | Key | String | Specifies the name of the CA template | |
| **Ensure** | Write | String | Specifies whether the CA Template should be added or removed. | Present, Absent |

## Description

This resource can be used to add or remove Certificate Authority templates
from an Enterprise CA.
Using this DSC Resource assumes that the `ADCS-Cert-Authority` feature
and the `AdcsCertificationAuthority` resource have been installed with
a `CAType` of `EnterpriseRootCA` or `EnterpriseSubordinateCA`.

## Examples

### Example 1

This example will add the KerberosAuthentication CA Template to the server.

```powershell
Configuration AdcsTemplate_AddTemplate_Config
{
    Import-DscResource -Module ActiveDirectoryCSDsc

    Node localhost
    {
        AdcsTemplate KerberosAuthentication
        {
            Name   = 'KerberosAuthentication'
            Ensure = 'Present'
        }
    }
}
```

### Example 2

This example will remove the DomainController CA Template from the server.

```powershell
Configuration AdcsTemplate_RemoveTemplate_Config
{
    Import-DscResource -Module ActiveDirectoryCSDsc

    Node localhost
    {
        AdcsTemplate DomainController
        {
            Name   = 'DomainController'
            Ensure = 'Absent'
        }
    }
}
```


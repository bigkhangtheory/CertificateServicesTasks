# AdcsEnrollmentPolicyWebService

## Parameters

| Parameter | Attribute | DataType | Description | Allowed Values |
| --- | --- | --- | --- | --- |
| **AuthenticationType** | Key | String | Specifies the authentication type used by the Certificate Enrollment Policy Web Service. | Certificate, Kerberos, UserName |
| **SslCertThumbprint** | Required | String | Specifies the thumbprint of the certificate used by Internet Information Service (IIS) to enable support for required Secure Sockets Layer (SSL). | |
| **Credential** | Required | PSCredential | If the Certificate Enrollment Policy Web service is configured to use Standalone certification authority, then an account that is a member of the local Administrators on the CA is required. If the Certificate Enrollment Policy Web service is configured to use an Enterprise CA, then an account that is a member of Domain Admins is required. | |
| **KeyBasedRenewal** | Write | Boolean | Configures the Certificate Enrollment Policy Web Service to operate in key-based renewal mode. Defaults to False. | |
| **Ensure** | Write | String | Specifies whether the Certificate Enrollment Policy Web feature should be installed or uninstalled. Defaults to Present. | Present, Absent |

## Description

This resource can be used to install an ADCS Certificate Enrollment Policy Web
Service on the server after the feature has been installed on the server.
Using this DSC Resource to configure an ADCS Certificate Authority assumes that
the `ADCS-Enroll-Web-Pol` feature has already been installed.

## Examples

### Example 1

This example will add the Active Directory Certificate Services Enrollment
Policy Web Service feature to a server and install a new instance to
accepting Certificate authentication. The Enrollment Policy Web Service
will operate in key-based renewal mode. The local machine certificate with the
thumbprint 'f0262dcf287f3e250d1760508c4ca87946006e1e' will be used for the
IIS web site for SSL encryption.

```powershell
Configuration AdcsEnrollmentPolicyWebService_InstallCertificateAuthentication_Config
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
        WindowsFeature ADCS-Enroll-Web-Pol
        {
            Ensure = 'Present'
            Name   = 'ADCS-Enroll-Web-Pol'
        }

        AdcsEnrollmentPolicyWebService EnrollmentPolicyWebService
        {
            AuthenticationType = 'Certificate'
            SslCertThumbprint  = 'f0262dcf287f3e250d1760508c4ca87946006e1e'
            Credential         = $Credential
            KeyBasedRenewal    = $true
            Ensure             = 'Present'
            DependsOn          = '[WindowsFeature]ADCS-Enroll-Web-Pol'
        }
    }
}
```

### Example 2

This example will add the Active Directory Certificate Services Enrollment
Policy Web Service feature to a server and install a new instance to
accepting Kerberos authentication. The Enrollment Policy Web Service
will operate not operate in key-based renewal mode because this is not
supported by Kerberos authentication. The local machine certificate with the
thumbprint 'f0262dcf287f3e250d1760508c4ca87946006e1e' will be used for the
IIS web site for SSL encryption.

```powershell
Configuration AdcsEnrollmentPolicyWebService_InstallKerberosAuthentication_Config
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
        WindowsFeature ADCS-Enroll-Web-Pol
        {
            Ensure = 'Present'
            Name   = 'ADCS-Enroll-Web-Pol'
        }

        AdcsEnrollmentPolicyWebService EnrollmentPolicyWebService
        {
            AuthenticationType = 'Kerberos'
            SslCertThumbprint  = 'f0262dcf287f3e250d1760508c4ca87946006e1e'
            Credential         = $Credential
            KeyBasedRenewal    = $false
            Ensure             = 'Present'
            DependsOn          = '[WindowsFeature]ADCS-Enroll-Web-Pol'
        }
    }
}
```


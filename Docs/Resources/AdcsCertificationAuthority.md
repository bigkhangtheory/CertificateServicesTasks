# AdcsCertificationAuthority

## Parameters

| Parameter | Attribute | DataType | Description | Allowed Values |
| --- | --- | --- | --- | --- |
| **IsSingleInstance** | Key | String | Specifies the resource is a single instance, the value must be 'Yes'. | Yes |
| **CAType** | Required | String | Specifies the type of certification authority to install. The possible values are EnterpriseRootCA, EnterpriseSubordinateCA, StandaloneRootCA, or StandaloneSubordinateCA. | EnterpriseRootCA, EnterpriseSubordinateCA, StandaloneRootCA, StandaloneSubordinateCA |
| **Credential** | Required | PSCredential | To install an enterprise certification authority, the computer must be joined to an Active Directory Domain Services domain and a user account that is a member of the Enterprise Admin group is required. To install a standalone certification authority, the computer can be in a workgroup or AD DS domain. If the computer is in a workgroup, a user account that is a member of Administrators is required. If the computer is in an AD DS domain, a user account that is a member of Domain Admins is required. | |
| **Ensure** | Write | String | Specifies whether the Certificate Authority should be installed or uninstalled. | Present, Absent |
| **CACommonName** | Write | String | Specifies the certification authority common name. | |
| **CADistinguishedNameSuffix** | Write | String | Specifies the certification authority distinguished name suffix. | |
| **CertFile** | Write | String | Specifies the file name of certification authority PKCS 12 formatted certificate file. | |
| **CertFilePassword** | Write | PSCredential | Specifies the password for certification authority certificate file. | |
| **CertificateID** | Write | String | Specifies the thumbprint or serial number of certification authority certificate. | |
| **CryptoProviderName** | Write | String | The name of the cryptographic service provider or key storage provider that is used to generate or store the private key for the CA. | |
| **DatabaseDirectory** | Write | String | Specifies the folder location of the certification authority database. | |
| **HashAlgorithmName** | Write | String | Specifies the signature hash algorithm used by the certification authority. | |
| **IgnoreUnicode** | Write | Boolean | Specifies that Unicode characters are allowed in certification authority name string. | |
| **KeyContainerName** | Write | String | Specifies the name of an existing private key container. | |
| **KeyLength** | Write | UInt32 | Specifies the bit length for new certification authority key. | |
| **LogDirectory** | Write | String | Specifies the folder location of the certification authority database log. | |
| **OutputCertRequestFile** | Write | String | Specifies the folder location for certificate request file. | |
| **OverwriteExistingCAinDS** | Write | Boolean | Specifies that the computer object in the Active Directory Domain Service domain should be overwritten with the same computer name. | |
| **OverwriteExistingDatabase** | Write | Boolean | Specifies that the existing certification authority database should be overwritten. | |
| **OverwriteExistingKey** | Write | Boolean | Overwrite existing key container with the same name | |
| **ParentCA** | Write | String | Specifies the configuration string of the parent certification authority that will certify this CA. | |
| **ValidityPeriod** | Write | String | Specifies the validity period of the certification authority certificate in hours, days, weeks, months or years. If this is a subordinate CA, do not use this parameter, because the validity period is determined by the parent CA. | Hours, Days, Months, Years |
| **ValidityPeriodUnits** | Write | UInt32 | Validity period of the certification authority certificate. If this is a subordinate CA, do not specify this parameter because the validity period is determined by the parent CA. | |

## Description

This resource can be used to install the ADCS Certificate Authority after the
feature has been installed on the server.
Using this DSC Resource to configure an ADCS Certificate Authority assumes that
the `ADCS-Cert-Authority` feature has already been installed.

## Examples

### Example 1

This example will add the Active Directory Certificate Services Certificate Authority
feature to a server and configure it as a certificate authority enterprise root CA.

```powershell
Configuration AdcsCertificationAuthority_InstallCertificationAthority_Config
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
        WindowsFeature ADCS-Cert-Authority
        {
            Ensure = 'Present'
            Name   = 'ADCS-Cert-Authority'
        }

        AdcsCertificationAuthority CertificateAuthority
        {
            IsSingleInstance = 'Yes'
            Ensure           = 'Present'
            Credential       = $Credential
            CAType           = 'EnterpriseRootCA'
            DependsOn        = '[WindowsFeature]ADCS-Cert-Authority'
        }
    }
}
```

### Example 2

This example will add the retire an Active Directory Certificate Services
certificate authority from a node and uninstall the Active Directory Certificate
Services certification authority feature.

It will set the Root CA common came to 'Contoso Root CA' and the CA distinguished
name suffix to 'DC=CONTOSO,DC=COM'. If an existing CA root certificate exists
in the Active Directory then it will be overwritten.

```powershell
Configuration AdcsCertificationAuthority_RetireCertificationAthority_Config
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
        AdcsCertificationAuthority CertificateAuthority
        {
            IsSingleInstance          = 'Yes'
            Ensure                    = 'Absent'
            Credential                = $Credential
            CAType                    = 'EnterpriseRootCA'
            CACommonName              = 'Contoso Root CA'
            CADistinguishedNameSuffix = 'DC=CONTOSO,DC=COM'
            OverwriteExistingCAinDS   = $True
        }

        WindowsFeature ADCS-Cert-Authority
        {
            Ensure    = 'Absent'
            Name      = 'ADCS-Cert-Authority'
            DependsOn = '[AdcsCertificationAuthority]CertificateAuthority'
        }
    }
}
```


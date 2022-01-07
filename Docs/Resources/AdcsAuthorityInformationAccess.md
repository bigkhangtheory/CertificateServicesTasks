# AdcsAuthorityInformationAccess

## Parameters

| Parameter | Attribute | DataType | Description | Allowed Values |
| --- | --- | --- | --- | --- |
| **IsSingleInstance** | Key | String | Specifies the resource is a single instance, the value must be 'Yes'. | Yes |
| **AiaUri** | Write | StringArray[] | Specifies the list of URIs that should be included in the AIA extension of the issued certificate. | |
| **OcspUri** | Write | StringArray[] | Specifies the list of URIs that should be included in the Online Responder OCSP extension of the issued certificate. | |
| **AllowRestartService** | Write | Boolean | Allows the Certificate Authority service to be restarted if changes are made. Defaults to false. | |

## Description

This resource can be used to configure the URIs in the Authority Information
Access and Online Responder OCSP extensions of certificates issued by an
Active Directory Certificate Authority.

## Examples

### Example 1

This example will set the Authority Information Access URIs
to be included in the AIA extension.

```powershell
configuration AdcsAuthorityInformationAccess_SetAia_Config
{
    Import-DscResource -ModuleName ActiveDirectoryCSDsc

    node localhost
    {
        AdcsAuthorityInformationAccess SetAia
        {
            IsSingleInstance    = 'Yes'
            AiaUri              = @(
                'http://setAIATest1/Certs/<CATruncatedName>.cer'
                'http://setAIATest2/Certs/<CATruncatedName>.cer'
                'http://setAIATest3/Certs/<CATruncatedName>.cer'
                'file://<ServerDNSName>/CertEnroll/<ServerDNSName>_<CAName><CertificateName>.crt'
            )
            AllowRestartService = $true
        }
    }
}
```

### Example 2

This example will set the Online Responder OCSP URIs
to be included in the OCSP extension.

```powershell
configuration AdcsAuthorityInformationAccess_SetOcsp_Config
{
    Import-DscResource -ModuleName ActiveDirectoryCSDsc

    node localhost
    {
        AdcsAuthorityInformationAccess SetOcsp
        {
            IsSingleInstance    = 'Yes'
            OcspUri             = @(
                'http://primary-ocsp-responder/ocsp'
                'http://secondary-ocsp-responder/ocsp'
                'http://tertiary-ocsp-responder/ocsp'
            )
            AllowRestartService = $true
        }
    }
}
```

### Example 3

This example will set the Authority Information Access and Online Responder
OCSP URIs to be included in the AIA and OCSP extensions respectively.

```powershell
configuration AdcsAuthorityInformationAccess_SetAiaAndOcsp_Config
{
    Import-DscResource -ModuleName ActiveDirectoryCSDsc

    node localhost
    {
        AdcsAuthorityInformationAccess SetAiaAndOcsp
        {
            IsSingleInstance    = 'Yes'
            AiaUri              = @(
                'http://setAIATest1/Certs/<CATruncatedName>.cer'
                'http://setAIATest2/Certs/<CATruncatedName>.cer'
                'http://setAIATest3/Certs/<CATruncatedName>.cer'
                'file://<ServerDNSName>/CertEnroll/<ServerDNSName>_<CAName><CertificateName>.crt'
            )
            OcspUri             = @(
                'http://primary-ocsp-responder/ocsp'
                'http://secondary-ocsp-responder/ocsp'
                'http://tertiary-ocsp-responder/ocsp'
            )
            AllowRestartService = $true
        }
    }
}
```

### Example 4

This example will clear the Authority Information Access and Online Responder
OCSP URIs from the AIA and OCSP extensions respectively.

```powershell
configuration AdcsAuthorityInformationAccess_ClearAiaAndOcsp_Config
{
    Import-DscResource -ModuleName ActiveDirectoryCSDsc

    node localhost
    {
        AdcsAuthorityInformationAccess ClearAiaAndOcsp
        {
            IsSingleInstance    = 'Yes'
            AiaUri              = @()
            OcspUri             = @()
            AllowRestartService = $true
        }
    }
}
```


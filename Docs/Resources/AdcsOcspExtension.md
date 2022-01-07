# AdcsOcspExtension

## Parameters

| Parameter | Attribute | DataType | Description | Allowed Values |
| --- | --- | --- | --- | --- |
| **IsSingleInstance** | Key | String | Specifies the resource is a single instance, the value must be 'Yes'. |Yes|
| **OcspUriPath** | Required | String[] | Specifies the address of the OCSP responder from where revocation of this certificate can be checked. ||
| **RestartService** | Write | Boolean | Specifies if the CertSvc service should be restarted to immediately apply the settings. ||
| **Ensure** | Write | String | Specifies if the OCSP responder URI should be present or absent. |Present,  Absent|

## Description

This resource can be used to configure the OCSP URI extensions on the
Certificate Authority after the feature has been installed on the server.
Using this DSC Resource to configure an ADCS Certificate Authority assumes that
the `ADCS-Cert-Authority` feature has already been installed.

## Examples

### Example 1

A DSC configuration script to add desired OCSP URI path extensions for a Certificate Authority.
This will remove all existing OCSP URI paths from the Certificate Authority.

```powershell
configuration AdcsOcspExtension_AddOcspPath_Config
{
    Import-DscResource -ModuleName ActiveDirectoryCSDsc

    node localhost
    {
        AdcsOcspExtension AddOcspUriPath
        {
            IsSingleInstance = 'Yes'
            OcspUriPath      = @(
                'http://primary-ocsp-responder/ocsp'
                'http://secondary-ocsp-responder/ocsp'
                'http://tertiary-ocsp-responder/ocsp'
            )
            RestartService   = $true
            Ensure           = 'Present'
        }
    }
}
```

### Example 2

A DSC configuration script to remove desired OCSP URI path extensions for a Certificate Authority.
No previously configured OCSP URI paths will be removed.

```powershell
configuration AdcsOcspExtension_RemoveOcspPath_Config
{
    Import-DscResource -ModuleName ActiveDirectoryCSDsc

    node localhost
    {
        AdcsOcspExtension RemoveOcspUriPath
        {
            IsSingleInstance = 'Yes'
            OcspUriPath      = @(
                'http://primary-ocsp-responder/ocsp'
                'http://secondary-ocsp-responder/ocsp'
                'http://tertiary-ocsp-responder/ocsp'
            )
            RestartService   = $true
            Ensure           = 'Absent'
        }
    }
}
```


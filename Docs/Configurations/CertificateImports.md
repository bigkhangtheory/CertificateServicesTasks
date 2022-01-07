# CertificateImports



<br />

## Project Information

|                  |                                                                                                                          |
| ---------------- | ------------------------------------------------------------------------------------------------------------------------ |
| **Source**       | https://prod1gitlab.mapcom.local/dsc/configurations/CerificateServicesTasks/-/tree/master/CertificaeServicesTasks/DscResources/CertificateImports |
| **Dependencies** | [ActiveDirectoryCSDsc][ActiveDirectoryCSDsc], [xPSDesiredStateConfiguration][xPSDesiredStateConfiguration]                                 |
| **Resources**    | [xWindowsFeature][xWindowsFeature]                                                               |

<br />

## Parameters

<br />

### Table. Attributes of `CertificateImports`

| Parameter              | Attribute  | DataType        | Description                                                                                         | Allowed Values |
| :--------------------- | :--------- | :-------------- | :-------------------------------------------------------------------------------------------------- | :------------- |


---

<br />

## Example `CertificateImports`

```yaml
CertificateImports:
  Items:
    # Thumbprint
    #
    # The thumbprint (unique identifier) of the certificate you're importing.
    - Thumbprint: c81b94933420221a7ac004a90242d8b1d3e5070d

      # Path
      #
      # The path to the CER file you want to import.
      Path: \\Server\Share\Certificates\MyTrustedRoot.cer

      # Location
      #
      # The Windows Certificate Store Location to import the certificate to.
      # Allowed values: 'LocalMachine', 'CurrentUser'
      Location: LocalMachine

      # Store
      #
      # The Windows Certificate Store Name to import the certificate to.
      Store: My

      # FriendlyName
      #
      # The friendly name of the certificate to set in the Windows Certificate Store.
      FriendlyName: My Trusted Root Certificate

```

<br />

## Lookup Options in Datum.yml

```yaml
lookup_options:

  CertificateImports:
    merge_hash: deep

```

<br />

[ActiveDirectoryCSDsc]: https://github.com/dsccommunity/ActiveDirectoryCSDsc
[xPSDesiredStateConfiguration]: https://github.com/dsccommunity/xPSDesiredStateConfiguration
[xWindowsFeature]: https://github.com/dsccommunity/xPSDesiredStateConfiguration

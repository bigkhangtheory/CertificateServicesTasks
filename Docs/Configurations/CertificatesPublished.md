# CertificatesPublished



<br />

## Project Information

|                  |                                                                                                                          |
| ---------------- | ------------------------------------------------------------------------------------------------------------------------ |
| **Source**       | https://prod1gitlab.mapcom.local/dsc/configurations/CerificateServicesTasks/-/tree/master/CertificaeServicesTasks/DscResources/CertificatesPublished |
| **Dependencies** | [ActiveDirectoryCSDsc][ActiveDirectoryCSDsc], [xPSDesiredStateConfiguration][xPSDesiredStateConfiguration]                                 |
| **Resources**    | [xWindowsFeature][xWindowsFeature]                                                               |

<br />

## Parameters

<br />

### Table. Attributes of `CertificatesPublished`

| Parameter              | Attribute  | DataType        | Description                                                                                         | Allowed Values |
| :--------------------- | :--------- | :-------------- | :-------------------------------------------------------------------------------------------------- | :------------- |


---

<br />

## Example `CertificatesPublished`

```yaml
CertificatesPublished:
  # Items
  #
  # Specifies a list of CA template names on an Enterprise CA.
  Items:
    - Name: UserCertificate
      Ensure: Present

    - Name: RASAndIASServer
      Ensure: Present

    - Name: CodeSigning20yr
      Ensure: Present

    - Name: DirectoryEmailReplication
      Ensure: Present

    - Name: DomainControllerAuthentication
      Ensure: Present

    - Name: KerberosAuthentication
      Ensure: Present

    - Name: EFSRecovery
      Ensure: Present

    - Name: EFS
      Ensure: Present

    - Name: DomainController
      Ensure: Present

    - Name: WebServer
      Ensure: Present

    - Name: Machine
      Ensure: Present

    - Name: User
      Ensure: Present

    - Name: SubCA
      Ensure: Present

    - Name: Administrator
      Ensure: Present

```

<br />

## Lookup Options in Datum.yml

```yaml
lookup_options:

  CertificatesPublished:
    merge_hash: deep

```

<br />

[ActiveDirectoryCSDsc]: https://github.com/dsccommunity/ActiveDirectoryCSDsc
[xPSDesiredStateConfiguration]: https://github.com/dsccommunity/xPSDesiredStateConfiguration
[xWindowsFeature]: https://github.com/dsccommunity/xPSDesiredStateConfiguration

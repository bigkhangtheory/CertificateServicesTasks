# CertificateAuthorityExtensions



<br />

## Project Information

|                  |                                                                                                                          |
| ---------------- | ------------------------------------------------------------------------------------------------------------------------ |
| **Source**       | https://prod1gitlab.mapcom.local/dsc/configurations/CerificateServicesTasks/-/tree/master/CertificaeServicesTasks/DscResources/CertificateAuthorityExtensions |
| **Dependencies** | [ActiveDirectoryCSDsc][ActiveDirectoryCSDsc], [xPSDesiredStateConfiguration][xPSDesiredStateConfiguration]                                 |
| **Resources**    | [xWindowsFeature][xWindowsFeature]                                                               |

<br />

## Parameters

<br />

### Table. Attributes of `CertificateAuthorityExtensions`

| Parameter              | Attribute  | DataType        | Description                                                                                         | Allowed Values |
| :--------------------- | :--------- | :-------------- | :-------------------------------------------------------------------------------------------------- | :------------- |


---

<br />

## Example `CertificateAuthorityExtensions`

```yaml
CertificateAuthorityExtensions:
  # AuthorityInformationAccess
  #
  # AIA (Authority Information Access) is useful during the validation process of the certificate chain of trust.
  # The AIA URIs captures the location of the issuer certificate, and client can download a copy of the issuer certificate during each stage of validation.
  #
  # Specifies the list of URIs that should be included in the AIA extension of the issued certificate.
  AuthorityInformationAccess:
    - http://setAIATest1/Certs/<CATruncatedName>.cer
    - http://setAIATest2/Certs/<CATruncatedName>.cer
    - http://setAIATest3/Certs/<CATruncatedName>.cer
    - ldap://mapcom.local/cn=IssuerCert,ou=Enterprise,o=MAP,x=US?cACertificate;binary

  # OnlineResponderOCSP
  #
  # Used by a CA to answer certificate revocation requests.
  # Online Responder (Or OSCP Responder) is the server component, which accepts requests from OCSP client to check the revocation status of a certificate.
  # Before making the request, client uses AIA extension to check whether OSCP is configured, and if yes what is the OSCP responder location.
  #
  # The OCSP responder server FQDN must be specified in the AIA field.
  OnlineResponderOCSP:
    - http://dc1-oscp-srv01.mapcom.local/ocsp
    - http://dc2-ocsp-srv01.mapcom.local/ocsp

  # AllowServiceRestart
  #
  # Allows the Certificate Authority service to be restarted if changes are made. Defaults to false.
  AllowServiceRestart: false

```

<br />

## Lookup Options in Datum.yml

```yaml
lookup_options:

  CertificateAuthorityExtensions:
    merge_hash: deep

```

<br />

[ActiveDirectoryCSDsc]: https://github.com/dsccommunity/ActiveDirectoryCSDsc
[xPSDesiredStateConfiguration]: https://github.com/dsccommunity/xPSDesiredStateConfiguration
[xWindowsFeature]: https://github.com/dsccommunity/xPSDesiredStateConfiguration

# CertificateAuthorities



<br />

## Project Information

|                  |                                                                                                                          |
| ---------------- | ------------------------------------------------------------------------------------------------------------------------ |
| **Source**       | https://prod1gitlab.mapcom.local/dsc/configurations/CerificateServicesTasks/-/tree/master/CertificaeServicesTasks/DscResources/CertificateAuthorities |
| **Dependencies** | [ActiveDirectoryCSDsc][ActiveDirectoryCSDsc], [xPSDesiredStateConfiguration][xPSDesiredStateConfiguration]                                 |
| **Resources**    | [xWindowsFeature][xWindowsFeature]                                                               |

<br />

## Parameters

<br />

### Table. Attributes of `CertificateAuthorities`

| Parameter              | Attribute  | DataType        | Description                                                                                         | Allowed Values |
| :--------------------- | :--------- | :-------------- | :-------------------------------------------------------------------------------------------------- | :------------- |


---

<br />

## Example `CertificateAuthorities`

```yaml
CertificateAuthorities:
  # CAType
  #
  # Specifies the type of certification authority to install.
  # Possible values: 'EnterpriseRootCA', 'EnterpriseSubordinateCA', 'StandaloneRootCA', 'StandaloneSubordinateCA'
  CAType: EnterpriseSubordinateCA

  # Credential
  #
  # To install an enterprise certification authority, the computer must be joined to an Active Directory Domain Services domain and a user account that is a member of the Enterprise Admin group is required.
  Credential: '[ENC=PE9ianMgVmVyc2lvbj0iMS4xLjAuMSIgeG1sbnM9Imh0dHA6Ly9zY2hlbWFzLm1pY3Jvc29mdC5jb20vcG93ZXJzaGVsbC8yMDA0LzA0Ij4NCiAgPE9iaiBSZWZJZD0iMCI+DQogICAgPFROIFJlZklkPSIwIj4NCiAgICAgIDxUPlN5c3RlbS5NYW5hZ2VtZW50LkF1dG9tYXRpb24uUFNDdXN0b21PYmplY3Q8L1Q+DQogICAgICA8VD5TeXN0ZW0uT2JqZWN0PC9UPg0KICAgIDwvVE4+DQogICAgPE1TPg0KICAgICAgPE9iaiBOPSJLZXlEYXRhIiBSZWZJZD0iMSI+DQogICAgICAgIDxUTiBSZWZJZD0iMSI+DQogICAgICAgICAgPFQ+U3lzdGVtLk9iamVjdFtdPC9UPg0KICAgICAgICAgIDxUPlN5c3RlbS5BcnJheTwvVD4NCiAgICAgICAgICA8VD5TeXN0ZW0uT2JqZWN0PC9UPg0KICAgICAgICA8L1ROPg0KICAgICAgICA8TFNUPg0KICAgICAgICAgIDxPYmogUmVmSWQ9IjIiPg0KICAgICAgICAgICAgPFROUmVmIFJlZklkPSIwIiAvPg0KICAgICAgICAgICAgPE1TPg0KICAgICAgICAgICAgICA8UyBOPSJIYXNoIj44MDg1MzBFQzZDOUMyNENEODIzMjEyMkNBNDAwQUQyQjA4RUYwQTA0QjlGQzM2NUQxOUY1NTY3MjdEQjNDOUJEPC9TPg0KICAgICAgICAgICAgICA8STMyIE49Ikl0ZXJhdGlvbkNvdW50Ij41MDAwMDwvSTMyPg0KICAgICAgICAgICAgICA8QkEgTj0iS2V5Ij5leUt6OUNtWjhFRUoyVmlqR1dhYVVodW9IcEtCeEd6SmZza3F1L3JicWxXZzVoVXkwYWd5QW1xZnI5WWExbDAxPC9CQT4NCiAgICAgICAgICAgICAgPEJBIE49Ikhhc2hTYWx0Ij5nQ3NLTldCTUdRMjF0Smc1QVA1UXcyRGdoWDZpTkx2cy8vZHFQbE5PNExnPTwvQkE+DQogICAgICAgICAgICAgIDxCQSBOPSJTYWx0Ij54OVhLaTVPRVg3SXRsbnQySkRPY0tJdlNZLzN1V2dOQjBjWFpaSitpWjZBPTwvQkE+DQogICAgICAgICAgICAgIDxCQSBOPSJJViI+NUVpcFhyeVBSeDA3dDI2dk1mNGlPR0dURldiT2tzVDdraHRxcjNiM1NsND08L0JBPg0KICAgICAgICAgICAgPC9NUz4NCiAgICAgICAgICA8L09iaj4NCiAgICAgICAgPC9MU1Q+DQogICAgICA8L09iaj4NCiAgICAgIDxCQSBOPSJDaXBoZXJUZXh0Ij54OUp0WXZDbXFKQmpaVitqNmQxK3VUazBEM0FiZ3cvMTRJbk5EMEN2ZXZCVTlkUG5tL091WFR4bWdGVVQzaUlMdGYzRnNxQ0VVc29wYkhSaHBPdjE5dz09PC9CQT4NCiAgICAgIDxCQSBOPSJITUFDIj5pR3FoYkYwR0w5NUF6bDFSTVhMa0twQ2VNRXcwa29QeGtJd1NzMVczWU9vPTwvQkE+DQogICAgICA8UyBOPSJUeXBlIj5TeXN0ZW0uTWFuYWdlbWVudC5BdXRvbWF0aW9uLlBTQ3JlZGVudGlhbDwvUz4NCiAgICA8L01TPg0KICA8L09iaj4NCjwvT2Jqcz4=]'

  # Ensure
  #
  # Specifies whether the Certificate Authority should be installed or uninstalled.
  Ensure: Present

  # CACommonName
  #
  # Specifies the certification authority common name.
  CACommonName: MAP Issuing CA

  # CADistinguishedNameSuffix
  #
  # Specifies the certification authority distinguished name suffix.
  CADistinguishedNameSuffix: DC=mapcom,DC=local

  # CryptoProviderName
  #
  # The name of the cryptographic service provider or key storage provider that is used to generate or store the private key for the CA.
  CryptoProviderName: RSA#Microsoft Software Key Storage Provider

  # HashAlgorithmName
  #
  # Specifies the signature hash algorithm used by the certification authority.
  HashAlgorithmName: SHA1

  # KeyContainerName
  #
  # Specifies the name of an existing private key container.
  #KeyContainerName:

  # KeyLength
  #
  # Specifies the bit length for new certification authority key.
  KeyLength: 2048

  # DatabaseDirectory
  #
  # Specifies the folder location of the certification authority database.
  DatabaseDirectory: C:\Windows\system32\CertLog

  # LogDirectory
  #
  # Specifies the folder location of the certification authority database log.
  LogDirectory: C:\Windows\system32\CertLog

  # ParentCA
  #
  # Specifies the configuration string of the parent certification authority that will certify this CA.
  ParentCA: DC-ROOTCA-SRV01

  # AdvancedSettings
  #
  # This resource can be used to configure the advanced settings of an Active Directory Certificate Services instance.
  AdvancedSettings:
    # CACertPublicationURLs
    #
    # Specifies an array of Certificate Authority certificate publication URLs, each prepended with an integer representing the type of URL endpoint.
    CACertPublicationURLs:
      - 1:C:\Windows\system32\CertSrv\CertEnroll\%1_%3%4.crt
      - 2:ldap:///CN=%7,CN=AIA,CN=Public Key Services,CN=Services,%6%11
      - 2:http://dc-adcs-srv01.ampcom.local/CertEnroll/%1_%3%4.crt

    # CRLPublicationURLs
    #
    # Specifies an array of Certificate Revocation List publication URLs, each prepended with an integer representing the type of URL endpoint.
    CRLPublicationURLs:
      - 65:C:\Windows\system32\CertSrv\CertEnroll\%3%8%9.crl
      - 79:ldap:///CN=%7%8,CN=%2,CN=CDP,CN=Public Key Services,CN=Services,%6%10
      - 6:http://dc-adcs-srv01.mapcom.local/CertEnroll/%3%8%9.crl

    # CRLOverlapUnits
    #
    # Specifies the number of units for the certificate revocation list overlap period.
    CRLOverlapUnits: 8

    # CRLOverlapPeriod
    #
    # Specifies the units of measurement for the certificate revocation list overlap period.
    # Possible values include: Hours, Days, Weeks, Months, Years
    CRLOverlapPeriod: Hours

    # CRLPeriodUnits
    #
    # Specifies the number of units for the certificate revocation period.
    CRLPeriodUnits: 1

    # CRLPeriod
    #
    # Specifies the units of measurement for the certificate revocation period.
    # Possible values include: Hours, Days, Weeks, Months, Years
    CRLPeriod: Months

    # ValidityPeriodUnits
    #
    # Specifies the number of units for the validity period of certificates issued by this certificate authority.
    ValidityPeriodUnits: 3

    # ValidityPeriod
    #
    # Specifies the units of measurement for the validity period of certificates issued by this certificate authority.
    # Possible values include: Hours, Days, Weeks, Months, Years
    ValidityPeriod: Years

    # DSConfigDN
    #
    # Specifies the distinguished name of the directory services configuration object that contains this certificate authority in the Active Directory.
    DSConfigDN: CN=Configuration,DC=mapcom,DC=local

    # DSDomainDN
    #
    # Specifies the distinguished name of the directory services object that contains this certificate authority in the Active Directory.
    DSDomainDN: DC=mapcom,DC=local

    # AuditFilter
    #
    # Specifies an array of audit categories to enable audit logging for.
    # Possible values include: StartAndStopADCS, BackupAndRestoreCADatabase, IssueAndManageCertificateRequests, RevokeCertificatesAndPublishCRLs, ChangeCASecuritySettings, StoreAndRetrieveArchivedKeys, ChangeCAConfiguration
    AuditFilter:
      - StartAndStopADCS
      - BackupAndRestoreCADatabase
      - IssueAndManageCertificateRequests
      - RevokeCertificatesAndPublishCRLs
      - ChangeCASecuritySettings
      - StoreAndRetrieveArchivedKeys
      - ChangeCAConfiguration
  #end CertificateAuthorities

```

<br />

## Lookup Options in Datum.yml

```yaml
lookup_options:

  CertificateAuthorities:
    merge_hash: deep

```

<br />

[ActiveDirectoryCSDsc]: https://github.com/dsccommunity/ActiveDirectoryCSDsc
[xPSDesiredStateConfiguration]: https://github.com/dsccommunity/xPSDesiredStateConfiguration
[xWindowsFeature]: https://github.com/dsccommunity/xPSDesiredStateConfiguration

# CertificateExports



<br />

## Project Information

|                  |                                                                                                                          |
| ---------------- | ------------------------------------------------------------------------------------------------------------------------ |
| **Source**       | https://prod1gitlab.mapcom.local/dsc/configurations/CerificateServicesTasks/-/tree/master/CertificaeServicesTasks/DscResources/CertificateExports |
| **Dependencies** | [ActiveDirectoryCSDsc][ActiveDirectoryCSDsc], [xPSDesiredStateConfiguration][xPSDesiredStateConfiguration]                                 |
| **Resources**    | [xWindowsFeature][xWindowsFeature]                                                               |

<br />

## Parameters

<br />

### Table. Attributes of `CertificateExports`

| Parameter              | Attribute  | DataType        | Description                                                                                         | Allowed Values |
| :--------------------- | :--------- | :-------------- | :-------------------------------------------------------------------------------------------------- | :------------- |


---

<br />

## Example `CertificateExports`

```yaml
CertificateExports:
  Items:
    # Path
    #
    # The path to the file you that will contain the exported certificate.
    - Path: C:\sslcert.cer

      # Friendly Name
      #
      #
      FriendlyName: Web Site SSL Certificate for www.contoso.com

      # Type
      #
      # Specifies the type of certificate to export.
      # Allowed values: 'Cert', 'P7B', 'SST', 'PFX'
      Type: Cert

      # Path
      #
      # The path to the file you that will contain the exported certificate.
    - Path: C:\sslcert.pfx

      # Friendly Name
      #
      #
      FriendlyName: Web Site SSL Certificate for www.contoso.com

      # Type
      #
      # Specifies the type of certificate to export.
      # Allowed values: 'Cert', 'P7B', 'SST', 'PFX'
      Type: PFX
      Password: "[ENC=PE9ianMgVmVyc2lvbj0iMS4xLjAuMSIgeG1sbnM9Imh0dHA6Ly9zY2hlbWFzLm1pY3Jvc29mdC5jb20vcG93ZXJzaGVsbC8yMDA0LzA0Ij4NCiAgPE9iaiBSZWZJZD0iMCI+DQogICAgPFROIFJlZklkPSIwIj4NCiAgICAgIDxUPlN5c3RlbS5NYW5hZ2VtZW50LkF1dG9tYXRpb24uUFNDdXN0b21PYmplY3Q8L1Q+DQogICAgICA8VD5TeXN0ZW0uT2JqZWN0PC9UPg0KICAgIDwvVE4+DQogICAgPE1TPg0KICAgICAgPE9iaiBOPSJLZXlEYXRhIiBSZWZJZD0iMSI+DQogICAgICAgIDxUTiBSZWZJZD0iMSI+DQogICAgICAgICAgPFQ+U3lzdGVtLk9iamVjdFtdPC9UPg0KICAgICAgICAgIDxUPlN5c3RlbS5BcnJheTwvVD4NCiAgICAgICAgICA8VD5TeXN0ZW0uT2JqZWN0PC9UPg0KICAgICAgICA8L1ROPg0KICAgICAgICA8TFNUPg0KICAgICAgICAgIDxPYmogUmVmSWQ9IjIiPg0KICAgICAgICAgICAgPFROUmVmIFJlZklkPSIwIiAvPg0KICAgICAgICAgICAgPE1TPg0KICAgICAgICAgICAgICA8UyBOPSJIYXNoIj44MDg1MzBFQzZDOUMyNENEODIzMjEyMkNBNDAwQUQyQjA4RUYwQTA0QjlGQzM2NUQxOUY1NTY3MjdEQjNDOUJEPC9TPg0KICAgICAgICAgICAgICA8STMyIE49Ikl0ZXJhdGlvbkNvdW50Ij41MDAwMDwvSTMyPg0KICAgICAgICAgICAgICA8QkEgTj0iS2V5Ij5leUt6OUNtWjhFRUoyVmlqR1dhYVVodW9IcEtCeEd6SmZza3F1L3JicWxXZzVoVXkwYWd5QW1xZnI5WWExbDAxPC9CQT4NCiAgICAgICAgICAgICAgPEJBIE49Ikhhc2hTYWx0Ij5nQ3NLTldCTUdRMjF0Smc1QVA1UXcyRGdoWDZpTkx2cy8vZHFQbE5PNExnPTwvQkE+DQogICAgICAgICAgICAgIDxCQSBOPSJTYWx0Ij54OVhLaTVPRVg3SXRsbnQySkRPY0tJdlNZLzN1V2dOQjBjWFpaSitpWjZBPTwvQkE+DQogICAgICAgICAgICAgIDxCQSBOPSJJViI+NUVpcFhyeVBSeDA3dDI2dk1mNGlPR0dURldiT2tzVDdraHRxcjNiM1NsND08L0JBPg0KICAgICAgICAgICAgPC9NUz4NCiAgICAgICAgICA8L09iaj4NCiAgICAgICAgPC9MU1Q+DQogICAgICA8L09iaj4NCiAgICAgIDxCQSBOPSJDaXBoZXJUZXh0Ij54OUp0WXZDbXFKQmpaVitqNmQxK3VUazBEM0FiZ3cvMTRJbk5EMEN2ZXZCVTlkUG5tL091WFR4bWdGVVQzaUlMdGYzRnNxQ0VVc29wYkhSaHBPdjE5dz09PC9CQT4NCiAgICAgIDxCQSBOPSJITUFDIj5pR3FoYkYwR0w5NUF6bDFSTVhMa0twQ2VNRXcwa29QeGtJd1NzMVczWU9vPTwvQkE+DQogICAgICA8UyBOPSJUeXBlIj5TeXN0ZW0uTWFuYWdlbWVudC5BdXRvbWF0aW9uLlBTQ3JlZGVudGlhbDwvUz4NCiAgICA8L01TPg0KICA8L09iaj4NCjwvT2Jqcz4=]"

```

<br />

## Lookup Options in Datum.yml

```yaml
lookup_options:

  CertificateExports:
    merge_hash: deep

```

<br />

[ActiveDirectoryCSDsc]: https://github.com/dsccommunity/ActiveDirectoryCSDsc
[xPSDesiredStateConfiguration]: https://github.com/dsccommunity/xPSDesiredStateConfiguration
[xWindowsFeature]: https://github.com/dsccommunity/xPSDesiredStateConfiguration
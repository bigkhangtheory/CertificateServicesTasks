<#
    .DESCRIPTION
        This DSC composite resource is used to request a new certificate from a Certificate Authority on a target node.

    .PARAMETER Items
        Specifies a list of DSC resources for CertReq

    .LINK
        https://github.com/dsccommunity/CertificateDsc/wiki/CertReq

    .NOTES
        Author:     Khang M. Nguyen
        Created:    2021.10.31
#>
#Requires -Module CertificateDsc


configuration CertificateRequests
{
    param
    (
        [Parameter()]
        [System.Collections.Hashtable[]]
        $Items
    )

    <#
        Import required modules
    #>
    Import-DscResource -ModuleName CertificateDsc


    <#
        If specified, enmerate all items and create DSC resource
    #>
    if ($Items)
    {
        foreach ($i in $Items)
        {
            # remove case sensitivity for ordered Dictionary or Hashtables
            $i = @{ } + $i

            # if 'CertificateTemplate' not specified, throw Error and exit
            if ([System.String]::IsNullOrWhitespace($i.CertificateTemplate))
            {
                throw 'ERROR: A CertificateTemplate name must be specified.'
            }

            # if Subject not specified, default to target node name
            if ([System.String]::IsNullOrWhitespace($i.Subject))
            {
                $i.Subject = [System.Net.Dns]::GetHostByName("$($node.Name)").HostName
            }

            # if CAType not specified, default to 'Enterprise'
            if ([System.String]::IsNullOrWhitespace($i.CAType))
            {
                $i.CAType = 'Enterprise'
            }

            # if Certificate Authority is specified, then wait for the CA to be availible
            if ($i.CAType -eq 'Enterprise' -and ($i.ContainsKey('CAServerFQDN') -and $i.ContainsKey('CARootName')))
            {
                # create execution name for the resource
                $executionName = "$($i.CAServerFQDN -replace '[-().:\s]', '_')_$($i.CARootName -replace '[-().:\s]', '_')"
                # create DSC resource to wait for CA to be availible
                WaitForCertificateServices "$executionName"
                {
                    CAServerFQDN         = $i.CAServerFQDN
                    CARootName           = $i.CARootName
                    RetryIntervalSeconds = 10
                    RetryCount           = 60
                }

                # append dependency to parameter hashtable
                $i.DependsOn = "[WaitForCertificateServices]$executionName"
            } #end if


            # if 'KeyLength' not specified, default to 2048
            if (-not $i.ContainsKey('KeyLength'))
            {
                $i.KeyLength = '2048'
            }

            # if 'Exportable' not specified, default to true
            if (-not $i.ContainsKey('Exportable'))
            {
                $i.Exportable = $true
            }

            # if 'ProviderName' not specified, set defaults
            if (-not $i.ContainsKey('ProviderName'))
            {
                $i.ProviderName = 'Microsoft RSA SChannel Cryptographic Provider'
            }

            # if 'Autorenew' not specified, set default to true
            if (-not $i.ContainsKey('AutoRenew'))
            {
                $i.AutoRenew = $true
            }

            # if 'KeyType' not specified, set defaults to 'RSA'
            if (-not $i.ContainsKey('KeyType'))
            {
                $i.KeyType = 'RSA'
            }

            # if 'RequestType' not specified, set defaults to 'CMC'
            if (-not $i.ContainsKey('RequestType'))
            {
                $i.RequestType = 'CMC'
            }


            # create execution name for the resource
            $executionName = "$($i.CertificateTemplate -replace '[-().:\s]', '_')_$($i.Subject -replace '[-().:\s]', '_')"

            # create DSC resource for Certificate exports
            $Splatting = @{
                ResourceName  = 'CertReq'
                ExecutionName = $executionName
                Properties    = $i
                NoInvoke      = $true
            }
            (Get-DscSplattedResource @Splatting).Invoke($i)
        } #end foreach
    } #end if
} #end configuration
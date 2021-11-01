<#
    .DESCRIPTION
        This DSC composite resource is used to export a certificate from the Windows certificate store on a target node.

    .PARAMETER Items
        Specifies a list of DSC resources for CertificateExport

    .LINK
        https://github.com/dsccommunity/CertificateDsc/wiki/CertificateExport

    .NOTES
        Author:     Khang M. Nguyen
        Created:    2021.10.31
#>
#Requires -Module CertificateDsc


configuration CertificateExports
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
            # if Path not specified, throw Error and exit
            if ([System.String]::IsNullOrWhitespace($i.Path))
            {
                throw "ERROR: 'Path' must be specified for the resource."
            }

            # if a Certificate selector is not specified, throw Error and exit
            if ([System.String]::IsNullOrWhitespace($i.Thumbprint) -and
                [System.String]::IsNullOrWhitespace($i.FriendlyName) -and
                [System.String]::IsNullOrWhitespace($i.Subject) -and
                [System.String]::IsNullOrWhitespace($i.DnsName) -and
                [System.String]::IsNullOrWhitespace($i.Issuer) -and
                [System.String]::IsNullOrWhitespace($i.KeyUsage))
            {
                throw "ERROR: A Certificate selector parameter must be specified. Accepted selectors include: 'Thumbprint', 'FriendlyName', 'Subject', 'DnsName', 'Issuer', or 'KeyUsage'."
            }
            <#
            # if 'Type' not specifed with 'Cert', 'P7B', 'SST', or 'PFX', throw Error and exit
            if (-not (@('Cert', 'P7B', 'SST', 'PFX') -in $i.Type))
            {
                throw "ERROR: The specified export type is not valid. Accepted values include: 'Cert', 'P7B', 'SST', or 'PFX'."
            }
            #>
            # if 'Type' is 'PFX', must include 'Password' or 'ProtectTo'
            #if ($i.Type -eq 'PFX')
            #{
            #    if (($null -eq $i.Password) -or ($null -eq $i.ProtectTo))
            #    {
            #        throw "ERROR: Type 'PFX' must include either 'Password' or 'ProtectTo'."
            #    }
            #}
            # create execution name for the resource
            $executionName = "$($i.Path -replace '[-().:\\\s]', '_')_$($i.Type)"

            # create DSC resource for Certificate exports
            $Splatting = @{
                ResourceName  = 'CertificateExport'
                ExecutionName = $executionName
                Properties    = $i
                NoInvoke      = $true
            }
            (Get-DscSplattedResource @Splatting).Invoke($i)
        } #end foreach
    } #end if
} #end configuration
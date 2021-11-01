<#
    .DESCRIPTION
        This DSC composite resource is used to import a certificate into the Windows certificate store on a target node.

    .PARAMETER Items
        Specifies a list of DSC resources for CertificateImport

    .LINK
        https://github.com/dsccommunity/CertificateDsc/wiki/CertificateImport

    .NOTES
        Author:     Khang M. Nguyen
        Created:    2021.10.31
#>
#Requires -Module CertificateDsc


configuration CertificateImports
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

            # if Path not specified, throw Error and exit
            if ([System.String]::IsNullOrWhitespace($i.Path) -and [System.String]::IsNullOrWhitespace($i.Thumbprint))
            {
                throw "ERROR: The certificate 'Path' or 'Thumbprint' must be specified for the resource."
            }

            # if 'Location' is not 'LocalMachine' or 'CurrentUser', set defaults
            if (-not $i.ContainsKey('Location'))
            {
                $i.Location = 'LocalMachine'
            }

            # if 'Store' not specified, default to Personal store
            if (-not $i.ContainsKey('Store'))
            {
                $i.Store = 'My'
            }

            # if not specified, ensure 'Present'
            if (-not $i.ContainsKey('Ensure'))
            {
                $i.Ensure = 'Present'
            }

            # create execution name for the resource
            $executionName = "$($i.Path -replace '[-().:\\\s]', '_')_$($i.Location)_$($i.Store)"

            # create DSC resource for Certificate exports
            $Splatting = @{
                ResourceName  = 'CertificateImport'
                ExecutionName = $executionName
                Properties    = $i
                NoInvoke      = $true
            }
            (Get-DscSplattedResource @Splatting).Invoke($i)
        } #end foreach
    } #end if
} #end configuration
<#
    .DESCRIPTION
        This DSC configuration adds or removes Certificate Authority templates from an Enterprise CA.
    .PARAMETER Items
        Specifies a list of CA template names on an Enterprise CA.
    .LINK
        https://github.com/dsccommunity/ActiveDirectoryCSDsc/wiki/AdcsTemplate
    .NOTES
        Author:     Khang M. Nguyen
        Created:    2021-09-03
#>
#Requires -Module ActiveDirectoryCSDsc


configuration CertificatesPublished
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
    Import-DscResource -ModuleName ActiveDirectoryCSDsc


    <#
        Create DSC resource for 'AdcsTemplate'
    #>
    foreach ($i in $Items)
    {
        # remove case sensitivity of ordered Dictionary or Hashtables
        $i = @{ } + $i

        # if not specified, ensure 'Present'
        if (-not $i.ContainsKey('Ensure'))
        {
            $i.Ensure = 'Present'
        }

        # create execution name for the resource
        $executionName = "$($i.Name -replace '[-().:\s]', '_')_$($i.Ensure)"

        # create DSC resource
        AdcsTemplate "$executionName"
        {
            Name   = $i.Name
            Ensure = $i.Ensure
        }
    } #end foreach
} #end configuration
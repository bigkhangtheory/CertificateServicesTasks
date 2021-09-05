<#
    .DESCRIPTION
        This DSC configuration adds or removes Certificate Authority templates from an Enterprise CA.
    .PARAMETER Templates
        Specifies a list of CA template names on an Enterprise CA.
    .LINK
        https://github.com/dsccommunity/ActiveDirectoryCSDsc/wiki/AdcsTemplate
    .NOTES
        Author:     Khang M. Nguyen
        Created:    2021-09-03
#>
#Requires -Module ActiveDirectoryCSDsc


configuration CertificateTemplates
{
    param
    (
        [Parameter(Mandatory)]
        [ValidateNotNullOrEmpty()]
        [System.Collections.Hashtable[]]
        $Templates
    )

    <#
        Import required modules
    #>
    Import-DscResource -ModuleName ActiveDirectoryCSDsc
    

    <#
        Create DSC resource for 'AdcsTemplate'
    #>
    foreach ($t in $Templates)
    {
        # remove case sensitivity of ordered Dictionary or Hashtables
        $t = @{ } + $t

        # if not specified, ensure 'Present'
        if (-not $t.ContainsKey('Ensure'))
        {
            $t.Ensure = 'Present'
        }

        # create execution name for the resource
        $executionName = "$($t.Name -replace '[-().:\s]', '_')_$($t.Ensure)"

        # create DSC resource
        $Splatting = @{
            ResourceName  = 'AdcsTemplate'
            Executionname = $executionName
            Properties    = $t
            NoInvoke      = $true
        }
        (Get-DscSplattedResource @Splatting).Invoke($t)
    } #end foreach
} #end configuration
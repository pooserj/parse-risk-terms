#  Usage:  .\Get-Terms.ps1 "sites.csv" "risk"

param(
    $siteCsv = "sites.csv",
    $term = "risk"
)

$siteList = Import-Csv $siteCsv

$results = @()

foreach ($site in $siteList) {
    $siteString =  (Invoke-WebRequest -Uri $site.Url).ToString()
    $termCount  =  ([regex]::Matches($sitestring.ToLower(), $term)).count
    
    $results += [pscustomobject]@{
        URL   = $site.Url
        Term  = $term
        Count = $termCount
    }
}

return $results
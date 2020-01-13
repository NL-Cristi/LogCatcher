param (
    [Parameter()]
    [String] $CLIZipLocation=$ZipLocation,
    [int32] $CLILogAge = $LogAge,
    [String] $CLISiteIds = $SiteIds
)
. $scriptPath\General\CatchFilteredIISzip.ps1
. $scriptPath\General\GetIISStuff.ps1
. $scriptPath\General\PopulateFilteredLogDefinition.ps1

Get-IIS-Stuff
if ($CLILogAge -eq 0) 
{ $MaxDays = $Global:DefaultMaxDays }
else 
{ $MaxDays = $CLILogAge }

if (!$CLISiteIds) { 
    $stringFilteredSitesIDs = $DefaultFilteredSitesIDs
    $FilteredSitesIDs = $stringFilteredSitesIDs.split(",", [System.StringSplitOptions]::RemoveEmptyEntries)
}
else{
    $FilteredSitesIDs = $CLISiteIds.split(",", [System.StringSplitOptions]::RemoveEmptyEntries)
}

if ($CLIZipLocation) { 
    $Global:ZipOutput = $CLIZipLocation
    }

CatchFilteredIISzip -ea silentlycontinue -ErrorVariable +ErrorMessages
Write-Output "Zip can be found at the following path: $FilteredZipFile"

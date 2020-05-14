$Global:FilteredIISLogsDefinition = "$scriptPath\LogsDefinition\LogsInfo.CSV"
$Global:ContentStructure = "$scriptPath\LogsDefinition\FolderContents.txt"
$Global:FormLocation = "$scriptPath\Form\Form.xml"
$Global:ToolLog = "$scriptPath\ScriptLog\ToolLog.log"
$Global:ZipOutput = "$scriptPath" #if you want to revert to Original replace with : $Global:ZipOutput = "$scriptPath"
$Global:DefaultMaxDays = "2"
$Global:CurentSites = @()
$sitesInfo = Get-Website | Sort-Object -Property id
foreach ($siteinfo in $sitesInfo)
{ $Global:CurentSites += $siteinfo.id }
$Global:DefaultFilteredSitesIDs = $Global:CurentSites -join ","
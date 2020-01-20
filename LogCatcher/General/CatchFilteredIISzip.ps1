function CatchFilteredIISzip {
    $date = Get-Date -Format "yyyy-MM-dd-T-HH-mm-ss"
    $Time = Get-Date 
    "$Time Tool was run with for the SiteIDS: $FilteredSitesIDs with LogAge filter set at $MaxDays" | Out-File $ToolLog -Append
    PopulateFilteredLogDefinition | Out-Null
    $FilteredLOGSDefinitions = Import-Csv $FilteredIISLogsDefinition
    $FilteredTempLocation = $scriptPath + "\FilteredMSDT"
    If (Test-path $FilteredTempLocation) { Get-ChildItem $FilteredTempLocation | Remove-Item -Recurse -ErrorAction silentlycontinue -ErrorVariable +ErrorMessages }
    new-item -Path $scriptPath -ItemType "directory" -Name "FilteredMSDT" -ErrorAction silentlycontinue -ErrorVariable +ErrorMessages | Out-Null
    $Global:FilteredZipFile = $ZipOutput + "\LOGS-" + $date + ".zip"
    If (Test-path $FilteredZipFile) { Remove-item $FilteredZipFile -Force } 
    $GeneralTempLocation = $FilteredTempLocation + "\General"
$SiteTempLocation = $FilteredTempLocation + "\Sites"
foreach ($FilteredLogDefinition in $FilteredLOGSDefinitions) {
    if ($FilteredLogDefinition.Level -eq 'Site')
 {
        if ($FilteredLogDefinition.Product -eq "SitePath" ) {
            $idFloder = $SiteTempLocation + "\" + $FilteredLogDefinition.LogName
            
            new-item -Path $SiteTempLocation -ItemType "directory" -Name $FilteredLogDefinition.LogName -ErrorAction silentlycontinue -ErrorVariable +ErrorMessages | Out-Null
            Robocopy.exe $FilteredLogDefinition.Location $idFloder *.config /s | Out-Null
        }
        else {
            $idFloder = $SiteTempLocation + "\" + $FilteredLogDefinition.LogName
            $SiteLogs = $idFloder + "\IISLogs"
            Robocopy.exe $FilteredLogDefinition.Location $SiteLogs /s /maxage:$MaxDays | Out-Null
        }
 
    }
    else{
        if( $FilteredLogDefinition.TypeInfo -eq "Folder" ){
            if( $FilteredLogDefinition.LogName -eq "HTTPERRLog" ){
                $httperr = $GeneralTempLocation+"\HttpERR"
                Robocopy.exe $FilteredLogDefinition.Location $httperr /s | Out-Null
            }
            else{
            Robocopy.exe $FilteredLogDefinition.Location $GeneralTempLocation *.config /s | Out-Null
        }}
        else {
            Copy-Item -Path $FilteredLogDefinition.Location -Destination $GeneralTempLocation -Recurse -Force -ErrorAction silentlycontinue -ErrorVariable +ErrorMessages
 
        }
    }
 }

    $ExcludeFilter = @()
    $Errlog = "HTTP*"
    $ExcludeFilter += $Errlog
    foreach ($id in $FilteredSitesIDs) {
        $stringtoADD = "*" + $id
        $ExcludeFilter += $stringtoADD
    }
    GenerateSiteOverview | Out-Null
    $logName = $GeneralTempLocation+"\SiteOverview.csv"
    $Global:SiteOverview | Export-csv -Path $logName -NoTypeInformation -Force -ErrorAction silentlycontinue -ErrorVariable +ErrorMessages

    Add-Type -assembly "system.io.compression.filesystem"
    [io.compression.zipfile]::CreateFromDirectory($FilteredTempLocation, $FilteredZipFile) 
    
  Remove-Item -Recurse $FilteredTempLocation -Force -ErrorAction silentlycontinue -ErrorVariable +ErrorMessages
    Foreach ($Message in $ErrorMessages) {
        $Time = Get-Date
        $ErroText = $Message.Exception.Message
        "$Time Exception Message: $ErroText" | Out-File $ToolLog -Append
    }
    "$Time Tool has Finished running!" | Out-File $ToolLog -Append
}
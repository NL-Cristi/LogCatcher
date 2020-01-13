function CatchFilteredIISzip {
    $date = Get-Date -Format "yyyy-MM-dd-T-HH-mm-ss"
    $Time = Get-Date 
    "$Time Tool was run with for the SiteIDS: $FilteredSitesIDs with LogAge filter set at $MaxDays" | Out-File $ToolLog -Append
    PopulateFilteredLogDefinition | Out-Null
    $FilteredLOGSDefinitions = Import-Csv $FilteredIISLogsDefinition
    $FilteredTempLocation = $scriptPath + "\FilteredMSDT"
    new-item -Path $scriptPath -ItemType "directory" -Name "FilteredMSDT" -ErrorAction silentlycontinue -ErrorVariable +ErrorMessages | Out-Null
    #$FilteredZipFile = $scriptPath + "\Logs-"+$date+".zip"
    If (Test-path $FilteredTempLocation) { Get-ChildItem $FilteredTempLocation | Remove-Item -Recurse -ErrorAction silentlycontinue -ErrorVariable +ErrorMessages }
    $Global:FilteredZipFile = $ZipOutput + "\LOGS-" + $date + ".zip"
    If (Test-path $FilteredZipFile) { Remove-item $FilteredZipFile -Force } 
    Copy-Item -Path $FilteredIISLogsDefinition -Destination $FilteredTempLocation -Recurse -Force
    foreach ($FilteredLogDefinition in $FilteredLOGSDefinitions) {
        if ($FilteredLogDefinition.TypeInfo -eq 'Folder' -and $FilteredLogDefinition.Level -eq 'Site' ) { 
            $FilteredSourceLocation = (Get-Item $FilteredLogDefinition.Location -ErrorAction silentlycontinue -ErrorVariable +ErrorMessages).Parent.FullName
            Robocopy.exe $FilteredSourceLocation $FilteredTempLocation /s /maxage:$MaxDays | Out-Null
        }
        Elseif ($FilteredLogDefinition.Location -like '*web*') { 
            $FilteredDestination = $FilteredTempLocation + "\" + $FilteredLogDefinition.LogName + "_web.config"
            Copy-Item -Path $FilteredLogDefinition.Location -Destination $FilteredDestination -Recurse -Force -ErrorAction silentlycontinue -ErrorVariable +ErrorMessages
        }
        else {
            Copy-Item -Path $FilteredLogDefinition.Location -Destination $FilteredTempLocation -Recurse -Force -ErrorAction silentlycontinue -ErrorVariable +ErrorMessages
        }
    }
    $ExcludeFilter = @()
    $Errlog = "HTTP*"
    $ExcludeFilter += $Errlog
    foreach ($id in $FilteredSitesIDs) {
        $stringtoADD = "*" + $id
        $ExcludeFilter += $stringtoADD
    }
    Get-ChildItem $FilteredTempLocation -Directory -Exclude $ExcludeFilter | Remove-Item -Force -Recurse
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
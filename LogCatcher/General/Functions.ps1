Function Get-IIS-Stuff {

    $Time = Get-Date
    try {
        Import-Module IISAdministration -ErrorAction Stop
    }
    
    catch {
        $Time = Get-Date
        $firsttry = "$Time Exception Message: $($_.Exception.Message)" | Out-File $IISRelated -Append
    }
    
    try {
        Import-Module WebAdministration -ErrorAction Stop
    }
    catch {  
        $secondtry = "$Time Exception Message: $($_.Exception.Message)" | Out-File $IISRelated -Append
    }
    
}
Function PopulateLogDefinition { 
    Get-IIS-Stuff
    #region LogDefinition

    $LogDef = @()

    #endregion

    #region getSiteData
    $sitesInfo = Get-Website
    foreach ($siteinfo in $sitesInfo) {
        #region LogDefQuery
        $LogDefQuery = New-Object PsObject
        $LogDefQuery | Add-Member -MemberType NoteProperty -Name ComputerName -Value ''
        $LogDefQuery | Add-Member -MemberType NoteProperty -Name LogName -Value ''
        $LogDefQuery | Add-Member -MemberType NoteProperty -Name Product -Value ''
        $LogDefQuery | Add-Member -MemberType NoteProperty -Name Location -Value ''
        $LogDefQuery | Add-Member -MemberType NoteProperty -Name TypeInfo -Value ''
        $LogDefQuery | Add-Member -MemberType NoteProperty -Name Level -Value ''
        #endregion
        $LogDefQuery.ComputerName = $env:COMPUTERNAME
        $LogDefQuery.Level = "Site"
        $VAR = ("IIS:\Sites\" + $siteinfo.name)
        $LogDefQuery.Location = (Get-WebConfigFile $VAR).FullName
        $LogDefQuery.LogName = $siteinfo.Name
        $LogDefQuery.Product = "IIS"
        $LogDefQuery.TypeInfo = "File"

        $LogDef += $LogDefQuery

    }
    #endregion

    #region getSiteLogs
    $sitesInfo = Get-Website
    foreach ($siteinfo in $sitesInfo) {
        #region LogDefQuery
        $LogDefQuery = New-Object PsObject
        $LogDefQuery | Add-Member -MemberType NoteProperty -Name ComputerName -Value ''
        $LogDefQuery | Add-Member -MemberType NoteProperty -Name LogName -Value ''
        $LogDefQuery | Add-Member -MemberType NoteProperty -Name Product -Value ''
        $LogDefQuery | Add-Member -MemberType NoteProperty -Name Location -Value ''
        $LogDefQuery | Add-Member -MemberType NoteProperty -Name TypeInfo -Value ''
        $LogDefQuery | Add-Member -MemberType NoteProperty -Name Level -Value ''
        #endregion
        $LogDefQuery.ComputerName = $env:COMPUTERNAME
        $LogDefQuery.Level = "Site"
        $LogDefQuery.Location = $siteinfo.logFile.directory + "\W3SVC" + $siteinfo.id -replace "%SystemDrive%", "$env:SystemDrive"
        $LogDefQuery.LogName = $siteinfo.Name
        $LogDefQuery.Product = "IIS"
        $LogDefQuery.TypeInfo = "Folder"
        $LogDef += $LogDefQuery
     

    }    
	    #region getSiteFREBS

	    $sitesInfo = Get-Website
    foreach ($siteinfo in $sitesInfo) {
        #region LogDefQuery
        $LogDefQuery = New-Object PsObject
        $LogDefQuery | Add-Member -MemberType NoteProperty -Name ComputerName -Value ''
        $LogDefQuery | Add-Member -MemberType NoteProperty -Name LogName -Value ''
        $LogDefQuery | Add-Member -MemberType NoteProperty -Name Product -Value ''
        $LogDefQuery | Add-Member -MemberType NoteProperty -Name Location -Value ''
        $LogDefQuery | Add-Member -MemberType NoteProperty -Name TypeInfo -Value ''
        $LogDefQuery | Add-Member -MemberType NoteProperty -Name Level -Value ''
        #endregion
        if ($siteinfo.traceFailedRequestsLogging.enabled -eq "True")
        {
        $LogDefQuery.ComputerName = $env:COMPUTERNAME
        $LogDefQuery.Level = "Site"
        $LogDefQuery.Location = $siteinfo.traceFailedRequestsLogging.directory + "\W3SVC" + $siteinfo.id -replace "%SystemDrive%", "$env:SystemDrive"
        $LogDefQuery.LogName = $siteinfo.Name
        $LogDefQuery.Product = "FREB"
        $LogDefQuery.TypeInfo = "Folder"
        $LogDef += $LogDefQuery
        }

    }    
    $LogDef |Format-Table -AutoSize

    #endregion


    #region GetIISSeerverConfig

    #region LogDefQuery
    $LogDefQuery = New-Object PsObject
    $LogDefQuery | Add-Member -MemberType NoteProperty -Name ComputerName -Value ''
    $LogDefQuery | Add-Member -MemberType NoteProperty -Name LogName -Value ''
    $LogDefQuery | Add-Member -MemberType NoteProperty -Name Product -Value ''
    $LogDefQuery | Add-Member -MemberType NoteProperty -Name Location -Value ''
    $LogDefQuery | Add-Member -MemberType NoteProperty -Name TypeInfo -Value ''
    $LogDefQuery | Add-Member -MemberType NoteProperty -Name Level -Value ''
    #endregion


    $LogDefQuery.ComputerName = $env:COMPUTERNAME
    $LogDefQuery.Level = "Server"
    $LogDefQuery.Location = (Get-WebConfigFile).fullName
    $LogDefQuery.LogName = "iisServerConfig"
    $LogDefQuery.Product = "IIS"
    $LogDefQuery.TypeInfo = "File"

    $LogDef += $LogDefQuery

    #endregion
    #region GetHTTPERR
    #region LogDefQuery
    $LogDefQuery = New-Object PsObject
    $LogDefQuery | Add-Member -MemberType NoteProperty -Name ComputerName -Value ''
    $LogDefQuery | Add-Member -MemberType NoteProperty -Name LogName -Value ''
    $LogDefQuery | Add-Member -MemberType NoteProperty -Name Product -Value ''
    $LogDefQuery | Add-Member -MemberType NoteProperty -Name Location -Value ''
    $LogDefQuery | Add-Member -MemberType NoteProperty -Name TypeInfo -Value ''
    $LogDefQuery | Add-Member -MemberType NoteProperty -Name Level -Value ''
    #endregion


    $LogDefQuery.ComputerName = $env:COMPUTERNAME
    $LogDefQuery.Level = "Server"
    $LogDefQuery.Location = "C:\Windows\System32\LogFiles\HTTPERR"
    $LogDefQuery.LogName = "HTTPERRLog"
    $LogDefQuery.Product = "IIS"
    $LogDefQuery.TypeInfo = "Folder"

    $LogDef += $LogDefQuery

    #endregion
    #region GetApplication
    #region LogDefQuery
    $LogDefQuery = New-Object PsObject
    $LogDefQuery | Add-Member -MemberType NoteProperty -Name ComputerName -Value ''
    $LogDefQuery | Add-Member -MemberType NoteProperty -Name LogName -Value ''
    $LogDefQuery | Add-Member -MemberType NoteProperty -Name Product -Value ''
    $LogDefQuery | Add-Member -MemberType NoteProperty -Name Location -Value ''
    $LogDefQuery | Add-Member -MemberType NoteProperty -Name TypeInfo -Value ''
    $LogDefQuery | Add-Member -MemberType NoteProperty -Name Level -Value ''
    #endregion


    $LogDefQuery.ComputerName = $env:COMPUTERNAME
    $LogDefQuery.Level = "Server"
    $LogDefQuery.Location = "C:\Windows\System32\winevt\Logs\Application.evtx"
    $LogDefQuery.LogName = "Application"
    $LogDefQuery.Product = "OS"
    $LogDefQuery.TypeInfo = "evtx"

    $LogDef += $LogDefQuery

    #endregion
    #region GetSystem
    #region LogDefQuery
    $LogDefQuery = New-Object PsObject
    $LogDefQuery | Add-Member -MemberType NoteProperty -Name ComputerName -Value ''
    $LogDefQuery | Add-Member -MemberType NoteProperty -Name LogName -Value ''
    $LogDefQuery | Add-Member -MemberType NoteProperty -Name Product -Value ''
    $LogDefQuery | Add-Member -MemberType NoteProperty -Name Location -Value ''
    $LogDefQuery | Add-Member -MemberType NoteProperty -Name TypeInfo -Value ''
    $LogDefQuery | Add-Member -MemberType NoteProperty -Name Level -Value ''
    #endregion


    $LogDefQuery.ComputerName = $env:COMPUTERNAME
    $LogDefQuery.Level = "Server"
    $LogDefQuery.Location = "C:\Windows\System32\winevt\Logs\System.evtx"
    $LogDefQuery.LogName = "System"
    $LogDefQuery.Product = "OS"
    $LogDefQuery.TypeInfo = "evtx"

    $LogDef += $LogDefQuery

    #endregion
    #region GetSecurity
    #region LogDefQuery
    $LogDefQuery = New-Object PsObject
    $LogDefQuery | Add-Member -MemberType NoteProperty -Name ComputerName -Value ''
    $LogDefQuery | Add-Member -MemberType NoteProperty -Name LogName -Value ''
    $LogDefQuery | Add-Member -MemberType NoteProperty -Name Product -Value ''
    $LogDefQuery | Add-Member -MemberType NoteProperty -Name Location -Value ''
    $LogDefQuery | Add-Member -MemberType NoteProperty -Name TypeInfo -Value ''
    $LogDefQuery | Add-Member -MemberType NoteProperty -Name Level -Value ''
    #endregion


    $LogDefQuery.ComputerName = $env:COMPUTERNAME
    $LogDefQuery.Level = "Server"
    $LogDefQuery.Location = "C:\Windows\System32\winevt\Logs\Security.evtx"
    $LogDefQuery.LogName = "Security"
    $LogDefQuery.Product = "OS"
    $LogDefQuery.TypeInfo = "evtx"

    $LogDef += $LogDefQuery

    #endregion

    $LogDef | Export-Csv $IISLogsDefinition -NoTypeInformation -Delimiter ","
}
Function GetSiteStatus {
    $CurrentSites = Get-Website | Select-Object id, state, name, applicationPool, enabledProtocols, physicalPath | Sort-Object -Property id
    Return $CurrentSites
}
Function CatchIISzip {
    PopulateLogDefinition  
    $LOGSDefinitions = Import-Csv $IISLogsDefinition    
    $tempLocation = $scriptPath + "\MSDT"
    new-item -Path $scriptPath -ItemType "directory" -Name "MSDT"
    $zipfile = $scriptPath + "\IIS-ConfigLogs.zip"
    If (Test-path $tempLocation)
    { Get-ChildItem $tempLocation | Remove-Item -Recurse }
    $zipfile = $scriptPath + "\IIS-ConfigLogs.zip"
    If (Test-path $zipfile) { Remove-item $zipfile -Force }
    Copy-Item -Path $IISLogsDefinition -Destination $tempLocation -Recurse -Force
    foreach ($LogDefinition in $LOGSDefinitions) {
        if ($LogDefinition.TypeInfo -eq 'Folder' -and $LogDefinition.Level -eq 'Site' ) 
        { 
            $sourceLocation = (Get-Item $LogDefinition.Location).Parent.FullName
            Robocopy.exe $sourceLocation $tempLocation /s /maxage:$MaxDays
        }
        Elseif ($LogDefinition.Location -like '*web*') { 
            $Destination = $tempLocation + "\" + $LogDefinition.LogName + "_web.config"
            Copy-Item -Path $LogDefinition.Location -Destination $Destination -Recurse -Force
        }
        else {
            Copy-Item -Path $LogDefinition.Location -Destination $tempLocation -Recurse -Force
        }
    }
    Add-Type -assembly "system.io.compression.filesystem"
    
    [io.compression.zipfile]::CreateFromDirectory($tempLocation, $zipfile) 
    #Compress-Archive -Path $destination -DestinationPath $zipfile
    Remove-Item -Recurse $tempLocation -Force
}
Function PopulateForm {
    Add-Type -AssemblyName PresentationFramework 
    [xml]$form = Get-Content -Path $FormLocation
    
    $NodeReader = (New-Object System.Xml.XmlNodeReader $Form)
    $XamlReader = [Windows.Markup.XamlReader]::Load( $NodeReader ) 
    
    $tabControl = $XamlReader.FindName("tabControl")
    $start = $XamlReader.FindName("createZIP")
	$days = $XamlReader.FindName("maxDays")
    $next = $XamlReader.FindName("MoveToCatch")
    $sitesDataGrid = $XamlReader.FindName("sitesDataGrid")
    $barCatchStatus = $XamlReader.FindName("catchStatus")
    $barGetSiteStatus = $XamlReader.FindName("getSiteStatus")
    $update = $XamlReader.FindName("UpdateText")
    $GetSites = $XamlReader.FindName("GetSites")
    $days.text = $DefaultMaxDays
    $next.add_click( {
            $tabControl.SelectedIndex = 1;
            $barCatchStatus.value = "0"
        
        })
    $start.add_click( {
            $barCatchStatus.value = "0"
			$MaxDays = $days.text
			#$MaxDays |Out-File 'E:\Temp\PublicLogCatcher\maxDays.log'
			#$days.text |Out-File 'E:\Temp\PublicLogCatcher\daystext.log'
            CatchIISzip 
            $barCatchStatus.value = "100"
            $update.text = "Zip has been generated, you will find it on the Desktop"
        })
    $GetSites.add_click( {
            $arrproc = New-Object System.Collections.ArrayList
            $barGetSiteStatus.value = "0"
            $CurrentSites = GetSiteStatus 
            $arrproc.addrange($CurrentSites)
            $sitesDataGrid.ItemsSource = @($arrproc)
            $barGetSiteStatus.value = "100"
        })
     $XamlReader.ShowDialog() 
}
       
Get-IIS-Stuff
PopulateForm
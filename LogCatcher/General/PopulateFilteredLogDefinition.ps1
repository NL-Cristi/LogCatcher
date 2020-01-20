Function PopulateFilteredLogDefinition { 
    Get-IIS-Stuff
    #region LogDefinition

    $LogDef = @()
    $FilteredSiteInfo = @()
    #endregion

    if ($FilteredSitesIDs.Count -gt 1) {
        foreach ($siteid in $FilteredSitesIDs) {
            $SiteDetails = Get-Website | Where-Object { $_.ID -eq "$siteid" }
            $FilteredSiteInfo += $SiteDetails
        } 
    }
    else {
        foreach ($siteid in $FilteredSitesIDs) {
            $SiteDetails = Get-Website | Where-Object { $_.ID -eq "$siteid" }
            $FilteredSiteInfo += $SiteDetails 
        }
    }
    

    #region getSiteData
    foreach ($siteinfo in $FilteredSiteInfo) {
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
        $LogDefQuery.Location = $siteinfo.physicalPath
        $LogDefQuery.LogName = $siteinfo.Name
        $LogDefQuery.Product = "SitePath"
        $LogDefQuery.TypeInfo = "Folder"

        $LogDef += $LogDefQuery

    }
    #endregion

    #region getSiteLogs
    foreach ($siteinfo in $FilteredSiteInfo) {
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
        $LogDefQuery.Product = "IISLogs"
        $LogDefQuery.TypeInfo = "Folder"
        $LogDef += $LogDefQuery
     

    }    
    #region getSiteFREBS

    foreach ($siteinfo in $FilteredSiteInfo) {
        #region LogDefQuery
        $LogDefQuery = New-Object PsObject
        $LogDefQuery | Add-Member -MemberType NoteProperty -Name ComputerName -Value ''
        $LogDefQuery | Add-Member -MemberType NoteProperty -Name LogName -Value ''
        $LogDefQuery | Add-Member -MemberType NoteProperty -Name Product -Value ''
        $LogDefQuery | Add-Member -MemberType NoteProperty -Name Location -Value ''
        $LogDefQuery | Add-Member -MemberType NoteProperty -Name TypeInfo -Value ''
        $LogDefQuery | Add-Member -MemberType NoteProperty -Name Level -Value ''
        #endregion
        if ($siteinfo.traceFailedRequestsLogging.enabled -eq "True") {
            $LogDefQuery.ComputerName = $env:COMPUTERNAME
            $LogDefQuery.Level = "Site"
            $LogDefQuery.Location = $siteinfo.traceFailedRequestsLogging.directory + "\W3SVC" + $siteinfo.id -replace "%SystemDrive%", "$env:SystemDrive"
            $LogDefQuery.LogName = $siteinfo.Name
            $LogDefQuery.Product = "FrebLogs"
            $LogDefQuery.TypeInfo = "Folder"
            $LogDef += $LogDefQuery
        }

    }    
    $LogDef | Format-Table -AutoSize

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
    $LogDefQuery.Location = (Get-WebConfigFile).DirectoryName
    $LogDefQuery.LogName = "IISConfig"
    $LogDefQuery.Product = "IIS"
    $LogDefQuery.TypeInfo = "Folder"

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
    


       #region GetCapi2
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
    $LogDefQuery.Location = "C:\Windows\System32\winevt\Logs\Microsoft-Windows-CAPI2%4Operational.evtx"
    $LogDefQuery.LogName = "Security"
    $LogDefQuery.Product = "OS"
    $LogDefQuery.TypeInfo = "evtx"

    $LogDef += $LogDefQuery

    #endregion

    #region ToolLog
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
    $LogDefQuery.Location = $Global:ToolLog
    $LogDefQuery.LogName = "ToolLog"
    $LogDefQuery.Product = "Tool"
    $LogDefQuery.TypeInfo = "File"

    $LogDef += $LogDefQuery
    #endregion

    #region LogDefinition
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
    $LogDefQuery.Location = $Global:FilteredIISLogsDefinition
    $LogDefQuery.LogName = "LogDefinition"
    $LogDefQuery.Product = "Tool"
    $LogDefQuery.TypeInfo = "File"

    $LogDef += $LogDefQuery

    #endregion
	
	#region DotNet
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
    $LogDefQuery.Location = "C:\Windows\Microsoft.NET\"
    $LogDefQuery.LogName = "NetPath"
    $LogDefQuery.Product = "OS"
    $LogDefQuery.TypeInfo = "Folder"

    $LogDef += $LogDefQuery

    #endregion

    $LogDef | Export-Csv $FilteredIISLogsDefinition -NoTypeInformation -Delimiter ","
}
function GenerateSiteOverview {
    $Global:SiteOverview = @()
    $FilteredSiteInfo = Get-Website
   
    foreach ($siteinfo in $FilteredSiteInfo) {
       $IISDefQuery = New-Object PsObject
       $IISDefQuery | Add-Member -MemberType NoteProperty -Name SiteName -Value ''
       $IISDefQuery | Add-Member -MemberType NoteProperty -Name applicationPool -Value ''
       $IISDefQuery | Add-Member -MemberType NoteProperty -Name Path -Value ''
       $IISDefQuery | Add-Member -MemberType NoteProperty -Name CLR -Value ''
       $IISDefQuery | Add-Member -MemberType NoteProperty -Name Pipeline -Value ''
       $IISDefQuery | Add-Member -MemberType NoteProperty -Name AutoStart -Value ''
       $IISDefQuery | Add-Member -MemberType NoteProperty -Name AppAccount -Value ''
       $IISDefQuery | Add-Member -MemberType NoteProperty -Name Enable32 -Value ''
       $IISDefQuery | Add-Member -MemberType NoteProperty -Name LoadUserProfile -Value ''
       $IISDefQuery | Add-Member -MemberType NoteProperty -Name QueueLength -Value ''
       $IISDefQuery | Add-Member -MemberType NoteProperty -Name MaxProcesses -Value ''
   
   
       $IISDefQuery.SiteName = $siteinfo.Name
       $IISDefQuery.applicationPool = $siteinfo.applicationPool
       $IISDefQuery.Path = $siteinfo.physicalPath
       $IISDefQuery.CLR = (Get-Website $siteinfo.name |Get-IISAppPool).ManagedRuntimeVersion
       $IISDefQuery.Pipeline = (Get-Website $siteinfo.name |Get-IISAppPool).ManagedPipelineMode
       $IISDefQuery.AutoStart = (Get-Website $siteinfo.name |Get-IISAppPool).AutoStart
       $IISDefQuery.AppAccount = (Get-Website $siteinfo.name  |Get-IISAppPool | Select-Object -ExpandProperty ProcessModel).UserName 
       $IISDefQuery.Enable32 = (Get-Website $siteinfo.name |Get-IISAppPool ).Enable32BitAppOnWin64 
        $IISDefQuery.LoadUserProfile = (Get-Website $siteinfo.name  |Get-IISAppPool | Select-Object -ExpandProperty ProcessModel).LoadUserProfile 
        $IISDefQuery.QueueLength = (Get-Website $siteinfo.name |Get-IISAppPool ).QueueLength 
        $IISDefQuery.MaxProcesses = (Get-Website $siteinfo.name |Get-IISAppPool | Select-Object -ExpandProperty ProcessModel).MaxProcesses  
        $Global:SiteOverview += $IISDefQuery
   
       }
       
    
}
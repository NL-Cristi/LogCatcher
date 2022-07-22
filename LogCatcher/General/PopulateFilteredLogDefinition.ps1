Function PopulateFilteredLogDefinition { 
    Get-IIS-Stuff

    #region LogDefinition

    $LogDef = @()
    $FilteredSiteInfo = @()
    $FilteredWebs = @()
    #endregion

    if ($FilteredSitesIDs.Count -gt 1) {
        foreach ($siteid in $FilteredSitesIDs) {
            $SiteDetails = Get-Website | Where-Object { $_.ID -eq "$siteid" }
            $FilteredSiteInfo += $SiteDetails
            $tempwebs = Get-WebApplication |  Where-Object { ($_.ItemXPath).split("'")[3] -eq "$siteid" }
            $FilteredWebs += $tempwebs
        } 
    }
    else {
        foreach ($siteid in $FilteredSitesIDs) {
            $SiteDetails = Get-Website | Where-Object { $_.ID -eq "$siteid" }
            $FilteredSiteInfo += $SiteDetails
            $tempwebs = Get-WebApplication |  Where-Object { $_.ItemXPath.split("'")[3] -eq "$siteid" }
            $FilteredWebs += $tempwebs
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
        $LogDefQuery | Add-Member -MemberType NoteProperty -Name SiteID -Value ''
        $LogDefQuery | Add-Member -MemberType NoteProperty -Name ParentSite -Value ''
        $LogDefQuery | Add-Member -MemberType NoteProperty -Name PoolName -Value ''

        #endregion
        $LogDefQuery.ComputerName = $env:COMPUTERNAME
        $LogDefQuery.Level = "Site"
        $LogDefQuery.Location = $siteinfo.physicalPath
        $LogDefQuery.LogName = $siteinfo.Name
        $LogDefQuery.PoolName = $siteinfo.applicationPool
        $LogDefQuery.Product = "SitePath"
        $LogDefQuery.TypeInfo = "Folder"
        $LogDefQuery.SiteID = $siteinfo.id
        $LogDefQuery.ParentSite = $siteinfo.Name


        $LogDef += $LogDefQuery

    }


    foreach ($web in $FilteredWebs) {
        #region LogDefQuery
        $LogDefQuery = New-Object PsObject
        $LogDefQuery | Add-Member -MemberType NoteProperty -Name ComputerName -Value ''
        $LogDefQuery | Add-Member -MemberType NoteProperty -Name LogName -Value ''
        $LogDefQuery | Add-Member -MemberType NoteProperty -Name Product -Value ''
        $LogDefQuery | Add-Member -MemberType NoteProperty -Name Location -Value ''
        $LogDefQuery | Add-Member -MemberType NoteProperty -Name TypeInfo -Value ''
        $LogDefQuery | Add-Member -MemberType NoteProperty -Name Level -Value ''
        $LogDefQuery | Add-Member -MemberType NoteProperty -Name SiteID -Value ''
        $LogDefQuery | Add-Member -MemberType NoteProperty -Name ParentSite -Value ''
        $LogDefQuery | Add-Member -MemberType NoteProperty -Name PoolName -Value ''


        #endregion
        $LogDefQuery.ComputerName = $env:COMPUTERNAME
        $LogDefQuery.LogName = $web.ItemXPath.split("'")[5].Substring(1).Replace("/", "\")
        $LogDefQuery.Product = "AppPath"
        $LogDefQuery.Location = $web.physicalPath
        $LogDefQuery.PoolName = $web.applicationPool
        $LogDefQuery.TypeInfo = "Folder"
        $LogDefQuery.Level = "Site"
        $LogDefQuery.ParentSite = $web.ItemXPath.split("'")[1]
        $LogDefQuery.SiteID = $web.ItemXPath.split("'")[3]


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
        $LogDefQuery | Add-Member -MemberType NoteProperty -Name SiteID -Value ''
        $LogDefQuery | Add-Member -MemberType NoteProperty -Name ParentSite -Value ''
        $LogDefQuery | Add-Member -MemberType NoteProperty -Name PoolName -Value ''


        #endregion
        $LogDefQuery.ComputerName = $env:COMPUTERNAME
        $LogDefQuery.Level = "Site"
        $LogDefQuery.Location = $siteinfo.logFile.directory + "\W3SVC" + $siteinfo.id -replace "%SystemDrive%", "$env:SystemDrive"
        $LogDefQuery.LogName = $siteinfo.Name
        $LogDefQuery.SiteID = $siteinfo.id
        $LogDefQuery.ParentSite = $siteinfo.Name
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
        $LogDefQuery | Add-Member -MemberType NoteProperty -Name SiteID -Value ''
        $LogDefQuery | Add-Member -MemberType NoteProperty -Name ParentSite -Value ''
        $LogDefQuery | Add-Member -MemberType NoteProperty -Name PoolName -Value ''

        #endregion
        if ($Global:ForceFREBCollection -eq $true -or $siteinfo.traceFailedRequestsLogging.enabled -eq "True") {
            $LogDefQuery.ComputerName = $env:COMPUTERNAME
            $LogDefQuery.Level = "Site"
            $LogDefQuery.Location = $siteinfo.traceFailedRequestsLogging.directory + "\W3SVC" + $siteinfo.id -replace "%SystemDrive%", "$env:SystemDrive"
            $LogDefQuery.LogName = $siteinfo.Name
            $LogDefQuery.SiteID = $siteinfo.id
            $LogDefQuery.ParentSite = $siteinfo.Name
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
    $LogDefQuery | Add-Member -MemberType NoteProperty -Name SiteID -Value ''
    $LogDefQuery | Add-Member -MemberType NoteProperty -Name ParentSite -Value ''
    $LogDefQuery | Add-Member -MemberType NoteProperty -Name PoolName -Value ''

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
    $LogDefQuery | Add-Member -MemberType NoteProperty -Name SiteID -Value ''
    $LogDefQuery | Add-Member -MemberType NoteProperty -Name ParentSite -Value ''
    $LogDefQuery | Add-Member -MemberType NoteProperty -Name PoolName -Value ''

    #endregion


    $LogDefQuery.ComputerName = $env:COMPUTERNAME
    $LogDefQuery.Level = "Server"
    $LogDefQuery.Location = "C:\Windows\System32\LogFiles\HTTPERR"
    $LogDefQuery.LogName = "HTTPERRLog"
    $LogDefQuery.Product = "IIS"
    $LogDefQuery.TypeInfo = "Folder"

    $LogDef += $LogDefQuery

    #endregion
    
    
    #region GetIISConfigHistory
    #region LogDefQuery
    $LogDefQuery = New-Object PsObject
    $LogDefQuery | Add-Member -MemberType NoteProperty -Name ComputerName -Value ''
    $LogDefQuery | Add-Member -MemberType NoteProperty -Name LogName -Value ''
    $LogDefQuery | Add-Member -MemberType NoteProperty -Name Product -Value ''
    $LogDefQuery | Add-Member -MemberType NoteProperty -Name Location -Value ''
    $LogDefQuery | Add-Member -MemberType NoteProperty -Name TypeInfo -Value ''
    $LogDefQuery | Add-Member -MemberType NoteProperty -Name Level -Value ''
    $LogDefQuery | Add-Member -MemberType NoteProperty -Name SiteID -Value ''
    $LogDefQuery | Add-Member -MemberType NoteProperty -Name ParentSite -Value ''
    $LogDefQuery | Add-Member -MemberType NoteProperty -Name PoolName -Value ''

    #endregion


    $LogDefQuery.ComputerName = $env:COMPUTERNAME
    $LogDefQuery.Level = "Server"
    $LogDefQuery.Location = (Get-WebConfigurationProperty -pspath 'MACHINE/WEBROOT/APPHOST'  -filter "system.applicationHost/configHistory" -name "path").Value -replace "%SystemDrive%", "$env:SystemDrive"
    $LogDefQuery.LogName = "IISConfigHistory"
    $LogDefQuery.Product = "IIS"
    $LogDefQuery.TypeInfo = "Folder"

    $LogDef += $LogDefQuery

    #endregion


    #region PopulateEvtx

    foreach ($iiseventLog in $IISEventLogs) {
        #region LogDefQuery
        $LogDefQuery = New-Object PsObject
        $LogDefQuery | Add-Member -MemberType NoteProperty -Name ComputerName -Value ''
        $LogDefQuery | Add-Member -MemberType NoteProperty -Name LogName -Value ''
        $LogDefQuery | Add-Member -MemberType NoteProperty -Name Product -Value ''
        $LogDefQuery | Add-Member -MemberType NoteProperty -Name Location -Value ''
        $LogDefQuery | Add-Member -MemberType NoteProperty -Name TypeInfo -Value ''
        $LogDefQuery | Add-Member -MemberType NoteProperty -Name Level -Value ''
        $LogDefQuery | Add-Member -MemberType NoteProperty -Name SiteID -Value ''
        $LogDefQuery | Add-Member -MemberType NoteProperty -Name ParentSite -Value ''
        #endregion
           
        #region PopulateLogDefQuery 
        $LogDefQuery.ComputerName = $env:COMPUTERNAME
        $LogDefQuery.Level = "Server"
        $LogDefQuery.Location = $iiseventLog.LogFilePath.ToString() -replace "%SystemRoot%", "$env:SystemRoot" 
        $LogDefQuery.LogName = $iiseventLog.LogName.ToString()
        $LogDefQuery.Product = "OS"
        $LogDefQuery.TypeInfo = "evtx"
        #endregion
       
        $LogDef += $LogDefQuery
    }
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
    $LogDefQuery | Add-Member -MemberType NoteProperty -Name SiteID -Value ''
    $LogDefQuery | Add-Member -MemberType NoteProperty -Name ParentSite -Value ''
    $LogDefQuery | Add-Member -MemberType NoteProperty -Name PoolName -Value ''

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
    $LogDefQuery | Add-Member -MemberType NoteProperty -Name SiteID -Value ''
    $LogDefQuery | Add-Member -MemberType NoteProperty -Name ParentSite -Value ''
    $LogDefQuery | Add-Member -MemberType NoteProperty -Name PoolName -Value ''

    #endregion


    $LogDefQuery.ComputerName = $env:COMPUTERNAME
    $LogDefQuery.Level = "Server"
    $LogDefQuery.Location = $Global:FilteredIISLogsDefinition
    $LogDefQuery.LogName = "LogDefinition"
    $LogDefQuery.Product = "Tool"
    $LogDefQuery.TypeInfo = "File"

    $LogDef += $LogDefQuery

    #endregion
    
    #region ContentStructure
    #region LogDefQuery
    $LogDefQuery = New-Object PsObject
    $LogDefQuery | Add-Member -MemberType NoteProperty -Name ComputerName -Value ''
    $LogDefQuery | Add-Member -MemberType NoteProperty -Name LogName -Value ''
    $LogDefQuery | Add-Member -MemberType NoteProperty -Name Product -Value ''
    $LogDefQuery | Add-Member -MemberType NoteProperty -Name Location -Value ''
    $LogDefQuery | Add-Member -MemberType NoteProperty -Name TypeInfo -Value ''
    $LogDefQuery | Add-Member -MemberType NoteProperty -Name Level -Value ''
    $LogDefQuery | Add-Member -MemberType NoteProperty -Name SiteID -Value ''
    $LogDefQuery | Add-Member -MemberType NoteProperty -Name ParentSite -Value ''
    $LogDefQuery | Add-Member -MemberType NoteProperty -Name PoolName -Value ''

    #endregion


    $LogDefQuery.ComputerName = $env:COMPUTERNAME
    $LogDefQuery.Level = "Server"
    $LogDefQuery.Location = $Global:ContentStructure
    $LogDefQuery.LogName = "Content"
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
    $LogDefQuery | Add-Member -MemberType NoteProperty -Name SiteID -Value ''
    $LogDefQuery | Add-Member -MemberType NoteProperty -Name ParentSite -Value ''
    $LogDefQuery | Add-Member -MemberType NoteProperty -Name PoolName -Value ''

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
        $IISDefQuery | Add-Member -MemberType NoteProperty -Name Enable32 -Value ''
        $IISDefQuery | Add-Member -MemberType NoteProperty -Name QueueLength -Value ''
        $IISDefQuery | Add-Member -MemberType NoteProperty -Name maxBandwidth -Value ''
        $IISDefQuery | Add-Member -MemberType NoteProperty -Name maxConnections -Value ''
        $IISDefQuery | Add-Member -MemberType NoteProperty -Name connectionTimeout -Value ''
        $IISDefQuery | Add-Member -MemberType NoteProperty -Name maxUrlSegments -Value ''
        $IISDefQuery | Add-Member -MemberType NoteProperty -Name StartupTimeLimit -Value ''
        $IISDefQuery | Add-Member -MemberType NoteProperty -Name Action -Value ''
        $IISDefQuery | Add-Member -MemberType NoteProperty -Name Limit -Value ''
        $IISDefQuery | Add-Member -MemberType NoteProperty -Name ResetInterval -Value ''
        $IISDefQuery | Add-Member -MemberType NoteProperty -Name SmpAffinitized -Value ''
        $IISDefQuery | Add-Member -MemberType NoteProperty -Name SmpProcessorAffinityMask -Value '' 
        $IISDefQuery | Add-Member -MemberType NoteProperty -Name SmpProcessorAffinityMask2 -Value ''
        $IISDefQuery | Add-Member -MemberType NoteProperty -Name RecyclingSchedule -Value ''
        $IISDefQuery | Add-Member -MemberType NoteProperty -Name RecyclingTime -Value ''
        $IISDefQuery | Add-Member -MemberType NoteProperty -Name RecyclingMemory -Value ''
        $IISDefQuery | Add-Member -MemberType NoteProperty -Name RecyclingPrivateMemory -Value ''
        $IISDefQuery | Add-Member -MemberType NoteProperty -Name RecyclingRequests -Value ''
        $IISDefQuery | Add-Member -MemberType NoteProperty -Name RecyclingDisallowOverlappingRotation -Value ''  
        $IISDefQuery | Add-Member -MemberType NoteProperty -Name RecyclingDisallowRotationOnConfigChange -Value ''
        $IISDefQuery | Add-Member -MemberType NoteProperty -Name OrphanWorkerProcess -Value ''
        $IISDefQuery | Add-Member -MemberType NoteProperty -Name RapidFailProtection -Value ''
        $IISDefQuery | Add-Member -MemberType NoteProperty -Name RapidFailProtectionInterval -Value ''
        $IISDefQuery | Add-Member -MemberType NoteProperty -Name RapidFailProtectionMaxCrashes -Value ''
        $IISDefQuery | Add-Member -MemberType NoteProperty -Name MaxProcesses -Value ''
        $IISDefQuery | Add-Member -MemberType NoteProperty -Name AppAccount -Value ''
        $IISDefQuery | Add-Member -MemberType NoteProperty -Name AccountType -Value ''
        $IISDefQuery | Add-Member -MemberType NoteProperty -Name IdleTimeout -Value ''
        $IISDefQuery | Add-Member -MemberType NoteProperty -Name IdleTimeoutAction -Value ''
        $IISDefQuery | Add-Member -MemberType NoteProperty -Name LoadUserProfile -Value ''
        $IISDefQuery | Add-Member -MemberType NoteProperty -Name PingingEnabled -Value ''
        $IISDefQuery | Add-Member -MemberType NoteProperty -Name PingInterval -Value ''
        $IISDefQuery | Add-Member -MemberType NoteProperty -Name PingResponseTime -Value ''
        $IISDefQuery | Add-Member -MemberType NoteProperty -Name ShutdownTimeLimit -Value ''
        
        #Generic
        $IISDefQuery.SiteName = $siteinfo.Name.ToString()
        $IISDefQuery.applicationPool = $siteinfo.applicationPool.ToString()
        $IISDefQuery.Path = $siteinfo.physicalPath.ToString()
        $IISDefQuery.CLR = ((Get-Website $siteinfo.name).applicationPool | Get-IISAppPool).ManagedRuntimeVersion.ToString()
        $IISDefQuery.Pipeline = ((Get-Website $siteinfo.name).applicationPool | Get-IISAppPool).ManagedPipelineMode.ToString()
        $IISDefQuery.AutoStart = ((Get-Website $siteinfo.name).applicationPool | Get-IISAppPool).AutoStart.ToString()
        $IISDefQuery.Enable32 = ((Get-Website $siteinfo.name).applicationPool | Get-IISAppPool ).Enable32BitAppOnWin64.ToString()
        $IISDefQuery.QueueLength = ((Get-Website $siteinfo.name).applicationPool | Get-IISAppPool ).QueueLength.ToString()
        $IISDefQuery.maxBandwidth = (Get-Website $siteinfo.name).limits.maxBandwidth.ToString()     
        $IISDefQuery.maxConnections = (Get-Website $siteinfo.name).limits.maxConnections.ToString()     
        $IISDefQuery.connectionTimeout = (Get-Website $siteinfo.name).limits.connectionTimeout.ToString()     
        $IISDefQuery.maxUrlSegments = (Get-Website $siteinfo.name).limits.maxUrlSegments.ToString()       
        #CPU(Get-Website $siteinfo.name | Get-IISAppPool | Select-Object -ExpandProperty CPU)
        $IISDefQuery.Action = ((Get-Website $siteinfo.name).applicationPool | Get-IISAppPool | Select-Object -ExpandProperty CPU).Action.ToString()
        $IISDefQuery.Limit = ((Get-Website $siteinfo.name).applicationPool | Get-IISAppPool | Select-Object -ExpandProperty CPU).Limit.ToString()
        $IISDefQuery.ResetInterval = ((Get-Website $siteinfo.name).applicationPool | Get-IISAppPool | Select-Object -ExpandProperty CPU).ResetInterval.ToString()
        $IISDefQuery.SmpAffinitized = ((Get-Website $siteinfo.name).applicationPool | Get-IISAppPool | Select-Object -ExpandProperty CPU).SmpAffinitized.ToString()
        $IISDefQuery.SmpProcessorAffinityMask = ((Get-Website $siteinfo.name).applicationPool | Get-IISAppPool | Select-Object -ExpandProperty CPU).SmpProcessorAffinityMask.ToString()
        $IISDefQuery.SmpProcessorAffinityMask2 = ((Get-Website $siteinfo.name).applicationPool | Get-IISAppPool | Select-Object -ExpandProperty CPU).SmpProcessorAffinityMask2.ToString()
        #Recycling -> (Get-Website $siteinfo.name | Get-IISAppPool | Select-Object -ExpandProperty Recycling)
        If (((Get-Website $siteinfo.name).applicationPool | Get-IISAppPool | Select-Object -ExpandProperty Recycling | Select-Object -ExpandProperty PeriodicRestart).Schedule.Time -eq $null) {      
            $IISDefQuery.RecyclingSchedule = "NotSet"
        }      
        else {
            $IISDefQuery.RecyclingSchedule = ((Get-Website $siteinfo.name).applicationPool | Get-IISAppPool | Select-Object -ExpandProperty Recycling | Select-Object -ExpandProperty PeriodicRestart).Schedule.Time.ToString()
        }  
        $IISDefQuery.RecyclingTime = ((Get-Website $siteinfo.name).applicationPool | Get-IISAppPool | Select-Object -ExpandProperty Recycling | Select-Object -ExpandProperty PeriodicRestart).Time.ToString()
        $IISDefQuery.RecyclingMemory = ((Get-Website $siteinfo.name).applicationPool | Get-IISAppPool | Select-Object -ExpandProperty Recycling | Select-Object -ExpandProperty PeriodicRestart).Memory.ToString()
        $IISDefQuery.RecyclingPrivateMemory = ((Get-Website $siteinfo.name).applicationPool | Get-IISAppPool | Select-Object -ExpandProperty Recycling | Select-Object -ExpandProperty PeriodicRestart).PrivateMemory.ToString()
        $IISDefQuery.RecyclingRequests = ((Get-Website $siteinfo.name).applicationPool | Get-IISAppPool | Select-Object -ExpandProperty Recycling | Select-Object -ExpandProperty PeriodicRestart).Requests.ToString()
        $IISDefQuery.RecyclingDisallowOverlappingRotation = ((Get-Website $siteinfo.name).applicationPool | Get-IISAppPool | Select-Object -ExpandProperty Recycling).DisallowOverlappingRotation.ToString()
        $IISDefQuery.RecyclingDisallowRotationOnConfigChange = ((Get-Website $siteinfo.name).applicationPool | Get-IISAppPool | Select-Object -ExpandProperty Recycling).DisallowRotationOnConfigChange.ToString()
        #Failure -> (Get-Website $siteinfo.name | Get-IISAppPool | Select-Object -ExpandProperty Failure)
        $IISDefQuery.OrphanWorkerProcess = ((Get-Website $siteinfo.name).applicationPool | Get-IISAppPool | Select-Object -ExpandProperty Failure).OrphanWorkerProcess.ToString()
        $IISDefQuery.RapidFailProtection = ((Get-Website $siteinfo.name).applicationPool | Get-IISAppPool | Select-Object -ExpandProperty Failure).RapidFailProtection.ToString()
        $IISDefQuery.RapidFailProtectionInterval = ((Get-Website $siteinfo.name).applicationPool | Get-IISAppPool | Select-Object -ExpandProperty Failure).RapidFailProtectionInterval.ToString()
        $IISDefQuery.RapidFailProtectionMaxCrashes = ((Get-Website $siteinfo.name).applicationPool | Get-IISAppPool | Select-Object -ExpandProperty Failure).RapidFailProtectionMaxCrashes.ToString()
        #Idle -> (Get-Website $siteinfo.name | Get-IISAppPool | Select-Object -ExpandProperty ProcessModel)
        $IISDefQuery.MaxProcesses = ((Get-Website $siteinfo.name).applicationPool | Get-IISAppPool | Select-Object -ExpandProperty ProcessModel).MaxProcesses.ToString()
        $IISDefQuery.AppAccount = ((Get-Website $siteinfo.name).applicationPool  | Get-IISAppPool | Select-Object -ExpandProperty ProcessModel).UserName.ToString() 
        $IISDefQuery.AccountType = ((Get-Website $siteinfo.name).applicationPool  | Get-IISAppPool | Select-Object -ExpandProperty ProcessModel).IdentityType.ToString() 
        $IISDefQuery.IdleTimeout = ((Get-Website $siteinfo.name).applicationPool | Get-IISAppPool | Select-Object -ExpandProperty ProcessModel).IdleTimeout.ToString()
        $IISDefQuery.IdleTimeoutAction = ((Get-Website $siteinfo.name).applicationPool | Get-IISAppPool | Select-Object -ExpandProperty ProcessModel).IdleTimeoutAction.ToString()
        $IISDefQuery.LoadUserProfile = ((Get-Website $siteinfo.name).applicationPool | Get-IISAppPool | Select-Object -ExpandProperty ProcessModel).LoadUserProfile.ToString()
        $IISDefQuery.PingingEnabled = ((Get-Website $siteinfo.name).applicationPool | Get-IISAppPool | Select-Object -ExpandProperty ProcessModel).PingingEnabled.ToString()
        $IISDefQuery.PingInterval = ((Get-Website $siteinfo.name).applicationPool | Get-IISAppPool | Select-Object -ExpandProperty ProcessModel).PingInterval.ToString()
        $IISDefQuery.PingResponseTime = ((Get-Website $siteinfo.name).applicationPool | Get-IISAppPool | Select-Object -ExpandProperty ProcessModel).PingResponseTime.ToString()
        $IISDefQuery.ShutdownTimeLimit = ((Get-Website $siteinfo.name).applicationPool | Get-IISAppPool | Select-Object -ExpandProperty ProcessModel).ShutdownTimeLimit.ToString()
        $IISDefQuery.StartupTimeLimit = ((Get-Website $siteinfo.name).applicationPool | Get-IISAppPool | Select-Object -ExpandProperty ProcessModel).StartupTimeLimit.ToString()
        
        $Global:SiteOverview += $IISDefQuery
    } 
}
Function GetOsInfo { 
    $Global:NetVersion = @()
    $Global:WinHotFix = @()
    
    $Global:OsVer = New-Object PsObject
    
    $DotNetVersion = Get-ChildItem 'HKLM:\SOFTWARE\Microsoft\NET Framework Setup\NDP' -Recurse | Get-ItemProperty -Name Version, Release -ErrorAction 0 | Where-Object { $_.PSChildName -match '^(?!S)\p{L}' } | select PSChildName, Version, Release
    foreach ($dotnet in $DotNetVersion) {
        $dotnetver = New-Object PsObject
        $dotnetver | Add-Member -MemberType NoteProperty -Name NDPver -Value ''
        $dotnetver | Add-Member -MemberType NoteProperty -Name Version -Value ''
        $dotnetver | Add-Member -MemberType NoteProperty -Name Release -Value ''
        $dotnetver.NDPver = $dotnet.PSChildName
        $dotnetver.Version = $dotnet.Version
        $dotnetver.Release = $dotnet.Release
        $Global:NetVersion += $dotnetver
    }

    $hotfix = get-hotfix
    foreach ($fix in $hotfix) {
        $fixinfo = New-Object PsObject
        $fixinfo | Add-Member -MemberType NoteProperty -Name Description -Value ''
        $fixinfo | Add-Member -MemberType NoteProperty -Name InstalledOn -Value ''
        $fixinfo | Add-Member -MemberType NoteProperty -Name HotFixID -Value ''
        $fixinfo.Description = $fix.Description
        $fixinfo.InstalledOn = $fix.InstalledOn
        $fixinfo.HotFixID = $fix.HotFixID
        $Global:WinHotFix += $fixinfo    
    }

    $OsVer | Add-Member -MemberType NoteProperty -Name ComputerName -Value ''
    $OsVer | Add-Member -MemberType NoteProperty -Name OsVersion -Value ''
    $OsVer | Add-Member -MemberType NoteProperty -Name Edition -Value ''
    $OsVer.ComputerName = $Env:COMPUTERNAME
    $OsVer.OsVersion = ([System.Environment]::OSVersion.Version).ToString()
    $OsVer.Edition = (Get-WindowsEdition -Online).Edition
}

Function GetOsFeatures { 
    #If Server proceed if not dont run
    if (((get-itemproperty -Path "HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion" -Name ProductName).ProductName).Contains("Server") -eq "True")
   {
    $Global:OsFeatures = @()
    $WindowsFeatures = Get-WindowsFeature -ErrorAction silentlycontinue -ErrorVariable +ErrorMessages | Out-Null | Where-Object Installed
    foreach ($feature in $WindowsFeatures) {
        $fetureInfo = New-Object PsObject
        $fetureInfo | Add-Member -MemberType NoteProperty -Name Name -Value ''
        $fetureInfo | Add-Member -MemberType NoteProperty -Name FeatureType -Value ''
        $fetureInfo | Add-Member -MemberType NoteProperty -Name Depth -Value ''
        $fetureInfo.Name = $feature.Name
        $fetureInfo.FeatureType = $feature.FeatureType
        $fetureInfo.Depth = $feature.Depth
        $Global:OsFeatures += $fetureInfo
    }
}

}

Function Get-IISDefaultPermissions {
    $Global:PermissionList = New-Object -TypeName 'System.Collections.ArrayList'
    $PermissionList.Add("C:\inetpub\")
    $PermissionList.Add("C:\inetpub\AdminScripts\")
    $PermissionList.Add("C:\inetpub\AdminScripts\0409\")
    $PermissionList.Add("C:\inetpub\custerr\")
    $PermissionList.Add("C:\inetpub\custerr\en-us\")
    $PermissionList.Add("C:\inetpub\ftproot\")
    $PermissionList.Add("C:\inetpub\history\")
    $PermissionList.Add("C:\inetpub\logs\")
    $PermissionList.Add("C:\inetpub\logs\FailedReqLogFiles\")
    $PermissionList.Add("C:\inetpub\logs\wmsvc\")
    $PermissionList.Add("C:\inetpub\temp\")
    $PermissionList.Add("C:\inetpub\temp\appPools\")
    # $PermissionList.Add("C:\inetpub\temp\ASP Compiled Templates\")
    # $PermissionList.Add("C:\inetpub\temp\IIS Temporary Compressed Files\")
    $PermissionList.Add("c:\programdata\Microsoft\Crypto\RSA\MachineKeys\")
    $PermissionList.Add("C:\inetpub\wwwroot\")
    $PermissionList.Add("C:\inetpub\wwwroot\aspnet_client\")
    $PermissionList.Add("$env:WINDIR\system32\inetsrv\")
    $PermissionList.Add("$env:WINDIR\System32\inetsrv\0409\")
    $PermissionList.Add("$env:WINDIR\System32\inetsrv\config\")
    $PermissionList.Add("$env:WINDIR\System32\inetsrv\config\Export\")
    $PermissionList.Add("$env:WINDIR\System32\inetsrv\config\schema\")
    $PermissionList.Add("$env:WINDIR\System32\inetsrv\en-us\")
    $PermissionList.Add("$env:WINDIR\System32\inetsrv\History\")
    $PermissionList.Add("$env:WINDIR\System32\inetsrv\MetaBack\")
    $PermissionList.Add("HKLM:\Software\Microsoft\Inetmgr\")
    $PermissionList.Add("HKLM:\Software\Microsoft\InetStp\")
    $PermissionList.Add("HKLM:\Software\Microsoft\W3SVC\")
    $PermissionList.Add("HKLM:\System\CurrentControlSet\Services\ASP\")
    $PermissionList.Add("HKLM:\System\CurrentControlSet\Services\ASP.NET\")
    $PermissionList.Add("HKLM:\System\CurrentControlSet\Services\ASP.NET_2.0.50727\")
    $PermissionList.Add("HKLM:\System\CurrentControlSet\Services\aspnet_state\")
    $PermissionList.Add("HKLM:\System\CurrentControlSet\Services\HTTP\")
    $PermissionList.Add("HKLM:\System\CurrentControlSet\Services\IISAdmin\")
    $PermissionList.Add("HKLM:\System\CurrentControlSet\Services\W3SVC\")
    $PermissionList.Add("HKLM:\System\CurrentControlSet\Services\WAS\")
    $PermissionList.Add("HKLM:\System\CurrentControlSet\Services\WMsvc\")
}

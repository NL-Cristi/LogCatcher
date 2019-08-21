Function Get-IIS-Stuff {

    $Time=Get-Date
    try
    {
     Import-Module IISAdministration -ErrorAction Stop
    }
    
    catch
    {
    $Time=Get-Date
        $firsttry = "$Time Exception Message: $($_.Exception.Message)" | Out-File $IISRelated -Append
        }
    
    try{
    Import-Module WebAdministration -ErrorAction Stop
    }
    catch
    {  
         $secondtry = "$Time Exception Message: $($_.Exception.Message)"  | Out-File $IISRelated -Append
         }
    
     }
Function PopulateLogDefinition{ 
        Get-IIS-Stuff
#region LogDefinition

$LogDef = @()

#endregion
#region getSiteData
$sitesInfo = Get-Website
foreach ($siteinfo in $sitesInfo)
{
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
$VAR = ("IIS:\Sites\"+$siteinfo.name)
$LogDefQuery.Location = (Get-WebConfigFile $VAR).FullName
$LogDefQuery.LogName = $siteinfo.Name
$LogDefQuery.Product = "IIS"
$LogDefQuery.TypeInfo = "File"

$LogDef += $LogDefQuery

}
#endregion
#region getSiteLogs
$sitesInfo = Get-Website
foreach ($siteinfo in $sitesInfo)
{
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
$LogDefQuery.Location = $siteinfo.logFile.directory+"\W3SVC"+$siteinfo.id -replace "%SystemDrive%", "$env:SystemDrive"
$LogDefQuery.LogName = $siteinfo.Name
$LogDefQuery.Product = "IIS"
$LogDefQuery.TypeInfo = "Folder"

$LogDef += $LogDefQuery

}
$LogDef | ft -AutoSize
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
Function GetSiteStatus{
    $CurrentSites = Get-Website | Select-Object id,state,name,applicationPool,enabledProtocols,physicalPath | Sort-Object -Property id
    Return $CurrentSites
    }
Function CatchIISzip{
    PopulateLogDefinition    
    $LOGSDefinitions = Import-Csv $IISLogsDefinition    
    $DesktopPath = [Environment]::GetFolderPath("Desktop")
    $tempLocation = $DesktopPath+ "\MSDT"
    $zipfile = $DesktopPath +"\IIS-ConfigLogs.zip"
    If(Test-path $tempLocation) {Remove-item -Recurse $tempLocation}
    If(Test-path $zipfile) {Remove-item $zipfile -Force}
    New-Item -Path $DesktopPath -Name "MSDT" -ItemType "directory"
        
    foreach ($LogDefinition in $LOGSDefinitions)
   
    {
        
        if ($LogDefinition.Location -like '*web*') 
        
        { 
            $Destination = $tempLocation+"\"+$LogDefinition.LogName+"_web.config"
            Copy-Item -Path $LogDefinition.Location -Destination $Destination -Recurse

        }
        else
        {
        Copy-Item -Path $LogDefinition.Location -Destination $tempLocation -Recurse
        }
    }
    Add-Type -assembly "system.io.compression.filesystem"
    
    [io.compression.zipfile]::CreateFromDirectory($tempLocation, $zipfile) 
    #Compress-Archive -Path $destination -DestinationPath $zipfile
    Remove-Item -Recurse $tempLocation -Force
    }
Function PopulateForm{
    Add-Type -AssemblyName PresentationFramework 
    [xml]$form = Get-Content -Path $FormLocation
    
    $NR=(New-Object System.Xml.XmlNodeReader $Form)
    $Win=[Windows.Markup.XamlReader]::Load( $NR ) 
    
    $tabControl = $win.FindName("tabControl")
    $start = $win.FindName("Start")
    $next = $win.FindName("MoveToCatch")
    $os = $win.FindName("OS")
    $Inst = $win.FindName("InstallDate")
    $sp = $win.FindName("ServicePack")
    $edg = $win.FindName("EVdataGrid")
    $pdg = $win.FindName("ProcdataGrid")
    $pgbar = $win.FindName("pbStatus")
    $pgbar2 = $win.FindName("pbGetSites")
    $update = $win.FindName("UpdateText")
    $GetSites = $win.FindName("GetSites")
    
   
    
    
    $next.add_click({
        $tabControl.SelectedIndex = 1;
        $pgbar.value = "0"
        
    })
    $start.add_click({
        $arrev = New-Object System.Collections.ArrayList
        $arrproc = New-Object System.Collections.ArrayList
        
    $pgbar.value = "0"
     CatchIISzip 
    $pgbar.value = "100"
    $update.text = "Zip has been generated, you will find it on the Desktop"
    })
    $GetSites.add_click({
    $arrev = New-Object System.Collections.ArrayList
    $arrproc = New-Object System.Collections.ArrayList
    $pgbar2.value = "0"
    $CurrentSites = GetSiteStatus 
    $arrproc.addrange(@($CurrentSites))
    $pdg.ItemsSource=@($arrproc)
    $pgbar2.value = "100"
    })
    #$arr.addrange($ev)
    #$dg.ItemsSource =@($arr)
    $Win.ShowDialog() 
        }
       
Get-IIS-Stuff
PopulateForm
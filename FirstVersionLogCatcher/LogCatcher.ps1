Add-Type -AssemblyName PresentationFramework 
<#
Function Get-SysTab($computer){
$sys = Get-CimInstance win32_operatingsystem | select-object Caption, installdate, Servicepackmajorversion
$os.content = $sys.caption
$Inst.content =$sys.installdate
$sp.content = $sys.Servicepackmajorversion
}

Function Get-EventTab($computer){
$ev = get-eventlog application -ComputerName $computer -newest 100 | select TimeGenerated, EntryType, Source, InstanceID | sort -property Time
Return $ev
}

Function Get-ProcTab($computer){
$proc = Get-Process -ComputerName $computer| select ID,Name,CPU | Sort -Property Name
Return $proc
}
#>

Function GetSiteStatus{
$CurrentSites = Get-Website | select id,state,name,applicationPool,enabledProtocols,physicalPath | Sort -Property id
Return $CurrentSites
}


Function CatchIISzip{
$paths = "C:\Windows\System32\inetsrv\config\",
         "C:\inetpub\logs\LogFiles", 
         "C:\Windows\System32\LogFiles\HTTPERR", 
         "C:\inetpub\logs\FailedReqLogFiles",
         "C:\Windows\System32\winevt\Logs\Application.evtx",
         "C:\Windows\System32\winevt\Logs\System.evtx",
         "C:\Windows\System32\winevt\Logs\Security.evtx" 

$DesktopPath = [Environment]::GetFolderPath("Desktop")
$tempLocation = $DesktopPath+ "\MSDT"
$zipfile = $DesktopPath +"\IIS-ConfigLogs.zip"
If(Test-path $tempLocation) {Remove-item -Recurse $tempLocation}
If(Test-path $zipfile) {Remove-item $zipfile -Force}

foreach ($item in $paths){
    Copy-Item -Path $item -Destination $tempLocation -Recurse
}

Add-Type -assembly "system.io.compression.filesystem"

[io.compression.zipfile]::CreateFromDirectory($tempLocation, $zipfile) 
#Compress-Archive -Path $destination -DestinationPath $zipfile
Remove-Item -Recurse $tempLocation -Force
}

[xml]$form = @"
<Window 
        xmlns="http://schemas.microsoft.com/winfx/2006/xaml/presentation"
        xmlns:x="http://schemas.microsoft.com/winfx/2006/xaml"
        Title="LogCatcher" Height="396.022" Width="536.587">
    <Grid>
        <TabControl Name="tabControl" HorizontalAlignment="Left" Height="345" Margin="10,10,0,0" VerticalAlignment="Top" Width="509">
            <TabItem Header="AboutLogCatcher">
                <Grid Background="#DEEFFC">
                    <Button x:Name="MoveToCatch" Content="NEXT" HorizontalAlignment="Left" Margin="202,243,0,0" VerticalAlignment="Top" Width="75"/>
                    <TextBlock HorizontalAlignment="Left" Margin="6,54,0,0" TextWrapping="Wrap" Text="LogCatcher is a small tool for automating data collection when troubleshooting IIS and hosted web applications." VerticalAlignment="Top"/>
                    <TextBlock HorizontalAlignment="Left" Margin="6,103,0,0" TextWrapping="Wrap" Text="Use this tool to save time on gathering configuration, logs and Windows events entries that can help investigation by support engineers.
" VerticalAlignment="Top"/>
                    <TextBlock HorizontalAlignment="Left" Margin="6,154,0,0" TextWrapping="Wrap" Text="LogCatcher will copy relevant files in a temporary folder on Desktop, then it will create a ZIP archive out of that folder." VerticalAlignment="Top"/>
                    <TextBlock HorizontalAlignment="Left" Margin="25,20,0,0" TextWrapping="Wrap" Text="ShortInfo:" VerticalAlignment="Top"/>
                </Grid>
            </TabItem>
            <TabItem Header="CatchEmAll">
                <Grid Background="#DEEFFC">
                    <Button Name="Start" Content="Generate ZIP" HorizontalAlignment="Left" Height="31" Margin="191,274,0,0" VerticalAlignment="Top" Width="100"/>
                    <ProgressBar Minimum="0" Maximum="40" x:Name="pbStatus" Margin="32,244,28,52"/>
                    <TextBlock Name="UpdateText" HorizontalAlignment="Left" Margin="162,244,0,0" TextWrapping="Wrap" Text="Files Have not been collected YET" VerticalAlignment="Top"/>
                    <TextBlock HorizontalAlignment="Left" Margin="10,6,0,0" TextWrapping="Wrap" VerticalAlignment="Top"><Run FontWeight="Bold" Text="The following files are being collected:"/><LineBreak/><Run/><LineBreak/><Run Text="IIS configuration: &#x9;&#x9;&#x9;C:\Windows\System32\inetsrv\config\"/><LineBreak/><Run Text="HTTP.SYS driver logs: &#x9;&#x9;C:\Windows\System32\LogFiles\HTTPERR"/><LineBreak/><Run Text="IIS Log files: &#x9;&#x9;&#x9;C:\inetpub\logs\LogFiles\W3SVC[siteID]\"/><LineBreak/><Run Text="FREBs, Failed Request Traces:            C:\inetpub\logs\FailedReqLogFiles\W3SVC"/><LineBreak/><Run/><LineBreak/><Run Text="Relevant Windows events:"/><LineBreak/><Run Text="    C:\Windows\System32\winevt\Logs\Application.evtx"/><LineBreak/><Run Text="    C:\Windows\System32\winevt\Logs\System.evtx"/><LineBreak/><Run Text="    C:\Windows\System32\winevt\Logs\Security.evtx"/></TextBlock>
                </Grid>
            </TabItem>
            <TabItem Header="SitesStatus">
                <Grid Background="#DEEFFC">
                    <Label Name="label6" Content="Current Sites" HorizontalAlignment="Left" Height="26" Margin="10,10,0,0" VerticalAlignment="Top" Width="135" FontWeight="Bold"/>
                    <DataGrid Name="ProcdataGrid" HorizontalAlignment="Left" Height="262" Margin="10,45,0,0" VerticalAlignment="Top" Width="478"/>
                </Grid>
            </TabItem>
            <TabItem Header="FutureTab">
                <Grid Background="#DEEFFC">
                    <Button Content="SCOM" HorizontalAlignment="Left" Margin="303,31,0,0" VerticalAlignment="Top" Width="75"/>
                    <Button Content="Exchange" HorizontalAlignment="Left" Margin="303,80,0,0" VerticalAlignment="Top" Width="75"/>
                    <Button Content="SharePoint" HorizontalAlignment="Left" Margin="303,129,0,0" VerticalAlignment="Top" Width="75"/>
                    <Button Content="IIS" HorizontalAlignment="Left" Margin="303,173,0,0" VerticalAlignment="Top" Width="75"/>
                    <Button Content="Custom" HorizontalAlignment="Left" Margin="303,216,0,0" VerticalAlignment="Top" Width="75"/>
                    <CheckBox Content="CheckBox" HorizontalAlignment="Left" Margin="206,33,0,0" VerticalAlignment="Top"/>
                    <CheckBox Content="CheckBox" HorizontalAlignment="Left" Margin="206,80,0,0" VerticalAlignment="Top"/>
                    <CheckBox Content="CheckBox" HorizontalAlignment="Left" Margin="206,131,0,0" VerticalAlignment="Top"/>
                    <CheckBox Content="CheckBox" HorizontalAlignment="Left" Margin="206,172,0,0" VerticalAlignment="Top"/>
                    <TextBlock HorizontalAlignment="Left" Margin="36,33,0,0" TextWrapping="Wrap" VerticalAlignment="Top"><Run Text="Generata SCOM ZIP"/><LineBreak/><Run/></TextBlock>
                    <TextBlock HorizontalAlignment="Left" Margin="36,80,0,0" TextWrapping="Wrap" Text="Generate Exchange ZIP" VerticalAlignment="Top"/>
                    <TextBlock HorizontalAlignment="Left" Margin="29,129,0,0" TextWrapping="Wrap" Text="Generate SharePoint ZIP" VerticalAlignment="Top"/>
                    <TextBlock HorizontalAlignment="Left" Margin="57,174,0,0" TextWrapping="Wrap" Text="Generate IIS ZIP" VerticalAlignment="Top"/>
                    <TextBlock HorizontalAlignment="Left" Margin="36,216,0,0" TextWrapping="Wrap" Text="Generate ZIP for selection" VerticalAlignment="Top"/>
                    <Button Content="Collect All " HorizontalAlignment="Left" Margin="201,269,0,0" VerticalAlignment="Top" Width="75"/>
                </Grid>
            </TabItem>
        </TabControl>
    </Grid>
</Window>
"@
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
$update = $win.FindName("UpdateText")

$arrev = New-Object System.Collections.ArrayList
$arrproc = New-Object System.Collections.ArrayList


$start.add_click({
$pgbar.value = "0"
$CurrentSites = GetSiteStatus 
$arrproc.addrange($CurrentSites)
$pdg.ItemsSource=@($arrproc)
CatchIISzip 
$pgbar.value = "100"
$update.text = "Zip has been generated, you will find it on the Desktop"
})

$next.add_click({
    $tabControl.SelectedIndex = 1;
	$pgbar.value = "0"
	
})

#$arr.addrange($ev)
#$dg.ItemsSource =@($arr)
$Win.ShowDialog() 
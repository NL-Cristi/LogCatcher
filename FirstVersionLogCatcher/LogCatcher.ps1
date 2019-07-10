$scriptPath = split-path -parent $MyInvocation.MyCommand.Definition

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
$CurrentSites = Get-Website | Select-Object id,state,name,applicationPool,enabledProtocols,physicalPath | Sort-Object -Property id
Return $CurrentSites
}


Function CatchIISzip{
    $LOGS = Import-Csv .\LOGS.CSV

$DesktopPath = [Environment]::GetFolderPath("Desktop")
$tempLocation = $DesktopPath+ "\MSDT"
$zipfile = $DesktopPath +"\IIS-ConfigLogs.zip"
If(Test-path $tempLocation) {Remove-item -Recurse $tempLocation}
If(Test-path $zipfile) {Remove-item $zipfile -Force}

foreach ($item in $LOGS.Location){
    Copy-Item -Path $item -Destination $tempLocation -Recurse
}

Add-Type -assembly "system.io.compression.filesystem"

[io.compression.zipfile]::CreateFromDirectory($tempLocation, $zipfile) 
#Compress-Archive -Path $destination -DestinationPath $zipfile
Remove-Item -Recurse $tempLocation -Force
}

[xml]$form = Get-Content -Path $scriptPath\Form.xml

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
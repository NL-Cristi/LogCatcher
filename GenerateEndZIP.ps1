$scriptPath = split-path -parent $MyInvocation.MyCommand.Definition
$UnzipLogCatcher=$scriptPath+"\LogCatcher"
$FileToReadVersion = $scriptPath+"\LogCatcher\LogsDefinition\FolderContents.txt"
$Version=Get-Content $FileToReadVersion -Head 1
$LogCatcherZipFile =$scriptPath+"\"+$Version+".zip"
Add-Type -assembly "system.io.compression.filesystem"
[io.compression.zipfile]::CreateFromDirectory($UnzipLogCatcher, $LogCatcherZipFile)

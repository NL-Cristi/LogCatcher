
If (-NOT ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator))
{
  # Relaunch as an elevated process:
  Start-Process powershell.exe "-File",('"{0}"' -f $MyInvocation.MyCommand.Path) -Verb RunAs
  exit
}
# Now running elevated so launch the script:
$scriptPath = split-path -parent $MyInvocation.MyCommand.Definition
$IISLogsDefinition = "$scriptPath\LogsDefinition\LOGS.CSV"
$FormLocation = "$scriptPath\Form\Form.xml"
$IISRelated = "$scriptPath\ScriptErrors\IISRelated.log"

. $scriptPath\General\Functions.ps1

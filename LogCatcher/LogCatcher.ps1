<#
  .SYNOPSIS
  Collects IIS logs easy way.

  .DESCRIPTION
  The LogCatcher.ps1 script collects all IIS realted logs needed for troubleshooting

  .PARAMETER Quiet
  Runs the toll CLI mod, NO UI.
 .PARAMETER ZipLocation
  Specifies the Folder where the zip will be created, by default ZIP will be created in the Script Folder.
  Input needs to be a string. ex: "c\Temp" with NO training "\"
  .PARAMETER LogAge
  Specifies the Age of the logs you want to collect. LogAge = Days.
  By default LogAge is set for 2 days.
  
  .PARAMETER SiteIds
  Specifies the SiteIDs that you want to collect logs for. Format is comma seperated string. 
  By default SiteIDs is set for ALL sites hosted in IIS.

 
  .INPUTS
  None. You cannot pipe objects to Update-Month.ps1.

  .OUTPUTS
  None. LogCatcher.ps1 generates a zip in the Folder where the script is by default.

  .EXAMPLE 
To start Tool with UI
  .\LogCatcher.ps1

  .EXAMPLE
To start Tool with CLI and custom ZIP location
  .\LogCatcher.ps1 -Quiet $true -ZipLocation "C:\Temp"

    .EXAMPLE
To change AGE of logs and Sites that are collecter:
  .\LogCatcher.ps1 -Quiet $true -LogAge 45 -SiteIds "1,2,3,4" 

      .EXAMPLE
Example showing all Param options:
  .\LogCatcher.ps1 -Quiet $true -LogAge 45 -SiteIds "1,2,3,4" -ZipLocation "C:\Temp"
#>
param (
  [Parameter()]
  [bool] $Quiet,
  [String] $ZipLocation,
  [int32] $LogAge,
  [String] $SiteIds
)
$Global:scriptPath = split-path -parent $MyInvocation.MyCommand.Definition
If (-NOT ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)) {
  # Relaunch as an elevated process:
  Start-Process powershell.exe "-File", ('"{0}"' -f $MyInvocation.MyCommand.Path) -Verb RunAs
  exit
}
# Now running elevated so launch the script:

. $scriptPath\General\Defaults.ps1

switch ($Quiet) {
  $true {
    
    . $scriptPath\General\CLI.ps1
    
  }
  Default {
    . $scriptPath\General\UI.ps1
  }
}

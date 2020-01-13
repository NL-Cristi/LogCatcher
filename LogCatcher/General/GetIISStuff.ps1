Function Get-IIS-Stuff {

    $Time = Get-Date
    
        Import-Module IISAdministration -ErrorAction silentlycontinue -ErrorVariable +ErrorMessages
        Import-Module WebAdministration -ErrorAction Stop
        Foreach ($Message in $ErrorMessages) {
            $Time = Get-Date
            $ErroText = $Message.Exception.Message
            "$Time Exception Message: $ErroText" | Out-File $ToolLog -Append
        }    
}
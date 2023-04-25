$return = $null
$return = @()

if (Get-Command -Name Get-DhcpServerv4ScopeStatistics -ea 0) {
    $query = Get-DhcpServerv4ScopeStatistics
}
else {
    exit
}

foreach ($item in $query) {
    $Object = $null
    $Object = New-Object System.Object
    $Object | Add-Member -type NoteProperty -Name ScopeId -Value $item.ScopeId.IPAddressToString
    $Object | Add-Member -type NoteProperty -Name Free -Value $item.Free
    $Object | Add-Member -type NoteProperty -Name InUse -Value $item.InUse
    $Object | Add-Member -type NoteProperty -Name PercentageInUse -Value $item.PercentageInUse
    $Object | Add-Member -type NoteProperty -Name Reserved -Value $item.Reserved

    $Return += $Object
}

if (![string]::IsNullOrEmpty($return)) {
    $Return = ConvertTo-Json -Compress -InputObject @($return)
    $Return = $Return -replace '"', '\"'
    $Return = '\"' + $return + '\"'

    Set-Location 'C:\Program Files\Zabbix Agent 2'
    .\zabbix_sender.exe -c .\zabbix_agent2.conf -k ResultsDhcpScope -o $Return
    Set-Location -
}
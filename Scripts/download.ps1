$SCRIPT = @('dhcp','hyperv','download')
$CONF = @('General')

if (!(Test-Path "C:\Program Files\Zabbix Agent 2\scripts")) {
    New-Item -ItemType Directory -Force -Path "C:\Program Files\Zabbix Agent 2\scripts"
}
foreach ($LOOP_SCRIPT in $SCRIPT) {
    Invoke-WebRequest "https://raw.githubusercontent.com/DindonSama/POWERSHELL/main/Scripts/$LOOP_SCRIPT.ps1" -OutFile "C:\Program Files\Zabbix Agent 2\scripts\$LOOP_SCRIPT.ps1"
}

if (!(Test-Path "C:\Program Files\Zabbix Agent 2\zabbix_agent2.d")) {
    New-Item -ItemType Directory -Force -Path "C:\Program Files\Zabbix Agent 2\zabbix_agent2.d"
}
foreach ($LOOP_CONF in $CONF) {
    Invoke-WebRequest "https://raw.githubusercontent.com/DindonSama/POWERSHELL/main/zabbix_agent2.d/$CONF.conf" -OutFile "C:\Program Files\Zabbix Agent 2\zabbix_agent2.d\$CONF.conf"
}
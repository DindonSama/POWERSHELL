Param (
    [Parameter(Position=0,Mandatory=$False)][string]$Feature
)

function Function_Feature {
    $query = Get-WindowsFeature | Where-Object {($_.InstallState -EQ "Installed") -and ($_.Name -EQ $Feature)} | Select-Object Name 

    return ConvertTo-Json $query -Compress
}

if ($Feature) {
    Write-Host $(Function_Feature)
}
else {
    Write-Host "Syntax error: Use Name of Feature as first argument"
}
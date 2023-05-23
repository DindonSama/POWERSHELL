Param (
    [Parameter(Position = 0, Mandatory = $False)][string]$action
)

if (Get-Command -Name Get-ADDomain -ea 0) {
    $query = Get-ADDomain
}
else {
    Write-Output 'No AD server on this machine'
    exit 1
}

function lld {
    $to_json = $null
    $to_json = @()
    foreach ($item in $query) {
        $Object = $null
        $Object = New-Object System.Object
        $Object | Add-Member -type NoteProperty -Name "{#AD.NAME}" -Value $item.Name
        $Object | Add-Member -type NoteProperty -Name "{#AD.FOREST}" -Value $item.Forest
        $Object | Add-Member -type NoteProperty -Name "{#AD.DOMAINMODE}" -Value $item.DomainMode
    
        $to_json += $Object        
    }

    return ConvertTo-Json -Compress -InputObject @($to_json)
}

function full {
    $query | foreach-object {
        $data = [psobject]@{"DomainMode"      = [int]$_.DomainMode;
                            "Name"            = [int]$_.Name
        }
        $to_json += @{[string]$_.Forest = $data }
    }
    return ConvertTo-Json $to_json -Compress
}

switch ($action) {
    "lld" {
        return $(lld)
    }
    "full" {
        return $(full)
    }
    Default { 
        Write-Host "Syntax error: Use 'lld' or 'full' as first argument" 
        exit 1
    }
}
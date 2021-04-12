param([switch]$BuildOnly = $false, [switch]$Azure = $false, [switch]$Detach = $false, [switch]$Force = $false)

$stringBuilder = New-Object -TypeName "System.Text.StringBuilder"
 
##C:\Program Files\Docker\Docker\resources\bin\
[void]$stringBuilder.Append("docker compose -f docker-compose-data.yml ")
[void]$stringBuilder.Append("-f docker-compose-support.yml ")

if ($Azure) {
    [void]$stringBuilder.Append("-f docker-compose-azure.yml ")
}

if ($BuildOnly) {
    Write-Host "===========================" -ForegroundColor DarkYellow -BackgroundColor DarkBlue
    Write-Host "Build: docker-compose build" -ForegroundColor DarkYellow -BackgroundColor DarkBlue
    Write-Host "===========================" -ForegroundColor DarkYellow -BackgroundColor DarkBlue
    [void]$stringBuilder.Append("build")
} else {
    Write-Host "===================================" -ForegroundColor DarkYellow -BackgroundColor DarkBlue
    Write-Host "Build and Deploy: docker-compose up" -ForegroundColor DarkYellow -BackgroundColor DarkBlue
    Write-Host "===================================" -ForegroundColor DarkYellow -BackgroundColor DarkBlue
    [void]$stringBuilder.Append("up --build")
    
    if ($Force) {
        [void]$stringBuilder.Append(" --force-recreate --renew-anon-volumes")
    }

    if ($Detach) {
        [void]$stringBuilder.Append(" --detach")
    }
}

$command = $stringBuilder.ToString()
Write-Host "Command: $command" -ForegroundColor Green 

$scriptBlock = [scriptblock]::Create($command);
Invoke-Command -ScriptBlock $scriptBlock
$stringBuilder = New-Object -TypeName "System.Text.StringBuilder"
 
##C:\Program Files\Docker\Docker\resources\bin\
[void]$stringBuilder.Append("docker compose -f docker-compose-data.yml ")
[void]$stringBuilder.Append("-f docker-compose-support.yml ")
[void]$stringBuilder.Append("-f docker-compose-azure.yml ")
[void]$stringBuilder.Append("stop")

$command = $stringBuilder.ToString()
Write-Host "Command: $command" -ForegroundColor Green 

$scriptBlock = [scriptblock]::Create($command);
Invoke-Command -ScriptBlock $scriptBlock
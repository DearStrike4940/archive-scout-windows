$ErrorActionPreference = "SilentlyContinue"
$InstallRoot = Join-Path $env:LOCALAPPDATA "Programs\Archive Scout"
$StartMenu = Join-Path $env:APPDATA "Microsoft\Windows\Start Menu\Programs"
$Desktop = [Environment]::GetFolderPath("Desktop")
Remove-Item (Join-Path $StartMenu "Archive Scout.lnk") -Force
Remove-Item (Join-Path $StartMenu "Uninstall Archive Scout.lnk") -Force
Remove-Item (Join-Path $Desktop "Archive Scout.lnk") -Force
Start-Process powershell.exe -WindowStyle Hidden -ArgumentList "-NoProfile -Command Start-Sleep -Seconds 2; Remove-Item -LiteralPath '$InstallRoot' -Recurse -Force"

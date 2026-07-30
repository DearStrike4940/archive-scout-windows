$ErrorActionPreference = "Stop"
$Source = Join-Path $PSScriptRoot "Archive Scout"
$InstallRoot = Join-Path $env:LOCALAPPDATA "Programs\Archive Scout"
$StartMenu = Join-Path $env:APPDATA "Microsoft\Windows\Start Menu\Programs"
$Desktop = [Environment]::GetFolderPath("Desktop")
if (-not (Test-Path $Source)) { throw "Archive Scout application folder is missing." }
if (Test-Path $InstallRoot) { Remove-Item $InstallRoot -Recurse -Force }
New-Item -ItemType Directory -Force -Path $InstallRoot | Out-Null
Copy-Item (Join-Path $Source "*") $InstallRoot -Recurse -Force
Copy-Item (Join-Path $PSScriptRoot "uninstall.ps1") $InstallRoot -Force
Copy-Item (Join-Path $PSScriptRoot "Uninstall Archive Scout.cmd") $InstallRoot -Force
$Exe = Join-Path $InstallRoot "Archive Scout.exe"
$Shell = New-Object -ComObject WScript.Shell
$Shortcut = $Shell.CreateShortcut((Join-Path $StartMenu "Archive Scout.lnk"))
$Shortcut.TargetPath = $Exe
$Shortcut.WorkingDirectory = $InstallRoot
$Shortcut.IconLocation = $Exe
$Shortcut.Save()
$DesktopShortcut = $Shell.CreateShortcut((Join-Path $Desktop "Archive Scout.lnk"))
$DesktopShortcut.TargetPath = $Exe
$DesktopShortcut.WorkingDirectory = $InstallRoot
$DesktopShortcut.IconLocation = $Exe
$DesktopShortcut.Save()
$UninstallShortcut = $Shell.CreateShortcut((Join-Path $StartMenu "Uninstall Archive Scout.lnk"))
$UninstallShortcut.TargetPath = Join-Path $InstallRoot "Uninstall Archive Scout.cmd"
$UninstallShortcut.WorkingDirectory = $InstallRoot
$UninstallShortcut.Save()
Start-Process $Exe

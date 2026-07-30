$ErrorActionPreference = "Stop"
$Root = Split-Path -Parent $PSScriptRoot
Set-Location $Root
$Release = Join-Path $Root "release"
$PackageRoot = Join-Path $Root "package-root"
Remove-Item build, dist, $Release, $PackageRoot -Recurse -Force -ErrorAction SilentlyContinue
New-Item -ItemType Directory -Force -Path $Release, $PackageRoot | Out-Null
python -m PyInstaller --noconfirm --clean --windowed --onedir --collect-all truststore --name "Archive Scout" run_app.py
Copy-Item (Join-Path $Root "dist\Archive Scout") (Join-Path $PackageRoot "Archive Scout") -Recurse -Force
Copy-Item (Join-Path $Root "packaging\windows\install.ps1") $PackageRoot -Force
Copy-Item (Join-Path $Root "packaging\windows\uninstall.ps1") $PackageRoot -Force
Copy-Item (Join-Path $Root "packaging\windows\Install Archive Scout.cmd") $PackageRoot -Force
Copy-Item (Join-Path $Root "packaging\windows\Uninstall Archive Scout.cmd") $PackageRoot -Force
$Archive = Join-Path $Release "ArchiveScout-Windows-x64.zip"
Compress-Archive -Path (Join-Path $PackageRoot "*") -DestinationPath $Archive -CompressionLevel Optimal -Force
$Hash = (Get-FileHash -Algorithm SHA256 $Archive).Hash.ToLower()
"$Hash  ArchiveScout-Windows-x64.zip" | Set-Content -Encoding ascii (Join-Path $Release "ArchiveScout-Windows-x64.zip.sha256")

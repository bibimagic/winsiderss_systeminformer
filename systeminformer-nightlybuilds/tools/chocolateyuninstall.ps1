$RegPath = "HKLM:\Software\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\taskmgr.exe"
if (Test-Path $RegPath) { Remove-Item $RegPath -Recurse }

Uninstall-ChocolateyZipPackage -Packagename $env:ChocolateyPackageName -ZipFileName "systeminformer-3.1.24232-release-bin.zip"

$InstallDirectory =
Join-Path `
  -Path $(if (Get-OSArchitectureWidth 64) { $Env:ProgramW6432 } else { $Env:ProgramFiles }) `
  -ChildPath "SystemInformer"
if (Test-Path $InstallDirectory) { Remove-Item $InstallDirectory -Recurse }

$ShortcutPath = "$Env:PUBLIC\Desktop\System Informer.lnk"
if (Test-Path $ShortcutPath) { Remove-Item $ShortcutPath }

Uninstall-ChocolateyZipPackage -Packagename $env:ChocolateyPackageName -ZipFileName "systeminformer-3.1.24208-release-bin.zip"

$InstallDirectory =
Join-Path `
  -Path $(if (Get-OSArchitectureWidth 64) { $Env:ProgramW6432 } else { $Env:ProgramFiles }) `
  -ChildPath "SystemInformer"
if (Test-Path $InstallDirectory) { Remove-Item $InstallDirectory -Recurse }

$ShortcutPath = "$Env:PUBLIC\Desktop\System Informer.lnk"
if (Test-Path $ShortcutPath) { Remove-Item $ShortcutPath }

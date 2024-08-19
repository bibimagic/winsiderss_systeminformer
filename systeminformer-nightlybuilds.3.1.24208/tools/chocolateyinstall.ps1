$PackageSourceUrl = "https://github.com/winsiderss/si-builds/releases/download/3.1.24208/systeminformer-3.1.24208-release-bin.zip"
$Architecture = if (Get-OSArchitectureWidth 32) { "i386" } else { "amd64" }
$InstallDirectory =
Join-Path `
  -Path $(if (Get-OSArchitectureWidth 64) { $Env:ProgramW6432 } else { $Env:ProgramFiles }) `
  -ChildPath "SystemInformer"

$PackageParams = @{
  PackageName    = "systeminformer-nightlybuilds"
  UnzipLocation  = $InstallDirectory
  Url            = $PackageSourceUrl
  Checksum       = '86AA4237565375FF214368FA855B8304BC4675F4BD547F7C7EF654C3A9BE5FD1'
  ChecksumType   = 'sha256'
  SpecificFolder = $Architecture
}

Install-ChocolateyZipPackage @PackageParams

$ShortcutParams = @{
  ShortcutFilePath = "$Env:PUBLIC\Desktop\System Informer.lnk"
  TargetPath       = "$InstallDirectory\$Architecture\SystemInformer.exe"
  IconLocation     = "$InstallDirectory\$Architecture\SystemInformer.exe"
}

Install-ChocolateyShortcut @ShortcutParams

$PackageParams = Get-PackageParameters
if ($PackageParams["defaultTaskMgr"]) {
  $RegPath = "HKLM:\Software\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\taskmgr.exe"
  if (-not $(Test-Path $RegPath)) { New-Item $RegPath }
  New-ItemProperty -Path $RegPath -Name "Debugger" -PropertyType "String" -Value "$InstallDirectory\$Architecture\SystemInformer.exe"
}

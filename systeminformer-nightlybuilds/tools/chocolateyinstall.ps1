$PackageSourceUrl = "https://github.com/winsiderss/si-builds/releases/download/3.1.24232/systeminformer-3.1.24232-release-bin.zip"
$Architecture = if (Get-OSArchitectureWidth 32) { "i386" } else { "amd64" }
$InstallDirectory =
Join-Path `
  -Path $(if (Get-OSArchitectureWidth 64) { $Env:ProgramW6432 } else { $Env:ProgramFiles }) `
  -ChildPath "SystemInformer"

$PackageParams = @{
  PackageName    = "systeminformer-nightlybuilds"
  UnzipLocation  = $InstallDirectory
  Url            = $PackageSourceUrl
  Checksum       = "5d0ca822a5a34ede6abe6a89170725e2b63eae1eeadcaa3fa0f1fda2d8da8d2a"
  ChecksumType   = "sha256"
  SpecificFolder = $Architecture
}

Install-ChocolateyZipPackage @PackageParams

$PackageParams = Get-PackageParameters

switch ($PackageParams) {
  "shortcut" {
    $ShortcutParams = @{
      ShortcutFilePath = "$Env:PUBLIC\Desktop\System Informer.lnk"
      TargetPath       = "$InstallDirectory\$Architecture\SystemInformer.exe"
      IconLocation     = "$InstallDirectory\$Architecture\SystemInformer.exe"
    }
    Install-ChocolateyShortcut @ShortcutParams
  }
  "defaultTaskMgr" {
    $RegPath = "HKLM:\Software\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\taskmgr.exe"
    if (-not $(Test-Path $RegPath)) { New-Item $RegPath }
    New-ItemProperty -Path $RegPath -Name "Debugger" -PropertyType "String" -Value "$InstallDirectory\$Architecture\SystemInformer.exe"
  }
}

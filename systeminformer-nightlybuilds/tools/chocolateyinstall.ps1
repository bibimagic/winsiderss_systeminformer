$PackageSourceUrl = "https://github.com/winsiderss/si-builds/releases/download/3.2.25011/systeminformer-3.2.25011-release-bin.zip"
$Architecture = if (Get-OSArchitectureWidth 32) { "i386" } else { "amd64" }
$InstallDirectory = "$(if (Get-OSArchitectureWidth 64) { $Env:ProgramW6432 } else { $Env:ProgramFiles })\SystemInformer"

$PackageParams = @{
  PackageName    = "systeminformer-nightlybuilds"
  UnzipLocation  = $InstallDirectory
  Url            = $PackageSourceUrl
  Checksum       = "7e72019361eec58479604597dbfcd911c6d23c45da22c0bedc2bc319ab5b331a"
  ChecksumType   = "sha256"
  SpecificFolder = $Architecture
}

Install-ChocolateyZipPackage @PackageParams

# Restore backed up setting file
$SettingFile = "$Env:TEMP\SystemInformer.exe.settings.xml"
if (Test-Path $SettingFile) {
  Copy-Item -Path $SettingFile -Destination "$InstallDirectory\$Architecture" | Out-Null
}

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

$Architecture = if (Get-OSArchitectureWidth 32) { "i386" } else { "amd64" }
$InstallDirectory = "$(if (Get-OSArchitectureWidth 64) { $Env:ProgramW6432 } else { $Env:ProgramFiles })\SystemInformer"
$SettingFilePath = "$InstallDirectory\$Architecture\SystemInformer.exe.settings.xml"

Copy-Item -Path $SettingFilePath -Destination $Env:TEMP

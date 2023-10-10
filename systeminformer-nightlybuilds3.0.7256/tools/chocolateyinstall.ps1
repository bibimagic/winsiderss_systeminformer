$packageArgs = @{
  packageName    = 'systeminformer-nightlybuilds'
  fileType       = 'exe'
  url            = "https://github.com/winsiderss/si-builds/releases/download/3.0.7256/systeminformer-3.0.7256-setup.exe"
  softwareName   = 'System Informer'
  checksum       = '2243762B0127BEA893983692AC7F20285ED9A9F5'
  checksumType   = 'sha1'
  silentArgs     = '-silent'
  validExitCodes = @(0)
}

Install-ChocolateyPackage @packageArgs
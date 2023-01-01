$packageArgs = @{
  packageName    = 'systeminformer-nightlybuilds'
  fileType       = 'exe'
  url            = "https://github.com/winsiderss/si-builds/releases/download/3.0.5727/systeminformer-3.0.5727-setup.exe"
  softwareName   = 'System Informer'
  checksum       = 'BA572B3BC93BF0C34D1958757CD7BEE17DCB78E5'
  checksumType   = 'sha1'
  silentArgs     = '-silent'
  validExitCodes = @(0)
}

Install-ChocolateyPackage @packageArgs
$packageArgs = @{
  packageName    = 'systeminformer-nightlybuilds'
  fileType       = 'exe'
  url            = "https://github.com/winsiderss/si-builds/releases/download/3.0.5578/systeminformer-3.0.5578-setup.exe"
  softwareName   = 'System Informer'
  checksum       = 'C2E776DC1DAC1D36C503824CF30F161A4CF28BCC'
  checksumType   = 'sha1'
  silentArgs     = '-silent'
  validExitCodes = @(0)
}

Install-ChocolateyPackage @packageArgs
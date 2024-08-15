$packageArgs = @{
  packageName    = 'systeminformer-nightlybuilds'
  fileType       = 'exe'
  url            = "https://github.com/winsiderss/si-builds/releases/download/3.1.24208/systeminformer-3.1.24208-release-setup.exe"
  softwareName   = 'System Informer'
  checksum       = '9183ED432BF82809B1F13D73EB5F0E44D91C3881887C47A28BDDB04356E8EC70'
  checksumType   = 'sha256'
#  silentArgs     = '-silent'
  validExitCodes = @(0)
}

Install-ChocolateyPackage @packageArgs

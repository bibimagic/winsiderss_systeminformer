Import-Module chocolatey-au

function global:au_SearchReplace {
    @{
        'tools\chocolateyinstall.ps1'   = @{
            "(\t*PackageSourceUrl\s*=\s*)(`".*`")" = "`$1`"$($Latest.Url32)`""
            "(\t*Checksum\s*=\s*)(`".*`")"         = "`$1`"$($Latest.Checksum32)`""
        }
        'tools\chocolateyuninstall.ps1' = @{
            "systeminformer-.*?-release-bin\.zip" = "$($Latest.Filename)"
        }
    }
}

function global:au_GetLatest {
    # This repo has releases for the cli tool as well as VS Code vsix
    $releaseInfo = Invoke-RestMethod -Method Get -Uri "https://api.github.com/repos/winsiderss/si-builds/releases/latest"

    $asset = $releaseInfo.assets | Where-Object { $_.name -eq "systeminformer-$($releaseInfo.tag_name)-release-bin.zip" }

    $Latest = @{
        Filename = $asset.name
        Version  = $releaseInfo.tag_name
        Url32    = $asset.browser_download_url
    }
    return $Latest
}

update

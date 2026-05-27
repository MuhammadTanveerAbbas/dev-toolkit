Write-Host "  __ _        _         _  _         _  __        _    _ _    _ "
Write-Host " / _(_)      (_)       | |(_)       | |/ /       | |  | | |  (_)"
Write-Host "| |_ _ _   ___  ___  __| | _   ___  | ' / ___  ___| | _| | | ___ "
Write-Host "|  _| | | | \ \/ / |/ _` || | / __| |  < / _ \/ _ \ |/ / | |/ / "
Write-Host "| | | | |_| |>  <| | (_| || || (__  | . \  __/  __/   <| |   <  "
Write-Host "|_| |_|\__, /_/\_\_|\__,_||_| \___| |_|\_\___|\___|_|\_\_|_|\_\ "
Write-Host "        __/ |                                                    "
Write-Host "       |___/                                                     "
Write-Host ""
Write-Host "  The MVP Guy Dev Toolkit — themvpguy.vercel.app" -ForegroundColor DarkGray
Write-Host ""

$installDir = "$HOME\bin"
if (-not (Test-Path $installDir)) {
    New-Item -ItemType Directory -Force -Path $installDir | Out-Null
}

Copy-Item "dev-toolkit" "$installDir\dev-toolkit" -Force

$bashrc = "$HOME\.bashrc"
if (-not (Select-String -Path $bashrc -Pattern "HOME/bin" -Quiet 2>$null)) {
    Add-Content $bashrc "`nexport PATH=`"`$HOME/bin:`$PATH`""
}

Write-Host ""
Write-Host "✓ dev-toolkit installed" -ForegroundColor Green
Write-Host ""
Write-Host "  Run: dev-toolkit" -ForegroundColor Cyan
Write-Host ""

$installOthers = Read-Host "Install other MVP Guy tools (mgit, git-rescue, env-guard, devmon, cursor-reset)? (y/n)"
if ($installOthers -eq "y") {
    $repos = @("mgit", "git-rescue", "env-guard", "devmon", "cursor-reset")
    foreach ($repo in $repos) {
        Write-Host "→ Installing $repo..." -ForegroundColor DarkGray
        $tmpDir = [System.IO.Path]::GetTempPath() + [System.Guid]::NewGuid().ToString()
        git clone "https://github.com/MuhammadTanveerAbbas/$repo.git" $tmpDir 2>$null
        if (Test-Path "$tmpDir\install.sh") {
            bash "$tmpDir\install.sh" 2>$null
            Write-Host "✓ $repo installed" -ForegroundColor Green
        } else {
            Write-Host "  $repo — manual install needed" -ForegroundColor Yellow
        }
        Remove-Item -Recurse -Force $tmpDir -ErrorAction SilentlyContinue
    }
}

Write-Host ""
Write-Host "  Built by The MVP Guy — themvpguy.vercel.app" -ForegroundColor DarkGray
Write-Host ""

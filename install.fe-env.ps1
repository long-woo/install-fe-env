# 系统版本
$osVersion = (Get-CimInstance -class Win32_OperatingSystem).Version

# 拆分版本
#  $arrVersion = $osVersion.Split('.').Trim()
#  $mainVersion = $arrVersion[0] + '.' + $arrVersion[1]
#  $lastVersion = $arrVersion[2]

echo 'Windows 版本：'$osVersion

# 判断当前版本是否满足安装 winget
#  If ($mainVersion -lt 10 -and $lastVersion -lt 1709) return

# 下载 winget 并打开
# $winget = '.\Downloads\winget.msixbundle'

# echo '下载 winget...'
# (New-Object System.Net.WebClient).DownloadFile('https://github.com/microsoft/winget-cli/releases/download/v1.0.11692/Microsoft.DesktopAppInstaller_8wekyb3d8bbwe.msixbundle', $winget)

# echo 'winget 安装中...'
# $winget

# 检查是否已经安装 Choco
If (!(choco --version)) {
  # 安装 Choco
  $installDir = 'c:\ProgramData\chocoportable'
  $env:ChocolateyInstall = "$InstallDir"

  # 若 PowerShell 执行策略是限制性的，需要绕过策略安装
  If (Get-ExecutionPolicy -eq 'Restricted') {
    Set-ExecutionPolicy Bypass -Scope Process -Force
  }

  # 下载 Choco 安装脚本
  iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))
  echo 'Choco 版本：'choco --version
}


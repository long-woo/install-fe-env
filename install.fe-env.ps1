# 系统版本
$osVersion = (Get-CimInstance -class Win32_OperatingSystem).Version

# 拆分版本
#  $arrVersion = $osVersion.Split('.').Trim()
#  $mainVersion = $arrVersion[0] + '.' + $arrVersion[1]
#  $lastVersion = $arrVersion[2]

'Windows 版本：'$osVersion

# 检查命令是否存在
function checkCommand([string]$cmd) {
  $cmdName = ''

  Try {
    $cmdName = (Get-Command $cmd -ErrorAction Stop).Name
  } Catch {}

  Return $cmdName -ne ''
}

# 设置 NPM 淘宝源
function setNpmConfig {
  npm set registry https://registry.npm.taobao.org # 注册模块镜像
  npm set disturl https://npm.taobao.org/dist # node-gyp 编译依赖的 node 源码镜像
  npm set sass_binary_site https://npm.taobao.org/mirrors/node-sass # node-sass 二进制包镜像
  npm set electron_mirror https://npm.taobao.org/mirrors/electron/ # electron 二进制包镜像
  npm set puppeteer_download_host https://npm.taobao.org/mirrors # puppeteer 二进制包镜像
  npm set chromedriver_cdnurl https://npm.taobao.org/mirrors/chromedriver # chromedriver 二进制包镜像
  npm set operadriver_cdnurl https://npm.taobao.org/mirrors/operadriver # operadriver 二进制包镜像
  npm set phantomjs_cdnurl https://npm.taobao.org/mirrors/phantomjs # phantomjs 二进制包镜像
  npm set selenium_cdnurl https://npm.taobao.org/mirrors/selenium # selenium 二进制包镜像
  npm set node_inspector_cdnurl https://npm.taobao.org/mirrors/node-inspector # node-inspector 二进制包镜像
  npm set canvas_binary_host_mirror=https://npm.taobao.org/mirrors/node-canvas-prebuilt # node-canvas 二进制包镜像
  npm set sentrycli_cdnurl https://npm.taobao.org/mirrors/sentry-cli # sentry cli 镜像
  npm cache verify # 清空缓存
}

# 判断当前版本是否满足安装 winget
#  If ($mainVersion -lt 10 -and $lastVersion -lt 1709) return

# 下载 winget 并打开
# $winget = '.\Downloads\winget.msixbundle'

# echo '下载 winget...'
# (New-Object System.Net.WebClient).DownloadFile('https://github.com/microsoft/winget-cli/releases/download/v1.0.11692/Microsoft.DesktopAppInstaller_8wekyb3d8bbwe.msixbundle', $winget)

# echo 'winget 安装中...'
# $winget

# 检查是否已经安装 Choco
If (!(checkCommand choco)) {
  # 安装 Choco
  $installDir = 'c:\ProgramData\chocoportable'
  $env:ChocolateyInstall = "$InstallDir"

  # 若 PowerShell 执行策略是限制性的，需要绕过策略安装
  If (Get-ExecutionPolicy -eq 'Restricted') {
    Set-ExecutionPolicy Bypass -Scope Process -Force
  }

  # 下载 Choco 安装脚本
  iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))
  'Choco 版本：'choco --version
}

# 安装 Git
If (!(checkCommand git)) {
  '安装 Git...'
  choco install git
  'Git 已完成安装：'+ git --vresion
} Else {
  'Git 版本：'+ git --version
}

# 安装 Node.js
If (!(checkCommand node)) {
  '安装 Node.js...'
  choco install nodejs
  'Node.js 已完成安装：'+ node --version
  'Npm 版本：'+ npm --version
} Else {
  'Node.js 版本：'+ node --version
  'Npm 版本：'+ npm --version
}

# 检查 npm 源。若非淘宝源，则设置为淘宝源
$npmRegistry = npm config get registry
If ($npmRegistry -ne 'https://registry.npm.taobao.org/') {
  setNpmConfig
}

# 安装 pnpm
If (!(checkCommand pnpm)) {
  '安装 PNPM...'
  npm install -g pnpm
  'PNPM 已完成安装：'+ pnpm --version
} Else {
  'PNPM 版本：'+ pnpm --version
}

# 安装 @vue/cli、@vue/cli-init
If (!(checkCommand vue)) {
  '安装 @vue/cli、@vue/cli-init...'
  npm install -g @vue/cli @vue/cli-init
  '@vue/cli、@vue/cli-init 已完成安装'
}

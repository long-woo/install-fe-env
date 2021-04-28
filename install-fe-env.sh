#!/usr/bin/env bash

version="0.0.1"

# 系统
os=""
# 下载路径
downloadPath=~/Downloads/temp

if [ "$(uname)" = "Darwin" ]; then
  # Mac OS X 操作系统
  os="Mac"
elif [ "$(expr substr $(uname -s) 1 5)" = "Linux" ]; then   
  # GNU/Linux操作系统
  os="Linux"
elif [ "$(expr substr $(uname -s) 1 10)" = "MINGW32_NT" || "$(expr substr $(uname -s) 1 10)" = "MINGW64_NT" ]; then    
  # Windows NT操作系统
  os="Windows"
fi

echo "系统：$os"

command_exists () {
  command -v "$1" >/dev/null 2>&1
}

if command_exists node; then
  echo "Node 版本：$(node --version)"
else
  # 下载 nodejs
  echo "\n下载 nodejs..."
  # https://nodejs.org/dist/v14.16.1/node-v14.16.1-x64.msi
  wget https://nodejs.org/dist/v14.16.1/node-v14.16.1.pkg -P $downloadPath -c

  # 安装 nodejs
  echo "nodejs 下载完成，正在安装..."
  open "$downloadPath/node-v14.16.1.pkg"
fi

if command_exists yarn; then
  echo "Yarn 版本：$(yarn --version)"
else
  # 安装 yarn
  npm install -g yarn
fi

if command_exists vue; then
  echo "Vue-cli 版本：$(vue --version)"
else
  # 安装 vue-cli
  npm install -g @vue/cli @vue/cli-init
fi
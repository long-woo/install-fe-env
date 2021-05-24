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

if ["$os" = "Mac"]; then
  source "$(dirname $0)/install/mac.sh"
fi

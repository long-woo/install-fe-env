# 命令检查
function command_exists() {
  echo "检查 $1 命令..."
  command -v "$1" >/dev/null 2>&1
}

# Homebrew 设置为阿里源
function brewConfig() {
  echo "设置阿里源 \t ..."
  echo "# brew 阿里源 \n export HOMEBREW_BOTTLE_DOMAIN=https://mirrors.aliyun.com/homebrew/homebrew-bottles" >> ~/.bash_profile

  # 修改后生效
  source ~/.bash_profile
  echo "完成"
}

# 设置淘宝源
function npmConfig() {
  echo "设置淘宝源 \t ..."
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
  npm cache verify # 清空缓存
  echo "完成"
}

# 安装 Homebrew
if command_exists brew; then
  echo "brew 版本：$(brew --version)"

  # 如果没有设置 HOMEBREW_BOTTLE_DOMAIN 源
  if [ -z "$HOMEBREW_BOTTLE_DOMAIN" ]; then
    brewConfig
  fi
else
  # 下载 Homebrew，并安装
  sh -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

  # 设置 Homebrew
  brewConfig
fi

# 安装 Git
if command_exists git; then
  echo "git 版本：$(git --version)"
else
  brew install git
fi

# 安装 oh-my-zsh
if command_exists zsh; then
  echo "zsh 版本：$(zsh --version)"
else
  sh -c "$(wget https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh -O -)"

  # 安装 zsh-autosuggestions 插件
  git clone https://github.com/zsh-users/zsh-autosuggestions ~/.zsh/zsh-autosuggestions
  echo "\n# zsh-autosuggestions 插件 \n source ~/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh" >> ~/.zshrc

  # 安装 zsh-syntax-highlighting 插件
  git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ~/.zsh/zsh-syntax-highlighting
  echo "\n# zsh-syntax-highlighting 插件 \n source ~/.zsh/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh" >> ~/.zshrc

  # .bash_profile 添加到 zshrc
  echo "\n source ~/.bash_profile" >> ~/.zshrc
fi

# 安装 nodejs
if command_exists node; then
  echo "node 版本：$(node --version)"

  # 检查是否设置为淘宝源
  npmRegistry=`npm config get registry`
  if [ $npmRegistry != "https://registry.npm.taobao.org/" ]; then
    npmConfig
  fi
else
  brew install node

  # 修改 npm 配置
  npmConfig
fi

# 安装 yarn
if command_exists yarn; then
  echo "yarn 版本：$(yarn --version)"
else
  npm install -g yarn
fi

# 安装 vue-cli
if command_exists vue; then
  echo "vue-cli 版本：$(vue --version)"
else
  npm install -g @vue/cli @vue/cli-init
fi

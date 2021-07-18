# install-fe-env

快速安装前端环境脚本。

## 安装

### Mac

复制下面命令到 `PowerShell` 中按 `回车（Enter）` 键执行：

```sh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/long-woo/install-fe-env/main/install-fe-env.sh)"
```

### Windows

1. 快捷键 `win` + `r` 打开运行窗口，输入 `powershell`。

2. 复制下面命令到 `PowerShell` 中按 `回车（Enter）` 键执行：

```ps1
Set-ExecutionPolicy Bypass -Scope Process -Force; iex ((New-Object System.Net.WebClient).DownloadString('https://raw.githubusercontent.com/long-woo/install-fe-env/main/install.fe-env.ps1'))
```

## 已实现安装，并配置国内镜像源

- [x] brew - Mac
- [x] git
- [x] zsh - Mac
- [x] nodejs & npm
- [x] yarn
- [x] @vue/cli & @vue/cli-init

#!/usr/bin/env bash

# Make sure pwd is the directory of the script
cd "$(dirname "$0")"

if ! command -v npm &> /dev/null
then
    read -p "还没安装npm，现在安装nodejs和npm吗? (y/n)" choice
    case "$choice" in
      y|Y )
        echo "nvm安装中..."
        export NVM_DIR="$([ -z "${XDG_CONFIG_HOME-}" ] && printf %s "${HOME}/.nvm" || printf %s "${XDG_CONFIG_HOME}/nvm")"
        [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
        curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.3/install.sh | bash
        source ~/.bashrc
        nvm install --lts
        nvm use --lts;;
      n|N )
        echo "不安装nvm，无法启动！"
        exit;;
      * )
        echo "你选了个啥呀？没安装nvm，无法启动！"
        exit;;
    esac
fi

if ! command -v go &> /dev/null
then
    read -p "还没安装go，现在安装go吗? (y/n)" choice
    case "$choice" in
      y|Y )
        echo "go安装中..."
        DEBIAN_FRONTEND=noninteractive apt-get install golang -y
        go version
      n|N )
        echo "不安装go，无法启动！"
        exit;;
      * )
        echo "你选了个啥呀？没安装go，无法启动！"
        exit;;
    esac
fi

echo "构建前端中..."
cd one-api/web/default
npm install
npm run build

echo "构建后端中..."
cd ../..
go mod download
go build -ldflags "-s -w" -o one-api

echo "One-Api启动中..."
chmod u+x one-api
./one-api --port 3000 --log-dir ./logs

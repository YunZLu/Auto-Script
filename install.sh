#!/usr/bin/env bash

# Make sure pwd is the directory of the script
cd "$(dirname "$0")"

if ! command -v go &> /dev/null
then
    read -p "还没安装npm，现在安装npm吗? (y/n)" choice
    case "$choice" in
      y|Y )
        echo "npm安装中..."
        DEBIAN_FRONTEND=noninteractive apt-get install npm -y
        go version;;
      n|N )
        echo "不安装npm，无法启动！"
        exit;;
      * )
        echo "你选了个啥呀？没安装npm，无法启动！"
        exit;;
    esac
fi

if ! command -v go &> /dev/null
then
    read -p "还没安装go，现在安装go吗? (y/n)" choice
    case "$choice" in
      y|Y )
        echo "go安装中..."
        yes | apt update
        DEBIAN_FRONTEND=noninteractive apt-get install golang -y
        go version;;
      n|N )
        echo "不安装go，无法启动！"
        exit;;
      * )
        echo "你选了个啥呀？没安装go，无法启动！"
        exit;;
    esac
fi

echo "前端构建中..."
cd /root/one-api/web/default
npm install
npm run build

echo "后端构建中..."
cd ../..
go mod download
go build -ldflags "-s -w" -o one-api

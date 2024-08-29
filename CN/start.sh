#!/usr/bin/env bash

# Make sure pwd is the directory of the script
cd "$(dirname "$0")"

echo -e "\033[0;33m前端构建中喵...\n\033[0m"
cd web/default
npm install
npm run build
echo -e "\033[0;32m前端构建成功喵~\n\033[0m"

echo -e "\033[0;33m后端构建中喵...\n\033[0m"
cd ../..
echo "第一次下载依赖包会比较慢，耐心等待喵..."
go mod download
go build -ldflags "-s -w" -o one-api
echo -e "\033[0;32m后端构建中成功喵~\n\033[0m"

echo -e "\033[0;33mOne-Api启动中喵~\n\033[0m"
chmod u+x one-api
./one-api --port 3000 --log-dir ./logs

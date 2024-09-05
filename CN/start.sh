#!/usr/bin/env bash

# Make sure pwd is the directory of the script
cd "$(dirname "$0")"

echo -e "\n\033[0;33m前端构建中，请稍等一下喵...\033[0m"
cd web/default
npm install
npm run build
echo -e "\033[0;32m前端构建成功喵~\n\033[0m"

echo -e "\033[0;33m后端构建中，请稍等一下喵...\n\033[0m"
cd ../..
echo -e "\033[0;33m如果是第一次下载依赖包，会比较慢，请耐心等待喵~\033[0m"
go mod download
go build -ldflags "-s -w" -o one-api
echo -e "\n\033[0;32m后端构建成功喵~\033[0m"

echo -e "\n\033[0;33mOne-Api启动中，请稍等一下喵~\n\033[0m"
chmod u+x one-api
./one-api --port 3000 --log-dir ./logs

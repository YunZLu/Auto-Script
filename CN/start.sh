#!/usr/bin/env bash

# Make sure pwd is the directory of the script
cd "$(dirname "$0")"

echo "前端构建中喵..."
cd web/default
npm install
npm run build

echo "后端构建中喵..."
cd ../..
echo "第一次下载依赖包会比较慢，耐心等待喵..."
go mod download
go build -ldflags "-s -w" -o one-api

echo "One-Api启动中喵..."
chmod u+x one-api
./one-api --port 3000 --log-dir ./logs

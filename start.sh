#!/usr/bin/env bash

# Make sure pwd is the directory of the script
cd "$(dirname "$0")"

echo "One-Api启动中..."
chmod u+x /root/one-api
./one-api --port 3000 --log-dir ./logs

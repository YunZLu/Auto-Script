#!/bin/bash

echo "                                              
喵喵一键安卓脚本(only one-api CN版)
作者: 瑾年
来自: 头脑风暴搞起来
"

# 安装git
while ! command -v git &> /dev/null
do
    if ! command -v git &> /dev/null; then
    echo "检测到你未安装git喵~"
    echo "正在为你下载git喵~"
    DEBIAN_FRONTEND=noninteractive pkg install git -y
        if ! command -v git &> /dev/null; then
        echo "git下载失败了，正在重试中喵~"
	sleep 2
        continue
        fi
    fi
done
echo "git已安装喵~"

# 安装nodejs
while ! command -v node &> /dev/null
do
    if ! command -v node &> /dev/null; then
    echo "检测到你未安装nodejs喵~"
    echo "正在为你下载nodejs喵~"
    DEBIAN_FRONTEND=noninteractive pkg install nodejs -y
        if ! command -v node &> /dev/null; then
        echo "nodejs下载失败了，正在重试中喵~"
	sleep 2
        continue
        fi
    fi
done
echo "nodejs已安装喵~"
#设置npm国内源
npm config set registry https://registry.npmmirror.com

#安装go
while ! command -v go &> /dev/null
do
    if ! command -v go &> /dev/null; then
    echo "检测到你未安装go喵~"
    echo "正在为你下载go喵~"
    DEBIAN_FRONTEND=noninteractive pkg install golang -y
        if ! command -v go &> /dev/null; then
        echo "go下载失败了，正在重试中喵~"
	sleep 2
        continue
        fi
    fi
done
echo "go已安装喵~"
#设置go mod下载使用阿里云加速代理
go env -w GO111MODULE=on
go env -w GOPROXY=https://mirrors.aliyun.com/goproxy,direct

while [ ! -d "one-api" ]
do
        if [ ! -d "one-api" ]; then
                echo "one-api不存在，正在通过git下载喵..."
                git clone https://mirror.ghproxy.com/https://github.com/songquanpeng/one-api.git
        	if [ ! -d "one-api" ]; then
                echo -e "(*꒦ິ⌓꒦ີ)\n\033[0;33m hoping：因网络波动one-api下载失败了喵~\n\033[0m"
		sleep 2
        	continue
                else
                echo "one-api文件下载成功喵~"
                fi
        fi
done
while [ ! -f "one-api/start.sh" ] 
do
        if [ ! -f "one-api/start.sh" ]; then
                echo "one-api启动文件不存在，正在通过git下载喵..."
                cd one-api
    		curl -O https://mirror.ghproxy.com/https://raw.githubusercontent.com/YunZLu/termux_using_openai/main/CN/start.sh
	        if [ ! -f "start.sh" ]; then
		echo -e "(*꒦ິ⌓꒦ີ)\n\033[0;33m hoping：因网络波动one-api启动文件下载失败了喵~\n\033[0m"
  		sleep 2
		continue
		else
	        echo "one-api启动文件下载成功喵~"
		cd 
		fi
        fi
done

while [ ! -f "only_oneapi_sac.sh" ]
do
        if [ ! -f "only_oneapi_sac.sh" ]; then
                echo "one-api启动界面不存在，正在通过git下载喵..."
    		curl -O https://mirror.ghproxy.com/https://raw.githubusercontent.com/YunZLu/termux_using_openai/main/CN/only_oneapi_sac.sh
	        if [ ! -f "only_oneapi_sac.sh" ]; then
		echo -e "(*꒦ິ⌓꒦ີ)\n\033[0;33m hoping：因网络波动one-api启动界面下载失败了喵~\n\033[0m"
 		sleep 2
		continue
		else
	        echo "one-api启动界面下载成功喵~"
		fi
        fi
done

echo "bash only_oneapi_sac.sh" >>.bashrc
source .bashrc

exit

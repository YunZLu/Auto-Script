#!/bin/bash
#主菜单
echo -e "                                              
\033[0;32m喵喵一键脚本(one-api CN版)\033[0m
\033[0;32m作者：瑾年\033[0m
\033[0;32m来自：头脑风暴搞起来\033[0m
"

echo -e "\033[0;33m喵喵正在帮你检查系统环境中，请稍等一下喵~\n\033[0m"

# 安装git
while ! command -v git &> /dev/null
do
    if ! command -v git &> /dev/null; then
    echo -e "\033[0;31m检测到你未安装git喵~\n\033[0m"
    echo -e "\033[0;33m正在为你下载git，请稍等一下喵~\n\033[0m"
    DEBIAN_FRONTEND=noninteractive pkg install git -y
        if ! command -v git &> /dev/null; then
        echo -e "\033[0;31mgit下载失败了，正在重试中，请稍等一下喵喵~\n\033[0m"
	sleep 2
        continue
        fi
    fi
done
echo -e "\n\033[0;32mgit已安装喵~\n\033[0m"

# 安装nodejs
while ! command -v node &> /dev/null
do
    if ! command -v node &> /dev/null; then
    echo -e "\033[0;31m检测到你未安装nodejs喵~\n\033[0m"
    echo -e "\033[0;33m正在为你下载nodejs，请稍等一下喵~\n\033[0m"
    DEBIAN_FRONTEND=noninteractive pkg install nodejs-lts -y
        if ! command -v node &> /dev/null; then
        echo -e "\033[0;31mnodejs下载失败了，正在重试中，请稍等一下喵~\n\033[0m"
	sleep 2
        continue
        fi
    fi
done
echo -e "\n\033[0;32mnodejs已安装喵~\n\033[0m"
#设置npm国内源
npm config set registry https://registry.npmmirror.com

#安装go
while ! command -v go &> /dev/null
do
    if ! command -v go &> /dev/null; then
    echo -e "\033[0;31m检测到你未安装go喵~\n\033[0m"
    echo -e "\033[0;33m正在为你下载go，请稍等一下喵~\n\033[0m"
    DEBIAN_FRONTEND=noninteractive pkg install golang -y
        if ! command -v go &> /dev/null; then
        echo -e "\033[0;31mgo下载失败了，正在重试中，请稍等一下喵~\n\033[0m"
	sleep 2
        continue
        fi
    fi
done
echo -e "\n\033[0;32mgo已安装喵~\033[0m\n"
#设置go mod下载使用阿里云加速代理
go env -w GO111MODULE=on
go env -w GOPROXY=https://mirrors.aliyun.com/goproxy,direct

while [ ! -d "one-api" ]
do
        if [ ! -d "one-api" ]; then
                echo -e "\033[0;33mone-api不存在，正在通过git下载，请稍等一下喵...\n\033[0m"
                git clone https://mirror.ghproxy.com/https://github.com/songquanpeng/one-api.git
        	if [ ! -d "one-api" ]; then
                echo -e "\033[0;31mone-ai下载失败了，正在重试中，请稍等一下喵~\n\033[0m"
		sleep 2
        	continue
                else
                echo -e "\n\033[0;32mone-api文件下载成功喵~\n\033[0m"
                fi
        fi
done

while [ ! -f "one-api/start.sh" ] 
do
        if [ ! -f "one-api/start.sh" ]; then
                echo -e "\033[0;33mone-api启动文件不存在，正在通过git下载，请稍等一下喵...\n\033[0m"
                cd one-api
    		curl -O -L https://mirror.ghproxy.com/https://raw.githubusercontent.com/YunZLu/termux_using_openai/main/CN/start.sh
	        if [ ! -f "start.sh" ]; then
		echo -e "\033[0;31mone-api启动文件下载失败了，正在重试中，请稍等一下喵~\n\033[0m"
  		sleep 2
		continue
		else
	        echo -e "\n\033[0;32mone-api启动文件下载成功喵~\n\033[0m"
		cd 
		fi
        fi
done

while [ ! -f "only_oneapi_sac.sh" ]
do
        if [ ! -f "only_oneapi_sac.sh" ]; then
                echo -e "\033[0;33mone-api启动界面不存在，正在通过git下载，请稍等一下喵...\n\033[0m"
    		curl -O -L https://mirror.ghproxy.com/https://raw.githubusercontent.com/YunZLu/termux_using_openai/main/CN/only_oneapi_sac.sh
	        if [ ! -f "only_oneapi_sac.sh" ]; then
		echo -e "\033[0;31mone-api启动界面下载失败了，正在重试中，请稍等一下喵~\n\033[0m"
 		sleep 2
		continue
		else
	        echo -e "\n\033[0;32mone-api启动界面下载成功喵~\033[0m"
		fi
        fi
done

echo "bash only_oneapi_sac.sh" >>.bashrc
source .bashrc

exit

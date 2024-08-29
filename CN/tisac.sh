#!/bin/bash

echo -e "                                             
\033[0;32m喵喵一键安卓脚本(one-api CN版)\033[0m
\033[0;32m原作者: hoping喵，坏水秋\033[0m
\033[0;32m来自: Claude2.1先行破限组\033[0m
\033[0;32m群号: 704819371 / 910524479 / 304690608\033[0m
\033[0;32m类脑Discord: https://discord.gg/HWNkueX34q\033[0m

\033[0;33m修改人：瑾年\033[0m
"

current=/data/data/com.termux/files/usr/var/lib/proot-distro/installed-rootfs/ubuntu

echo -e "\033[0;33m喵喵正在帮你检查系统环境中，请稍等一下喵~\n\033[0m"

# 安装proot-distro
while ! command -v proot-distro &> /dev/null
do
    if ! command -v proot-distro &> /dev/null; then
    echo -e "\033[0;31m检测到你未安装proot-distro喵~\n\033[0m"
    echo -e "\033[0;33m正在为你下载proot-distro，请稍等一下喵~\n\033[0m"
    DEBIAN_FRONTEND=noninteractive pkg install proot-distro -y
        if ! command -v proot-distro &> /dev/null; then
        echo -e "\033[0;31mproot-distro下载失败了，正在重试中，请稍等一下喵~\n\033[0m"
        sleep 2
        continue
        fi
    fi
done
echo -e "\033[0;32mproot-distro已安装喵~\n\033[0m"

# 加速Ubuntu下载地址
sed -i 's/https:\/\/github.com/https:\/\/mirror.ghproxy.com\/github.com/g' /data/data/com.termux/files/usr/etc/proot-distro/ubuntu.sh

# 创建并安装Ubuntu
while [ ! -d "$current" ]
do
   echo -e "\033[0;31m检测到你未安装Ubuntu喵~\n\033[0m"
   echo -e "\033[0;33m正在为你下载Ubuntu，请稍等一下喵~\n\033[0m"
   DEBIAN_FRONTEND=noninteractive proot-distro install ubuntu
   
    # Check Ubuntu installed successfully
     if [ ! -d "$current" ]; then
       echo -e "\033[0;31mUbuntu安装失败了，正在重试，请稍等一下喵~\n\033[0m"
       sleep 2
       continue
     else
        echo -e "\033[0;32mUbuntu成功安装到Termux喵~\033[0m\n"
     fi
 
done

# 安装git
while ! command -v git &> /dev/null
do
    if ! command -v git &> /dev/null; then
    echo -e "\033[0;31m检测到你未安装git喵~\n\033[0m"
    echo -e "\033[0;33m正在为你下载git，请稍等一下喵~\n\033[0m"
    DEBIAN_FRONTEND=noninteractive pkg install git -y
        if ! command -v git &> /dev/null; then
        echo -e "\033[0;31mgit下载失败了，正在重试中，请稍等一下喵~\n\033[0m"
	sleep 2
        continue
        fi
    fi
done
echo -e "\033[0;32mgit已安装喵~\033[0m\n"

# 安装nodejs
cd $current/root
while [ ! -d node-v20.17.0-linux-arm64 ]
do
    if [ ! -d node-v20.17.0-linux-arm64 ]; then
    echo -e "\033[0;31m检测到你未安装nodejs喵~\n\033[0m"
    echo -e "\033[0;33m正在为你下载nodejs，请稍等一下喵~\n\033[0m"
    curl -O https://cdn.npmmirror.com/binaries/node/v20.17.0/node-v20.17.0-linux-arm64.tar.xz
    tar xf node-v20.17.0-linux-arm64.tar.xz
    echo "export PATH=\$PATH:/root/node-v20.17.0-linux-arm64/bin" >>$current/etc/profile
        if [ ! ! -d node-v20.17.0-linux-arm64 ]; then
        echo -e "\033[0;31mnodejs下载失败了，正在重试中，请稍等一下喵~\n\033[0m"
	sleep 2
        continue
        fi
    fi
done
echo -e "\033[0;32mnodejs已安装喵~\033[0m\n"
cd /data/data/com.termux/files/home/

#安装go
while ! command -v go &> /dev/null
do
    if ! command -v go &> /dev/null; then
    echo -e "\033[0;31m检测到你未安装go喵~\033[0m\n"
    echo -e "\033[0;33m正在为你下载go，请稍等一下喵~\033[0m\n"
    DEBIAN_FRONTEND=noninteractive pkg install golang -y
        if ! command -v go &> /dev/null; then
        echo -e "\033[0;31mgo下载失败了，正在重试中，请稍等一下喵~\033[0m\n"
	sleep 2
        continue
        fi
    fi
done
echo -e "\033[0;32mgo已安装喵~\033[0m\n"
#设置go mod下载使用阿里云加速代理
go env -w GO111MODULE=on
go env -w GOPROXY=https://mirrors.aliyun.com/goproxy,direct

cd $current/root

#下载启动文件和更新文件
while [ ! -f "$current/root/sac.sh" ]
do
        if [ ! -f "$current/root/sac.sh" ]; then
                echo -e "\033[0;33m启动文件不存在，正在通过git下载，请稍等一下喵...\033[0m\n"
    		curl -O https://mirror.ghproxy.com/https://raw.githubusercontent.com/YunZLu/termux_using_openai/main/CN/sac.sh
	        if [ ! -f "$current/root/sac.sh" ]; then
		echo -e "\033[0;31m启动文件下载失败了，正在重试中，请稍等一下喵~\n\033[0m"
 		sleep 2
		continue
		else
	        echo -e "\033[0;32m启动文件下载成功喵~\n\033[0m"
		fi
        fi
done

while [ ! -f "$current/root/update_CN.sh" ]
do
        if [ ! -f "$current/root/update_CN.sh" ]; then
                echo -e "\033[0;33m更新文件不存在，正在通过git下载，请稍等一下喵...\033[0m\n"
    		curl -O https://mirror.ghproxy.com/https://raw.githubusercontent.com/YunZLu/termux_using_openai/main/CN/update_CN.sh
	        if [ ! -f "$current/root/update_CN.sh" ]; then
		echo -e "\033[0;31m更新下载失败了，正在重试中，请稍等一下喵~\033[0m\n"
 		sleep 2
		continue
		else
	        echo -e "\033[0;32m更新文件下载成功喵~\033[0m\n"
		fi
        fi
done

ln -s /data/data/com.termux/files/usr/var/lib/proot-distro/installed-rootfs/ubuntu/root


if [ ! -d "/data/data/com.termux/files/home/one-api/" ]; then
        echo -e "\033[0;32m不需要复制one-api文件，跳过...\n\033[0m"
else
 	cp -r /data/data/com.termux/files/home/one-api/ $current/root/one-api
	echo -e "\033[0;32mone-api文件复制成功\n\033[0m"
fi

echo "bash /root/sac.sh" >>$current/root/.bashrc

echo "proot-distro login ubuntu" >>/data/data/com.termux/files/home/.bashrc

source /data/data/com.termux/files/home/.bashrc

exit

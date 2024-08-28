#!/bin/bash

echo "                                              
喵喵一键安卓脚本(one-api CN版)
原作者: hoping喵，坏水秋
来自: Claude2.1先行破限组
群号: 704819371 / 910524479 / 304690608
类脑Discord: https://discord.gg/HWNkueX34q

修改人：瑾年
"

current=/data/data/com.termux/files/usr/var/lib/proot-distro/installed-rootfs/ubuntu

# 安装proot-distro
while ! command -v proot-distro &> /dev/null
do
    if ! command -v proot-distro &> /dev/null; then
    echo "检测到你未安装proot-distro喵~"
    echo "正在为你下载proot-distro喵~"
    DEBIAN_FRONTEND=noninteractive pkg install proot-distro -y
        if ! command -v proot-distro &> /dev/null; then
        echo "proot-distro下载失败了，正在重试中喵~"
        continue
        else
        echo "proot-distro安装成功喵~"
        fi
    fi
done

# 安装git
while ! command -v git &> /dev/null
do
    if ! command -v git &> /dev/null; then
    echo "检测到你未安装git喵~"
    echo "正在为你下载git喵~"
    DEBIAN_FRONTEND=noninteractive pkg install git -y
        if ! command -v git &> /dev/null; then
        echo "git下载失败了，正在重试中喵~"
        continue
        else
        echo "git安装成功喵~"
        fi
    fi
done

# 加速Ubuntu下载地址
sed -i 's/https:\/\/github.com/https:\/\/mirror.ghproxy.com\/github.com/g' /data/data/com.termux/files/usr/etc/proot-distro/ubuntu.sh

# 创建并安装Ubuntu
while [ ! -d "$current" ]
do
   echo "检测到你未安装Ubuntu喵~"
   echo "正在为你下载Ubuntu喵~"
   DEBIAN_FRONTEND=noninteractive proot-distro install ubuntu
   
    # Check Ubuntu installed successfully
     if [ ! -d "$current" ]; then
       echo "Ubuntu安装失败了，正在重试中~"
       continue
     else
        echo "Ubuntu成功安装到Termux"
     fi
 
done

# 安装nodejs
while ! command -v node &> /dev/null
do
    if ! command -v node &> /dev/null; then
    echo "检测到你未安装nodejs喵~"
    echo "正在为你下载nodejs喵~"
    DEBIAN_FRONTEND=noninteractive pkg install nodejs -y
        if ! command -v node &> /dev/null; then
        echo "nodejs下载失败了，正在重试中喵~"
        continue
        else
        echo "nodejs安装成功喵~"
        #设置npm国内源
        npm config set registry https://registry.npmmirror.com
        fi
    fi
done

while ! command -v go &> /dev/null
do
    if ! command -v go &> /dev/null; then
    echo "检测到你未安装go喵~"
    echo "正在为你下载go喵~"
    DEBIAN_FRONTEND=noninteractive pkg install golang -y
        if ! command -v go &> /dev/null; then
        echo "go下载失败了，正在重试中喵~"
        continue
        else
        echo "go安装成功喵~"
        #设置go mod下载使用阿里云加速代理
        go env -w GO111MODULE=on
        go env -w GOPROXY=https://mirrors.aliyun.com/goproxy,direct
        fi
    fi
done

cd $current/root

#下载启动文件和更新文件
while [ ! -f "$current/root/sac.sh" ] || [ ! -f "$current/root/update.sh" ]
do
    if [ ! -f "$current/root/sac.sh" ]; then
    echo "正在为你下载启动文件喵~"
    curl -O https://raw.githubusercontent.com/YunZLu/termux_using_openai/main/CN/sac.sh
        if [ ! -f "$current/root/sac.sh" ]; then
        echo "启动文件下载失败了，正在重试中~"
        continue
        else
        echo "启动文件下载成功~"
        fi
    fi

    if [ ! -f "$current/root/update.sh" ]; then
    echo "正在为你下载更新文件喵~"
    curl -O https://github.com/YunZLu/termux_using_openai/blob/main/CN/update.sh
        if [ ! -f "$current/root/update.sh" ]; then
        echo "更新文件下载失败了，正在重试中~"
        continue
        else
        echo "更新文件下载成功~"
        fi
    fi
    
done

ln -s /data/data/com.termux/files/usr/var/lib/proot-distro/installed-rootfs/ubuntu/root

echo "bash /root/sac.sh" >>$current/root/.bashrc

echo "proot-distro login ubuntu" >>/data/data/com.termux/files/home/.bashrc

source /data/data/com.termux/files/home/.bashrc

exit

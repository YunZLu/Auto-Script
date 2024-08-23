#!/bin/bash

echo "                                              
喵喵一键安卓脚本
作者: hoping喵，坏水秋，瑾年
来自: Claude2.1先行破限组
群号: 704819371 / 910524479 / 304690608
类脑Discord: https://discord.gg/HWNkueX34q
"

echo -e "\033[0;31m开魔法！开魔法！开魔法！\033[0m\n"

read -p "确保开了魔法后按回车继续"

current=/data/data/com.termux/files/usr/var/lib/proot-distro/installed-rootfs/ubuntu

yes | apt update
yes | apt upgrade

# 安装proot-distro
DEBIAN_FRONTEND=noninteractive pkg install proot-distro -y

# 创建并安装Ubuntu
DEBIAN_FRONTEND=noninteractive proot-distro install ubuntu

# Check Ubuntu installed successfully
 if [ ! -d "$current" ]; then
   echo "Ubuntu安装失败了，请更换魔法或者手动安装Ubuntu喵~"
    exit 1
 fi

    echo "Ubuntu成功安装到Termux"

echo "正在安装pkg软件喵~"

DEBIAN_FRONTEND=noninteractive pkg install git vim curl xz-utils -y

# Check Ubuntu installed successfully
 if [ ! -d "$current" ]; then
   echo "Ubuntu安装失败了，请更换魔法或者手动安装Ubuntu喵~"
    exit 1
 fi

    echo "Ubuntu成功安装到Termux"

if [ -d "SillyTavern" ]; then
  cp -r SillyTavern $current/root/
fi

if [ -d "one-api" ]; then
  cp -r one-api $current/root/
fi

cd $current/root

echo "正在为Ubuntu安装node喵~"
if [ ! -d node-v20.10.0-linux-arm64.tar.xz ]; then
    curl -O https://nodejs.org/dist/v20.10.0/node-v20.10.0-linux-arm64.tar.xz

tar xf node-v20.10.0-linux-arm64.tar.xz

echo "export PATH=\$PATH:/root/node-v20.10.0-linux-arm64/bin" >>$current/etc/profile
fi

if [ ! -d "SillyTavern" ]; then
git clone https://github.com/SillyTavern/SillyTavern
fi

if [ ! -d "one-api" ]; then
git clone https://github.com/songquanpeng/one-api.git
fi

git clone -b test https://github.com/teralomaniac/clewd

echo -e "\033[0;33m本操作仅为破限下载提供方便，所有破限皆为收录，喵喵不具有破限所有权\033[0m"
read -p "回车进行导入喵~"
git clone https://github.com/hopingmiao/promot.git st_promot
if  [ ! -d "st_promot" ]; then
    echo -e "(*꒦ິ⌓꒦ີ)\n\033[0;33m hoping：因网络波动预设文件下载失败了，更换网络后再试喵~\n\033[0m"
else
    cp -r $current/root/st_promot/. $current/root/SillyTavern/public/'OpenAI Settings'/
    echo -e "\033[0;33m破限已成功导入，安装完毕后启动酒馆即可看到喵~\033[0m"
fi

curl -O https://raw.githubusercontent.com/YunZLu/termux_using_openai/main/sac.sh

if [ ! -f "$current/root/sac.sh" ]; then
   echo "启动文件下载失败了，换个魔法或者手动下载试试吧"
   exit
fi

ln -s /data/data/com.termux/files/usr/var/lib/proot-distro/installed-rootfs/ubuntu/root

echo "bash /root/sac.sh" >>$current/root/.bashrc

echo "proot-distro login ubuntu" >>/data/data/com.termux/files/home/.bashrc

source /data/data/com.termux/files/home/.bashrc

exit

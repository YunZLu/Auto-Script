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
        echo -e "\n\033[0;31mproot-distro下载失败了，正在重试中，请稍等一下喵~\n\033[0m"
        sleep 2
        continue
        fi
    fi
done
echo -e "\n\033[0;32mproot-distro已安装喵~\n\033[0m"

# 加速Ubuntu下载地址
sed -i 's/https:\/\/github.com/https:\/\/mirror.ghproxy.com\/github.com/g' /data/data/com.termux/files/usr/etc/proot-distro/ubuntu.sh

# 创建并安装Ubuntu
while [ ! -d "$current/etc" ]
do
   echo -e "\033[0;31m检测到你未安装Ubuntu喵~\n\033[0m"
   echo -e "\033[0;33m正在为你下载Ubuntu，请稍等一下喵~\n\033[0m"
   DEBIAN_FRONTEND=noninteractive proot-distro install ubuntu
   
    # Check Ubuntu installed successfully
     if [ ! -d "$current/etc" ]; then
       echo -e "\n\033[0;31mUbuntu安装失败了，正在重试，请稍等一下喵~\n\033[0m"
       sleep 2
       continue
     else
        echo -e "\033[0;32mUbuntu成功安装到Termux喵~\033[0m\n"
     fi
done

echo -e "\033[0;32mubuntu已安装喵~\n\033[0m"

cd $current/root

#下载启动文件和更新文件
while [ ! -f "$current/root/sac.sh" ]
do
        if [ ! -f "$current/root/sac.sh" ]; then
                echo -e "\033[0;33m启动文件不存在，正在下载，请稍等一下喵...\033[0m\n"
    		curl -O https://mirror.ghproxy.com/https://raw.githubusercontent.com/YunZLu/termux_using_openai/main/QC_CN/sac.sh
	        if [ ! -f "$current/root/sac.sh" ]; then
		echo -e "\n\033[0;31m启动文件下载失败了，正在重试中，请稍等一下喵~\n\033[0m"
 		sleep 2
		continue
		else
	        echo -e "\n\033[0;32m启动文件下载成功喵~\n\033[0m"
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

#!/bin/bash

cd /root
source /data/data/com.termux/files/usr/var/lib/proot-distro/installed-rootfs/ubuntu/etc/profile

#添加termux上的Ubuntu/root软链接
if [ ! -d "/data/data/com.termux/files/home/root" ]; then
    ln -s /data/data/com.termux/files/usr/var/lib/proot-distro/installed-rootfs/ubuntu/root /data/data/com.termux/files/home
fi

echo -e "\n\033[0;32mroot软链接已添加，可直接在mt管理器打开root文件夹修改文件喵~\033[0m\n"

#echo -e "\033[0;33m喵喵正在获取版本信息中，请稍等一下喵~\n\033[0m"
#latest_version=$(curl -s https://mirror.ghproxy.com/https://raw.githubusercontent.com/hopingmiao/termux_using_Claue/main/VERSION)
#clewd_latestversion=$(curl -s https://mirror.ghproxy.com/https://raw.githubusercontent.com/teralomaniac/clewd/test/package.json | grep '"version"' | awk -F '"' '{print $4}')
#clewd_subversion=$(curl -s https://mirror.ghproxy.com/https://raw.githubusercontent.com/teralomaniac/clewd/test/lib/clewd-utils.js | grep "Main = 'clewd修改版 v'" | awk -F'[()]' '{print $3}')
#clewd_latest="$clewd_latestversion($clewd_subversion)"
#st_latest=$(curl -s https://mirror.ghproxy.com/https://raw.githubusercontent.com/SillyTavern/SillyTavern/release/package.json | grep '"version"' | awk -F '"' '{print $4}')
#saclinkemoji=$(curl -s https://mirror.ghproxy.com/https://raw.githubusercontent.com/hopingmiao/termux_using_Claue/main/secret_saclink | awk -F '|' '{print $3 }')
# hopingmiao=hotmiao

# ANSI Colors
RED='\033[0;31m'
GREEN='\033[0;32m'
NC='\033[0m' # No Color

echo -e "\033[0;33m喵喵正在帮你检查系统环境中，请稍等一下喵~\033[0m\n"


#检查相应软件安装情况
while ! command -v git &> /dev/null || ! command -v node &> /dev/null || ! command -v go &> /dev/null || ! command -v python3 &> /dev/null || ! command -v pip &> /dev/null || ! command -v sudo &> /dev/null
do
echo -e "\033[0;33m喵喵检查到你的系统有软件未安装，正在帮你安装喵~\033[0m\n"
    #设置apt国内源
    if ! command -v lsb_release &> /dev/null; then
    echo -e "\033[0;33m喵喵正在帮你更新软件包中，请稍等一下喵~\033[0m\n"
    yes | apt update
    echo -e "\n\033[0;31m检测到你未安装lsb-release喵~\033[0m\n"
    echo -e "\033[0;33m正在为你下载lsb-release，请稍等一下喵~\033[0m\n"
    DEBIAN_FRONTEND=noninteractive apt-get install lsb-release -y
        if ! command -v lsb_release &> /dev/null; then
        echo -e "\n\033[0;31mlsb-release下载失败了，正在重试中，请稍等一下喵~\033[0m\n"
	      sleep 2
	      continue
	      else
        echo -e "\n\033[0;32mlsb-release安装成功喵~\033[0m\n"
        echo -e "\033[0;33m喵喵正在帮你选择国内代理中，请稍等一下喵~\033[0m\n"
        bash <(curl -sSL https://linuxmirrors.cn/main.sh) << eof
        6
eof
        yes | apt update
        yes | apt upgrade
        echo -e "\n\033[0;32m已更换国内代理，并成功升级软件包喵~\033[0m\n"
        fi
    fi
    
    #安装git
    if ! command -v git &> /dev/null; then
    echo -e "\033[0;31m检测到你未安装git喵~\033[0m\n"
    echo -e "\033[0;33m正在为你下载git，请稍等一下喵~\033[0m\n"
    DEBIAN_FRONTEND=noninteractive apt-get install git -y
        if ! command -v git &> /dev/null; then
        echo -e "\n\033[0;31mgit下载失败了，正在重试中，请稍等一下喵~\033[0m\n"
	sleep 2
        continue
	else
        echo -e "\n\033[0;32mgit安装成功喵~\033[0m\n"
        fi
    fi

    #安装node
    if ! command -v node &> /dev/null; then
    echo -e "\033[0;31m检测到你未安装nodejs喵~\n\033[0m"
    echo -e "\033[0;33m正在为你下载nodejs，请稍等一下喵~\n\033[0m"
    curl -O -L https://cdn.npmmirror.com/binaries/node/v20.10.0/node-v20.10.0-linux-arm64.tar.xz
    tar xf node-v20.10.0-linux-arm64.tar.xz
    echo "export PATH=\$PATH:/root/node-v20.10.0-linux-arm64/bin" >> /data/data/com.termux/files/usr/var/lib/proot-distro/installed-rootfs/ubuntu/etc/profile
    source /data/data/com.termux/files/usr/var/lib/proot-distro/installed-rootfs/ubuntu/etc/profile
    echo "source /etc/profile" >>/data/data/com.termux/files/usr/var/lib/proot-distro/installed-rootfs/ubuntu/root/.bashrc
        if ! command -v node &> /dev/null; then
        echo -e "\033[0;31mnodejs下载失败了，正在重试中，请稍等一下喵~\n\033[0m"
	sleep 2
        continue
	else
 	rm -rf node-v20.10.0-linux-arm64.tar.xz
  	#设置npm国内源
	npm config set registry https://registry.npmmirror.com
        echo -e "\n\033[0;32mnode安装成功喵~\n\033[0m"
        fi
    fi

    #安装go
    if ! command -v go &> /dev/null; then
    echo -e "\033[0;31m检测到你未安装go喵~\033[0m\n"
    echo -e "\033[0;33m正在为你下载go，请稍等一下喵~\033[0m\n"
    DEBIAN_FRONTEND=noninteractive apt-get install golang -y
        if ! command -v go &> /dev/null; then
        echo -e "\n\033[0;31mgo下载失败了，正在重试中，请稍等一下喵~\033[0m\n"
		sleep 2
        continue
		else
        echo -e "\n\033[0;32mgo安装成功喵~\033[0m\n"
	#重装ca-certificates解决go mod X509问题
 	echo -e "\033[0;33m正在重装ca-certificates，请稍等一下喵~\033[0m\n"
        apt-get install --reinstall ca-certificates -y
        yes | apt-get update
 	echo -e "\n\033[0;32mca-certificates重装成功喵~\033[0m\n"
        fi
    fi

    #安装python3，并设置时区
    if ! command -v python3 &> /dev/null; then
    echo -e "\033[0;31m检测到你未安装python3喵~\033[0m\n"
    echo -e "\033[0;33m正在为你下载python3，请稍等一下喵~\033[0m\n"
    apt install python3 <<eof
y
5


69
eof
        if ! command -v python3 &> /dev/null; then
        echo -e "\n\033[0;31mpython3下载失败了，正在重试中，请稍等一下喵~\033[0m\n"
	sleep 2
        continue
	else
        echo -e "\n\033[0;32mpython3安装成功喵~\033[0m\n"
        fi
    fi

    #安装python3-pip
    if ! command -v pip &> /dev/null; then
    echo -e "\033[0;31m检测到你未安装python3-pip喵~\033[0m\n"
    echo -e "\033[0;33m正在为你下载python3-pip，请稍等一下喵~\033[0m\n"
    DEBIAN_FRONTEND=noninteractive apt install python3-pip -y
        if ! command -v pip &> /dev/null; then
        echo -e "\n\033[0;31mpython3-pip下载失败了，正在重试中，请稍等一下喵~\033[0m\n"
	sleep 2
        continue
	else
        echo -e "\n\033[0;32mpython3-pip安装成功喵~\033[0m\n"
        fi
    fi

    #安装python3-venv
    DEBIAN_FRONTEND=noninteractive apt install python3-venv -y


    #安装sudo
    if ! command -v sudo &> /dev/null; then
    echo -e "\n\033[0;31m检测到你未安装sudo喵~\033[0m\n"
    echo -e "\033[0;33m正在为你下载sudo，请稍等一下喵~\033[0m\n"
    DEBIAN_FRONTEND=noninteractive apt install sudo -y
        if ! command -v sudo &> /dev/null; then
        echo -e "\n\033[0;31msudo下载失败了，正在重试中，请稍等一下喵~\033[0m\n"
	sleep 2
        continue
	else
        echo -e "\n\033[0;32msudo安装成功喵~\033[0m\n"
        fi
    fi

    #安装libasound2
    DEBIAN_FRONTEND=noninteractive apt install libasound2t64 -y
    echo -e "\n\033[0;32mlibasound2t64安装成功喵~\033[0m\n"
done

echo -e "\033[0;32mgit已安装喵~\033[0m\n"

echo -e "\033[0;32mnode已安装喵~\033[0m\n"

#设置go mod下载使用阿里云加速代理
go env -w GO111MODULE=on
go env -w GOPROXY=https://mirrors.aliyun.com/goproxy,direct
echo -e "\033[0;32mgo已安装喵~\033[0m\n"

echo -e "\033[0;32mpython已安装喵~\033[0m\n"

while [ ! -d "/root/clewd" ] || [ ! -f "/root/clewd/config.js" ] || [ ! -d "/root/SillyTavern" ] || [ ! -f "/root/SillyTavern/start.sh" ] || [ ! -d "/root/one-api" ] || [ ! -f "/root/one-api/start.sh" ] || [ ! -d "/opt/QQ/resources/app/app_launcher/napcat" ] || [ ! -d "/root/QChatGPT" ] || [ ! -f "/root/MM_Audio/main.py" ] || [ ! -f "/root/MM_Audio/config/default.json" ]
do

    if [ ! -d "/opt/QQ/resources/app/app_launcher/napcat" ]; then
                echo -e "\033[0;33mnapcat不存在，正在下载，请稍等一下喵...\033[0m\n"
                curl -o napcat.sh https://nclatest.znin.net/NapNeko/NapCat-Installer/main/script/install.sh && sudo bash napcat.sh <<eof
n
eof
        	if [ ! -d "/opt/QQ/resources/app/app_launcher/napcat" ]; then
                echo -e "\n\033[0;31mnapcat下载失败了，正在重试中，请稍等一下喵~\033[0m\n"
		cd /root
		sleep 2
        	continue
                else
                echo -e "\n\033[0;32mnapcat文件下载成功喵~\033[0m\n"
		cd /root
		rm -rf napcat.sh
                fi
        fi

    if [ ! -d "/root/QChatGPT" ]; then
                echo -e "\033[0;33mQChatGPT不存在，正在下载，请稍等一下喵...\033[0m\n"
                git clone https://mirror.ghproxy.com/https://github.com/RockChinQ/QChatGPT
        	if [ ! -d "/root/QChatGPT" ]; then
                echo -e "\n\033[0;31mQChatGPT下载失败了，正在重试中，请稍等一下喵~\033[0m\n"
		sleep 2
 		cd /root
        	continue
                else
                echo -e "\n\033[0;32mQChatGPT文件下载成功喵~\033[0m\n"
		cd /root/QChatGPT/
                echo -e "\033[0;33m正在创建python3虚拟环境喵~\033[0m\n"
		python3 -m venv .
		cd bin
		source activate
		cd /root/QChatGPT/
                echo -e "\033[0;33m正在安装依赖喵~\033[0m\n"
		#设置pip国内源
		pip config set global.index-url https://pypi.tuna.tsinghua.edu.cn/simple
		pip install -r requirements.txt
		echo -e "\n\033[0;32m依赖安装完毕喵~\033[0m"
		python3 main.py
  		deactivate
    		cd /root
      		#修改QQ连接方式
      		jq '."platform-adapters"[2].enable=true' /root/QChatGPT/data/config/platform.json > tmp.json && mv tmp.json /root/QChatGPT/data/config/platform.json
		#添加minimax模型元数据
  		echo "{}" >> /root/QChatGPT/data/metadata/llm-models.json
		jq '. += {"list":
  		[{"model_name": "claude-3-5-sonnet-20240620","name": "OneAPI/claude-3-5-sonnet-20240620"},
    	{"name":"abab5.5-chat","requester":"openai-chat-completions","token_mgr": "openai","tool_call_supported": false,"vision_supported": false},
  		{"name":"abab5.5s-chat","requester":"openai-chat-completions","token_mgr": "openai","tool_call_supported": false,"vision_supported": false},
  		{"name":"abab6-chat","requester":"openai-chat-completions","token_mgr": "openai","tool_call_supported": false,"vision_supported": false},
  		{"name":"abab6.5s-chat","requester":"openai-chat-completions","token_mgr": "openai","tool_call_supported": false,"vision_supported": false},
  		{"name":"abab6.5t.-chat","requester":"openai-chat-completions","token_mgr": "openai","tool_call_supported": false,"vision_supported": false}]
    		} ' /root/QChatGPT/data/metadata/llm-models.json > temp.json && mv temp.json /root/QChatGPT/data/metadata/llm-models.json
                fi
        fi
        
        if [ ! -d "/root/one-api" ]; then
                echo -e "\n\033[0;33mone-api不存在，正在通过git下载，请稍等一下喵...\033[0m\n"
                git clone https://mirror.ghproxy.com/https://github.com/songquanpeng/one-api.git
        	if [ ! -d "/root/one-api" ]; then
                echo -e "\n\033[0;31mone-api下载失败了，正在重试中，请稍等一下喵~\033[0m\n"
		sleep 2
                cd /root
        	continue
                else
                echo -e "\n\033[0;32mone-api文件下载成功喵~\033[0m\n"
		cd /root
                fi
        fi
        
        if [ ! -f "/root/one-api/start.sh" ]; then
                echo -e "\033[0;33mone-api启动文件不存在，正在通过git下载，请稍等一下喵...\033[0m\n"
                cd /root/one-api
    		curl -O -L https://mirror.ghproxy.com/https://raw.githubusercontent.com/YunZLu/termux_using_openai/main/CN/start.sh
	        if [ ! -f "start.sh" ]; then
		echo -e "\n\033[0;33mone-api启动文件下载失败了，正在重试中，请稍等一下喵~\033[0m\n"
  		cd /root
  		sleep 2
		continue
		else
	        echo -e "\n\033[0;32mone-api启动文件下载成功喵~\033[0m\n"
		cd /root
		fi
        fi

        if [ ! -d "/root/clewd" ]; then
        	echo -e "\033[0;33mclewd不存在，正在通过git下载，请稍等一下喵...\033[0m\n"
        	git clone -b test https://mirror.ghproxy.com/https://github.com/teralomaniac/clewd
         	if  [ ! -d "/root/clewd" ]; then
        	echo -e "\n\033[0;31mclewd下载失败了，正在重试中，请稍等一下喵~\033[0m\n"
	 	sleep 2
        	continue
         	else
        	echo -e "\n\033[0;32mclewd下载成功喵~\033[0m\n"
        	fi
        fi

        if [ ! -f "/root/clewd/config.js" ]; then
        echo -e "\033[0;33mclewd未部署，正在部署中，请稍等一下喵...\033[0m"
        cd clewd
        bash start.sh
        cd /root
                if [ ! -f "/root/clewd/config.js" ]; then
                rm -rf clewd
                echo -e "\n(*꒦ິ⌓꒦ີ)\033[0;33m hoping：clewd未部署成功，已帮您删除clewd了喵~\033[0m\n"
		sleep 2
                continue
                else
                echo -e "\n\033[0;32mclewd部署成功喵~\033[0m\n"
                fi
        fi

        if [ ! -d "/root/SillyTavern" ]; then
        echo -e "\033[0;33mSillyTavern不存在，正在通过git下载，请稍等一下喵...\033[0m\n"
        rm -rf SillyTavern
        git clone https://mirror.ghproxy.com/https://github.com/SillyTavern/SillyTavern -b release
        
                if [ ! -d "/root/SillyTavern" ]; then
                echo -e "\n\033[0;31mSillyTavern下载失败了，正在重试中，请稍等一下喵~\033[0m\n"
		sleep 2
                continue
                else
                echo -e "\n\033[0;32mSillyTavern下载成功喵~\033[0m\n"
                fi
	 	echo -e "\033[0;35m更新酒馆是为了导入破限，也可以选择后面自己更新喵~\033[0m\n"
   		echo -e "\033[0;33m输入 Y 现在更新酒馆，或者按回车键暂时不更新喵~\033[0m"
     		read -s -n 1 choice
   		case "$choice" in
   		y|Y )
	                #直接更新...不然不知道为什么会缺失破限文件...有时间再研究吧...
	                echo -e "\033[0;33m\nSillyTavern更新中，请稍等一下喵...\033[0m"
	                cd /root/SillyTavern
	                #启动酒馆后更新才能导入破限文件，暂时没办法...
	                npm i --no-audit --no-fund --quiet --omit=dev
	                echo -e "\n\033[0;35m当SillyTavern输出绿色网址后，请按Ctrl+C喵！\033[0m\n"
	                echo -e "\033[0;33m紫红色字看明白了后，请按任意键继续喵...\033[0m\n"
		        read -s -n 1
	                echo -e "\033[0;33mSillyTavern启动中，请稍等一下喵...\033[0m"
	                node "server.js" "$@"v
	                cd /root
	                
	                export NODE_ENV=production
	                if [ -d "/root/SillyTavern_old" ]; then                                   
	                NEW_FOLDER_NAME="SillyTavern_$(date +%Y%m%d)"
	                mv SillyTavern_old $NEW_FOLDER_NAME
	                fi
	                echo -e "\033[0;33m正在下载SillyTaver更新文件中，请稍等一下喵...\033[0m"
	                git clone -b staging https://mirror.ghproxy.com/https://github.com/SillyTavern/SillyTavern.git SillyTavern_new
	                if [ ! -d "/root/SillyTavern_new" ]; then
	                rm -rf SillyTavern
	                echo -e "\n\033[0;31mSillyTavern更新文件下载失败了，正在重试中，请稍等一下喵~\033[0m\n"
			sleep 2
	                continue
	                elif [ -d "/root/SillyTavern/data/default-user" ]; then
	                cp -r SillyTavern/data/default-user/characters/. SillyTavern_new/public/characters/
	                cp -r SillyTavern/data/default-user/chats/. SillyTavern_new/public/chats/       
	                cp -r SillyTavern/data/default-user/worlds/. SillyTavern_new/public/worlds/
	                cp -r SillyTavern/data/default-user/groups/. SillyTavern_new/public/groups/
	                cp -r SillyTavern/data/default-user/group\ chats/. SillyTavern_new/public/group\ chats/
	                cp -r SillyTavern/data/default-user/OpenAI\ Settings/. SillyTavern_new/public/OpenAI\ Settings/
	                cp -r SillyTavern/data/default-user/User\ Avatars/. SillyTavern_new/public/User\ Avatars/
	                cp -r SillyTavern/data/default-user/backgrounds/. SillyTavern_new/public/backgrounds/
	                cp -r SillyTavern/data/default-user/settings.json SillyTavern_new/public/settings.json
	                mv SillyTavern SillyTavern_old                                  
	                mv SillyTavern_new SillyTavern
	                rm -rf /root/st_promot
	                git clone https://mirror.ghproxy.com/https://github.com/hopingmiao/promot.git /root/st_promot
	                cp -r /root/st_promot/. /root/SillyTavern/public/'OpenAI Settings'/
	                echo -e "\n\033[0;32m酒馆已更新完毕喵~\033[0m\n"
	                else
	                cp -r SillyTavern/public/characters/. SillyTavern_new/public/characters/
	                cp -r SillyTavern/public/chats/. SillyTavern_new/public/chats/       
	                cp -r SillyTavern/public/worlds/. SillyTavern_new/public/worlds/
	                cp -r SillyTavern/public/groups/. SillyTavern_new/public/groups/
	                cp -r SillyTavern/public/group\ chats/. SillyTavern_new/public/group\ chats/
	                cp -r SillyTavern/public/OpenAI\ Settings/. SillyTavern_new/public/OpenAI\ Settings/
	                cp -r SillyTavern/public/User\ Avatars/. SillyTavern_new/public/User\ Avatars/
	                cp -r SillyTavern/public/backgrounds/. SillyTavern_new/public/backgrounds/
	                cp -r SillyTavern/public/settings.json SillyTavern_new/public/settings.json
	                mv SillyTavern SillyTavern_old                                  
	                mv SillyTavern_new SillyTavern
	                rm -rf /root/st_promot
	                git clone https://mirror.ghproxy.com/https://github.com/hopingmiao/promot.git /root/st_promot
	                cp -r /root/st_promot/. /root/SillyTavern/public/'OpenAI Settings'/
	                echo -e "\n\033[0;32m酒馆已更新完毕喵~\033[0m\n"
	                fi;;
	    	* )
        		echo -e "\033[0;32m你选择了不更新酒馆喵~\033[0m\n"
        		continue;;
   		esac
        fi

        if [ ! -f "/root/MM_Audio/main.py" ]; then
                echo -e "\n\033[0;33mMM_Audio不存在，正在通过git下载，请稍等一下喵...\033[0m\n"
		mkdir -m 777 /root/MM_Audio
                cd /root/MM_Audio
                curl -O -L https://mirror.ghproxy.com/https://raw.githubusercontent.com/YunZLu/termux_using_openai/refs/heads/main/QC_CN/MM_Audio/main.py
        	if [ ! -f "/root/MM_Audio/main.py" ]; then
                echo -e "\n\033[0;31MM_Audio下载失败了，正在重试中，请稍等一下喵~\033[0m\n"
		cd /root
		sleep 2
        	continue
                else
                echo -e "\n\033[0;32mMM_Audio文件下载成功喵~\033[0m\n"
                echo -e "\033[0;33m正在创建python3虚拟环境喵~\033[0m\n"
		python3 -m venv .
		cd bin
		source activate
		cd ..
                echo -e "\033[0;33m正在安装依赖喵~\033[0m\n"
		pip install aiohttp
		echo -e "\n\033[0;32m依赖安装完毕喵~\033[0m"
  		deactivate
		cd /root
                fi
        fi

         if [ ! -f "/root/MM_Audio/config/default.json" ]; then
                echo -e "\n\033[0;33mMM_Audio配置文件不存在，正在通过git下载，请稍等一下喵...\033[0m\n"
		mkdir -m 777 /root/MM_Audio/config/
                cd /root/MM_Audio/config/
                curl -O -L https://mirror.ghproxy.com/https://raw.githubusercontent.com/YunZLu/termux_using_openai/refs/heads/main/QC_CN/MM_Audio/config/default.json
        	if [ ! -f "/root/MM_Audio/config/default.json" ]; then
                echo -e "\n\033[0;31MM_Audio配置文件下载失败了，正在重试中，请稍等一下喵~\033[0m\n"
		cd /root
		sleep 2
        	continue
                else
                echo -e "\n\033[0;32mMM_Audio配置文件文件下载成功喵~\033[0m\n"
		cd /root
                fi
        fi
done

#version="Ver2.9.5"
#clewd_version="$(grep '"version"' "clewd/package.json" | awk -F '"' '{print $4}')($(grep "Main = 'clewd修改版 v'" "clewd/lib/clewd-utils.js" | awk -F'[()]' '{print $3}'))"
#st_version=$(grep '"version"' "SillyTavern/package.json" | awk -F '"' '{print $4}')
#设置clewd 获取等级
#\033[0;33m当前:\033[0m$clewd_version \033[0;33m最新:\033[0m\033[5;36m$clewd_latest\033[0m \033[0;33mconfig.js:\033[5;37m$sactag_value
#设置酒馆 获取等级
#\033[0;33m当前版本:\033[0m$st_version \033[0;33m最新版本:\033[0m\033[5;36m$st_latest\033[0m
function MINIMAX_TTS_Settings {

    echo -e "\033[0;36m请选择选一个执行喵~\033[0m
\033[0;33m--------------------------------------\033[0m
\033[0;34m选项0 设置group_id
\033[0;37m选项1 设置API Key
\033[0;34m选项2 设置模型
\033[0;37m选项3 添加混音
\033[0;34m选项4 删除混音
\033[0;37m选项5 设置语速
\033[0;34m选项6 设置音量
\033[0;37m选项7 设置音调
\033[0;33m--------------------------------------\033[0m"
    read -s -n 1 option
    echo
    case $option in 
        0) 
            # 设置group_id
			cd /root
		    echo -e "\033[0;33m请输入你的group_id喵~\033[0m\n"
       		read -p "group_id：" group_id
       		echo -e "\n\033[0;33m请确认你的group_id喵~（y|N）\033[0m\n"
      		echo -e "\033[0;33mgroup_id："$group_id"\033[0m"
	 		read -s -n 1 chose
       			case $chose in 
	        	    y|Y)
	   				jq --arg gid "$group_id" '.group_id = $gid' /root/MM_Audio/config/default.json > /root/MM_Audio/config/default_tmp.json && mv /root/MM_Audio/config/default_tmp.json /root/MM_Audio/config/default.json       				echo -e "\n\033[0;32mgroup_id设置成功喵~\033[0m\n";;
			    *)
				echo -e "\n\033[0;36m你已取消设置group_id喵~\033[0m\n";;
	  		esac
			;;
        1) 
            # 设置API Key
			cd /root
		    echo -e "\033[0;33m请输入你的API Key喵~\033[0m\n"
       		read -p "API_Key：" API_Key
       		echo -e "\n\033[0;33m请确认你的API_Key喵~（y|N）\033[0m\n"
      		echo -e "\033[0;33mAPI_Key："$API_Key"\033[0m"
	 		read -s -n 1 chose
       			case $chose in 
	        	    y|Y)
	   				jq --arg AK "$API_Key" '.api_key = $AK' /root/MM_Audio/config/default.json > /root/MM_Audio/config/default_tmp.json && mv /root/MM_Audio/config/default_tmp.json /root/MM_Audio/config/default.json       				echo -e "\n\033[0;32mgroup_id设置成功喵~\033[0m\n";;
			    *)
				echo -e "\n\033[0;36m你已取消设置API_Key喵~\033[0m\n";;
	  		esac
			;;
        2) 
            # 设置模型
			cd /root
		    echo -e "\033[0;33m请输入你的语音模型喵~\033[0m\n"
       		read -p "语音模型：" model
       		echo -e "\n\033[0;33m请确认你的语音模型喵~（y|N）\033[0m\n"
      		echo -e "\033[0;33m语音模型："$model"\033[0m"
	 		read -s -n 1 chose
       			case $chose in 
	        	    y|Y)
	   				jq --arg m "$model" '.request_params.model = $m' /root/MM_Audio/config/default.json > /root/MM_Audio/config/default_tmp.json && mv /root/MM_Audio/config/default_tmp.json /root/MM_Audio/config/default.json       				echo -e "\n\033[0;32mgroup_id设置成功喵~\033[0m\n";;
			    *)
				echo -e "\n\033[0;36m你已取消设置模型喵~\033[0m\n";;
	  		esac
			;;
      	3)
	   		# 添加混音
			speakList=$(cat /root/MM_Audio/config/default.json|jq '.voice_id' | keys_unsorted | awk -F'"' '{print $2}'| awk 'NF{a++;print "\033[0;33m"a"\033[0m""\033[0;33m.\033[0m","\033[0;33m"$0"\033[0m\n";next}1')
			if [ ! "$speakList" ]; then
		    	echo -e "\033[0;31m你根本没有可添加的混音，你是在玩我喵喵大人喵？\033[0m\n"
		    else
				echo -e "\033[0;36m请选择需要添加的混音喵~\033[0m\n"
				echo -e "$speakList\n"
		    	read -n 3 speakChose
	   			speakChose=$(($speakChose-1))
				speakName=$(jq --arg n ${speakChose} '.voice_id' | keys_unsorted | awk -F'"' '{print $2}'| awk NR==$n /root/MM_Audio/config/default.json)
				if [ "$speakName" ] && [ "$speakName" != null ]; then
				voice_id=$(jq -r --arg key "$speakName" '.voice_id[$key]' /root/MM_Audio/config/default.json)
				echo -e "\n\033[0;33m请输入混音权重喵~\033[0m\n"
				read -p "混音权重（范围[1,100]）：" weight
				echo -e "\n\033[0;33m请确认你的预设信息喵~（y|N）\033[0m\n"
				echo -e "\033[0;33m配音角色："$speakName"\033[0m\n"
				echo -e "\033[0;33m混音权重：$weight\033[0m\n"
				read -s -n 1 chose
					case $chose in 
					y|Y)
						cat /root/MM_Audio/config/default.json | jq --arg voice_id "$voice_id" --argjson weight "$weight" '.request_params.timber_weights += [{"voice_id": $voice_id, "weight": $weight}]' > tmp.json && mv tmp.json /root/MM_Audio/config/default.json
						echo -e "\033[0;32m混音角色：$speakName 添加成功喵~\033[0m\n";;
					*)
					echo -e "\033[0;36m你已取消添加混音角色喵~\033[0m\n";;
			  		esac
	            else
					echo -e "\n\033[0;31m你怎么乱选！不给你删了喵~\033[0m\n"
		 		fi
    		fi
	   		;;
   		4)
	   		# 删除混音
			speakList=$(cat /root/MM_Audio/config/default.json|jq '.request_params.timber_weights[].voice_id'|awk -F'"' '{print $2}'| awk 'NF{a++;print "\033[0;33m"a"\033[0m""\033[0;33m.\033[0m","\033[0;33m"$0"\033[0m\n";next}1')
			if [ ! "$speakList" ]; then
		    	echo -e "\033[0;31m你根本没有语言模型，你是在玩我喵喵大人喵？\033[0m\n"
		    else
				echo -e "\033[0;36m请选择需要删除的混音喵~\033[0m\n"
				echo -e "$speakList\n"
		    	read -n 3 speakChose
	   			speakChose=$(($speakChose-1))
				speakName=$(jq --arg n ${speakChose} '.request_params.timber_weights[$n|tonumber]' /root/MM_Audio/config/default.json)
				if [ "$speakName" ] && [ "$speakName" != null ]; then
	                echo -e "\n\033[0;36m你确定要删除该混音喵？(y|N)\033[0m\n"
					echo -e "\033[0;33m混音\n$speakName\033[0m"
		  			read -s -n 1 chose
					case $chose in 
			        	y|Y)
							jq --arg n ${speakChose} 'del(.request_params.timber_weights[$n|tonumber])' /root/MM_Audio/config/default.json > tmp.json && mv tmp.json /root/MM_Audio/config/default.json
	    					echo -e "\n\033[0;32m混音：\n$speakName\n已被删除喵~\033[0m\n";;
					    *)
							echo -e "\n\033[0;36m你已取消删除混音喵~\033[0m\n";;
			  			esac
	            else
					echo -e "\n\033[0;31m你怎么乱选！不给你删了喵~\033[0m\n"
		 		fi
    		fi
	   		;;
        5) 
            # 设置语速
			cd /root
		    echo -e "\033[0;33m请输入你的语速喵~\033[0m\n"
       		read -p "语速(范围[0.5,2]）：" speed
       		echo -e "\n\033[0;33m请确认你的语速喵~（y|N）\033[0m\n"
      		echo -e "\033[0;33m语速："$speed"\033[0m"
	 		read -s -n 1 chose
       			case $chose in 
	        	    y|Y)
	   				jq --arg s "$speed" '.request_params.speed = $s' /root/MM_Audio/config/default.json > /root/MM_Audio/config/default_tmp.json && mv /root/MM_Audio/config/default_tmp.json /root/MM_Audio/config/default.json       				echo -e "\n\033[0;32mgroup_id设置成功喵~\033[0m\n";;
			    *)
				echo -e "\n\033[0;36m你已取消设置语速喵~\033[0m\n";;
	  		esac
			;;
        6) 
            # 设置音量
			cd /root
		    echo -e "\033[0;33m请输入你的音量喵~\033[0m\n"
       		read -p "音量（范围（0,10]）：" vol
       		echo -e "\n\033[0;33m请确认你的音量喵~（y|N）\033[0m\n"
      		echo -e "\033[0;33m音量："$vol"\033[0m"
	 		read -s -n 1 chose
       			case $chose in 
	        	    y|Y)
	   				jq --arg v "$vol" '.request_params.vol = $v' /root/MM_Audio/config/default.json > /root/MM_Audio/config/default_tmp.json && mv /root/MM_Audio/config/default_tmp.json /root/MM_Audio/config/default.json       				echo -e "\n\033[0;32mgroup_id设置成功喵~\033[0m\n";;
			    *)
				echo -e "\n\033[0;36m你已取消设置音量喵~\033[0m\n";;
	  		esac
			;;
        7) 
            # 设置音调
			cd /root
		    echo -e "\033[0;33m请输入你的音调喵~\033[0m\n"
       		read -p "音调（范围[-12,12]）：" pitch
       		echo -e "\n\033[0;33m请确认你的音调喵~（y|N）\033[0m\n"
      		echo -e "\033[0;33m音调："$pitch"\033[0m"
	 		read -s -n 1 chose
       			case $chose in 
	        	    y|Y)
	   				jq --arg p "$pitch" '.request_params.pitch = $p' /root/MM_Audio/config/default.json > /root/MM_Audio/config/default_tmp.json && mv /root/MM_Audio/config/default_tmp.json /root/MM_Audio/config/default.json       				echo -e "\n\033[0;32mgroup_id设置成功喵~\033[0m\n";;
			    *)
				echo -e "\n\033[0;36m你已取消设置音调喵~\033[0m\n";;
	  		esac
			;;
   	   	*)
			echo -e "\033[0;31m你怎么乱选！不跟你玩了喵~\033[0m\n";;
	  esac
	  echo -e "\033[0;33m3s后返回主菜单喵~\033[0m\n"
   	  sleep 3
      cd /root
}

function QChatGPTSettings {

    echo -e "\033[0;36m请选择选一个执行喵~\033[0m
\033[0;33m--------------------------------------\033[0m
\033[0;34m选项0 设置管理员QQ号
\033[0;37m选项1 设置接口地址
\033[0;34m选项2 添加API Key
\033[0;37m选项3 删除API Key
\033[0;34m选项4 设置预设模式
\033[0;37m选项5 添加预设
\033[0;34m选项6 删除预设
\033[0;37m选项7 添加自定义模型
\033[0;34m选项8 删除自定义模型
\033[0;37m选项9 设置Vioce token
\033[0;33m--------------------------------------\033[0m"
    read -s -n 1 option
    echo
    case $option in 
        0) 
            # 设置QQ管理员
			cd /root
		    echo -e "\033[0;33m请输入你的QQ管理员号码喵~\033[0m\n"
       		read -p "QQ：" QQ_admin
       		echo -e "\n\033[0;33m请确认你的QQ机器人号码喵~（y|N）\033[0m\n"
      		echo -e "\033[0;33mQQ："$QQ_admin"\033[0m"
	 		read -s -n 1 chose
       			case $chose in 
	        	    y|Y)
			  		QQ_admin="person_$QQ_admin"
	   				jq --arg QQ_admin ${QQ_admin} '."admin-sessions"=[$QQ_admin]' /root/QChatGPT/data/config/system.json > temp.json && mv temp.json /root/QChatGPT/data/config/system.json
       				echo -e "\n\033[0;32mQQ管理员设置成功喵~\033[0m\n";;
			    *)
				echo -e "\n\033[0;36m你已取消设置QQ管理员喵~\033[0m\n";;
	  		esac
			;;
        1)
            # 设置接口地址
			cd /root
		    echo -e "\033[0;33m请输入你的接口地址喵~\033[0m\n"
       		read -p "接口地址：" Proxy
       		echo -e "\n\033[0;33m请确认你的接口地址喵~（y|N）\033[0m\n"
      		echo -e "\033[0;33m接口地址："$Proxy"\033[0m"
	 		read -s -n 1 chose
       			case $chose in 
	        	    y|Y)
			  		Proxy="$Proxy"
	   				jq --arg P ${Proxy} '.requester."openai-chat-completions"."base-url"=$P' /root/QChatGPT/data/config/provider.json > temp.json && mv temp.json /root/QChatGPT/data/config/provider.json
       				echo -e "\n\033[0;32m接口地址设置成功喵~\033[0m\n";;
			    *)
				echo -e "\n\033[0;36m你已取消设置接口地址喵~\033[0m\n";;
	  		esac
			;;
           2)
            # 添加APi key
			cd /root
		    echo -e "\033[0;33m请输入你的API key喵~(sk-开头的key)\033[0m\n"
       		read -p "Api key：" Apikey
       		echo -e "\n\033[0;33m请确认你的Api key喵~（y|N）\033[0m\n"
      		echo -e "\033[0;33m接口地址："$Apikey"\033[0m"
	 		read -s -n 1 chose
       			case $chose in 
	        	    y|Y)
			  		Apikey="$Apikey"
	   				len=$(cat /root/QChatGPT/data/config/provider.json | jq '.keys.openai[]' | awk 'END{print NR}')
	   				jq --arg n ${len} --arg e ${Apikey} '.keys.openai[$n|tonumber]=$e' /root/QChatGPT/data/config/provider.json > tmp.json && mv tmp.json /root/QChatGPT/data/config/provider.json
       				echo -e "\n\033[0;32mApi key添加成功喵~\033[0m\n";;
			    *)
				echo -e "\n\033[0;36m你已取消添加Api key喵~\033[0m\n";;
	  		esac
			;;
			3)
	   		# 删除APi key
			keyList=$(cat /root/QChatGPT/data/config/provider.json | jq '.keys.openai[]'|awk -F'"' '{print $2}'| awk 'NF{a++;print "\033[0;33m"a"\033[0m""\033[0;33m.\033[0m","\033[0;33m"$0"\033[0m\n";next}1')
			if [ ! "$keyList" ]; then
		    	echo -e "\n\033[0;31m你根本没有key，你是在玩我喵喵大人喵？\033[0m\n"
		    else
				echo -e "\n\033[0;36m请选择需要删除的Api key喵~\033[0m\n"
				echo "$keyList"
		    	read -s -n 1 keyChose
	   			keyChose=$(($keyChose-1))
				keyNum=$(jq --arg n ${keyChose} '.keys.openai[$n|tonumber]' /root/QChatGPT/data/config/provider.json)
				if [ "$keyNum" ]  && [ "$keyNum" != null ]; then
	                echo -e "\n\033[0;36m你确定要删除该Api key喵？(y|N)\033[0m\n"
					echo -e "\033[0;33mApi key：$keyNum\033[0m"
		  			read -s -n 1 chose
					case $chose in 
			        	y|Y)
							jq --arg n ${keyChose} 'del(.keys.openai[$n|tonumber])' /root/QChatGPT/data/config/provider.json > tmp.json && mv tmp.json /root/QChatGPT/data/config/provider.json
	    					echo -e "\n\033[0;32mApi key：$keyNumr已被删除喵~\033[0m\n";;
					    *)
							echo -e "\n\033[0;36m你已取消删除Api key喵~\033[0m\n";;
			  			esac
	            else
					echo -e "\n\033[0;31m你怎么乱选！不给你删了喵~\033[0m\n"
		 		fi
    		fi
	   		;;
	        4) 
            # 设置预设模式
			cd /root
			echo -e "\033[0;33m请选择预设模式喵~\033[0m\n"
			echo -e "\033[0;33m1.普通预设模式\033[0m\n"
   			echo -e "\033[0;33m2.完整对话预设模式\033[0m"
		    read -s -n 1 chose
			case $chose in 
			    1)
					cat /root/QChatGPT/data/config/provider.json | jq '."prompt-mode"="normal"' > tmp.json && mv tmp.json /root/QChatGPT/data/config/provider.json
	    			echo -e "\n\033[0;32m预设模式已设置为:普通预设模式喵~\033[0m\n";;
				2)
					cat /root/QChatGPT/data/config/provider.json | jq '."prompt-mode"="full-scenario"' > tmp.json && mv tmp.json /root/QChatGPT/data/config/provider.json
					echo -e "\n\033[0;32m预设模式已设置为:完整对话预设模式喵~\033[0m\n";;
	 			*)
	 				echo -e "\n\033[0;31m你怎么乱选！不给你设置了喵~\033[0m\n";;
			  		esac
			;;
        	5) 
            # 添加预设
   			cd /root
			echo -e "\033[0;33m请选择添加相应模式的预设喵~\033[0m\n"
			echo -e "\033[0;33m1.添加普通模式的预设\033[0m\n"
   			echo -e "\033[0;33m2.添加完整对话模式的预设\033[0m"
		    read -s -n 1 chose
			case $chose in 
			    1)
					echo -e "\n\033[0;33m请输入预设名喵~\033[0m\n"
		       		read -p "预设名：" name
				 	echo -e "\n\033[0;33m请输入预设内容喵~\033[0m\n"
		       		read -p "预设内容：" value
		       		echo -e "\n\033[0;33m请确认你的预设信息喵~（y|N）\033[0m\n"
		      		echo -e "\033[0;33m预设名："$name"\033[0m\n"
					echo -e "\033[0;33m预设内容：$value\033[0m\n"
			 		read -s -n 1 chose
		       			case $chose in 
			        	y|Y)
					  		cat /root/QChatGPT/data/config/provider.json | jq --arg n ${name} --arg v "$value" '.prompt.[$n]=$v' > tmp.json && mv tmp.json /root/QChatGPT/data/config/provider.json
						  	echo -e "\033[0;32m预设：$name 添加成功喵~\033[0m\n";;
					    *)
						echo -e "\033[0;36m你已取消设添加预设喵~\033[0m\n";;
			  		esac;;
				2)
					echo -e "\n\033[0;33m请输入预设名喵~\033[0m\n"
		       		read -p "预设名：" name
				 	echo -e "\n\033[0;33m请输入预设内容喵~\033[0m\n"
		       		read -p "预设内容：" value
		   			#验证json格式
					if echo "$value" | jq -e 'if type == "object" or type == "array" then true else false end' >/dev/null 2>&1; then
			       		echo -e "\n\033[0;33m请确认你的预设信息喵~（y|N）\033[0m\n"
			      		echo -e "\033[0;33m预设名："$name"\033[0m\n"
						echo -e "\033[0;33m预设内容：\033[0m\n"
		 				echo "$value" | jq .
				 		read -s -n 1 chose
			       			case $chose in 
				        	y|Y)
								echo '{}' > /root/QChatGPT/data/scenario/"$name".json
						  		cat /root/QChatGPT/data/scenario/"$name".json | jq --argjson v "$value" '.+=$v' > temp.json && mv temp.json /root/QChatGPT/data/scenario/"$name".json
							  	echo -e "\n\033[0;32m预设：$name 添加成功喵~\033[0m\n";;
						    *)
							echo -e "\n\033[0;36m你已取消设添加预设喵~\033[0m\n";;
				  		esac
					else
						echo -e "\n\033[0;31m请检查你输入的预设内容是否为json格式喵！！！\033[0m\n"
					fi
					;;
	 			*)
	 				echo -e "\n\033[0;31m你怎么乱选！不给你添加了喵~\033[0m\n";;
			  		esac
			;;
		    6)
	   		# 删除预设
   			cd /root
			echo -e "\033[0;33m请选择删除相应模式的预设喵~\033[0m\n"
			echo -e "\033[0;33m1.删除普通模式的预设\033[0m\n"
   			echo -e "\033[0;33m2.删除完整对话模式的预设\033[0m"
		    read -s -n 1 chose
			case $chose in 
			    1)
					promptList=$(cat /root/QChatGPT/data/config/provider.json | jq '.prompt'| jq -r 'keys[]' | awk 'NF{a++;print "\033[0;33m"a"\033[0m""\033[0;33m.\033[0m","\033[0;33m"$0"\033[0m\n";next}1')
					if [ ! "$promptList" ]; then
				    	echo -e "\n\033[0;31m你根本没有预设，你是在玩我喵喵大人喵？\033[0m\n"
				    else
						echo -e "\n\033[0;36m请选择需要删除的预设喵~\033[0m\n"
						echo "$promptList"
				    	read -s -n 1 promptChose
						promptName=$(cat /root/QChatGPT/data/config/provider.json | jq '.prompt'| jq -r 'keys[]' | awk NR==$promptChose)
						if [ "$promptName" ]  && [ "$promptName" != null ]; then
			                echo -e "\n\033[0;36m你确定要删除该预设喵？(y|N)\033[0m\n"
							echo -e "\033[0;33m预设名：$promptName\033[0m\n"
			 				promptValue=$(cat /root/QChatGPT/data/config/provider.json | jq -r --arg n ${promptName} '.prompt.[$n]')
							echo -e "\033[0;33m预设内容：$promptValue\033[0m\n"
				  			read -s -n 1 chose
							case $chose in 
					        	y|Y)
									cat /root/QChatGPT/data/config/provider.json | jq --arg n ${promptName} 'del(.prompt.[$n])' > tmp.json && mv tmp.json /root/QChatGPT/data/config/provider.json
			    					echo -e "\033[0;32m预设：$promptName 已被删除喵~\033[0m\n";;
							    *)
									echo -e "\033[0;36m你已取消删除预设喵~\033[0m\n";;
					  			esac
			            else
							echo -e "\n\033[0;31m你怎么乱选！不给你删了喵~\033[0m\n"
				 		fi
		    		fi;;
				2)
      				#获取PMname.json列表
					pList=$(ls -1 /root/QChatGPT/data/scenario/ | awk -F'.' '{print $1}' | awk '!a[$0]++{print}' | awk 'NF{a++;print "\033[0;33m"a"\033[0m""\033[0;33m.\033[0m","\033[0;33m"$0"\033[0m\n";next}1')
					if [ ! "$pList" ]; then
				    	echo -e "\n\033[0;31m你根本没有预设，你是在玩我喵喵大人喵？\033[0m\n"
				    	else
						echo -e "\n\033[0;36m请选择需要删除的预设喵~\033[0m\n"
						echo "$pList"
				    	read -s -n 1 PMchose
						PMname=$(ls -1 /root/QChatGPT/data/scenario/ | awk -F'.' '{print $1}' | awk '!a[$0]++{print}'| awk NF | awk -v PMchose=$PMchose NR==$PMchose)
						if [ "$PMname" ]; then
			                echo -e "\n\033[0;36m你确定要删除该预设喵？(y|N)\033[0m\n"
							echo -e "\033[0;33m预设名："$PMname"\033[0m\n"
	   						echo -e "\033[0;33m预设内容：\033[0m"
		  					cat /root/QChatGPT/data/scenario/$PMname.json | jq .
				  			read -s -n 1 chose
							case $chose in 
					        	y|Y)
						     		rm -rf /root/QChatGPT/data/scenario/$PMname.json
									echo -e "\n\033[0;32m预设：$PMname 已被删除喵~\033[0m\n";;
							    *)
									echo -e "\n\033[0;36m你已取消删除喵~\033[0m\n";;
					  			esac
			             else
							echo -e "\n\033[0;31m你怎么乱选！不给你删了喵~\033[0m\n"
				 		 fi
		    		 fi
			   		;;
	 			*)
	 				echo -e "\n\033[0;31m你怎么乱选！不给你删了喵~\033[0m\n";;
			  		esac
			;;

           7)
            # 添加自定义模型
			cd /root
		    echo -e "\033[0;33m请输入你的模型信息喵~(不输入直接回车则为默认值)\033[0m\n"
	  		echo -e "\033[0;33m请输入模型名称喵~\033[0m"
       		read -p "name(必填项)：" name
			if [ "$name" ]; then
			  	echo -e "\n\033[0;33m请输入请求时使用的模型名称，用于区分使用不同请求器的相同模型，若未设置则使用 name 字段喵~\033[0m"
		       	read -p "model_name(无默认值，未填则不设置)：" model_name
		  		echo -e "\n\033[0;33m请输入请求器名称，指定使用哪个请求器请求该模型的响应喵~\033[0m"
	       		read -p "requester(默认值 openai-chat-completions)：" requester
			 	requester=${requester:-openai-chat-completions}
	 			echo -e "\n\033[0;33m请输入Key 管理器，此模型使用的 key 组喵~\033[0m"
			    read -p "token_mgr(默认值 openai)：" token_mgr
		  		token_mgr=${token_mgr:-openai}
	  			echo -e "\n\033[0;33m请选择是否支持工具调用喵~\033[0m"
				read -p "tool_call_supported(默认值 false)：" tool_call_supported
	   			tool_call_supported=${tool_call_supported:-false}
	   	  		echo -e "\n\033[0;33m请选择是否支持图像输入喵~\033[0m"
				read -p "vision_supported(默认值 false)：" vision_supported
	   			vision_supported=${vision_supported:-false}
	       		echo -e "\n\033[0;33m请确认你的模型信息喵~（y|N）\033[0m\n"
	      		echo -e "\033[0;33mname："$name"\033[0m"
			    if [ "$model_name" ]; then
		        echo -e "\033[0;33mmodel_name："$model_name"\033[0m"
		        fi
			    echo -e "\033[0;33mrequester："$requester"\033[0m"
			    echo -e "\033[0;33mtoken_mgr："$token_mgr"\033[0m"
				echo -e "\033[0;33mtool_call_supported："$tool_call_supported"\033[0m"
			    echo -e "\033[0;33mvision_supported："$vision_supported"\033[0m"
		 		read -s -n 1 chose
	       			case $chose in 
		        	    y|Y)
				  		name="$name"
		   				requester="$requester"
						token_mgr="$token_mgr"
						tool_call_supported="$tool_call_supported"
	 					vision_supported="$vision_supported"
		   				len=$(cat /root/QChatGPT/data/metadata/llm-models.json|jq '.list[].name'|awk -F'"' '{print $2}'| awk 'END{print NR}')
	       				if [ "$model_name" ]; then
		        		jq --arg l ${len} --arg n ${name} --arg mn ${model_name} --arg r ${requester} --arg tm ${token_mgr} --arg tcs ${tool_call_supported} --arg vs ${vision_supported} '.list[$l|tonumber]={"name":$n,"model_name":$mn,"requester":$r,"token_mgr":$tm,"tool_call_supported":$tcs,"vision_supported":$vs}' /root/QChatGPT/data/metadata/llm-models.json > tmp.json && mv tmp.json /root/QChatGPT/data/metadata/llm-models.json
						else
		        		jq --arg l ${len} --arg n ${name} --arg r ${requester} --arg tm ${token_mgr} --arg tcs ${tool_call_supported} --arg vs ${vision_supported} '.list[$l|tonumber]={"name":$n,"requester":$r,"token_mgr":$tm,"tool_call_supported":$tcs,"vision_supported":$vs}' /root/QChatGPT/data/metadata/llm-models.json > tmp.json && mv tmp.json /root/QChatGPT/data/metadata/llm-models.json	 
		        		fi
			   			echo -e "\n\033[0;32m自定义模型添加成功喵~\033[0m\n";;
           				*)
						echo -e "\n\033[0;36m你已取消添加自定义模型喵~\033[0m\n";;
	  				esac
		 	else
			echo -e "\n\033[0;31m模型名称不能为空喵~\033[0m\n"
			fi
			;;
		    8)
	   		# 删除自定义模型
			modeList=$(cat /root/QChatGPT/data/metadata/llm-models.json|jq '.list[].name'|awk -F'"' '{print $2}'| awk 'NF{a++;print "\033[0;33m"a"\033[0m""\033[0;33m.\033[0m","\033[0;33m"$0"\033[0m\n";next}1')
			if [ ! "$modeList" ]; then
		    	echo -e "\033[0;31m你根本没有语言模型，你是在玩我喵喵大人喵？\033[0m\n"
		    else
				echo -e "\033[0;36m请选择需要删除的语言模型喵~\033[0m\n"
				echo -e "$modeList\n"
		    	read -n 3 modeChose
	   			modeChose=$(($modeChose-1))
				modeName=$(jq --arg n ${modeChose} '.list[$n|tonumber]' /root/QChatGPT/data/metadata/llm-models.json)
				if [ "$modeName" ] && [ "$modeName" != null ]; then
	                echo -e "\n\033[0;36m你确定要删除该模型喵？(y|N)\033[0m\n"
					echo -e "\033[0;33m模型：\n$modeName\033[0m"
		  			read -s -n 1 chose
					case $chose in 
			        	y|Y)
							jq --arg n ${modeChose} 'del(.list[$n|tonumber])' /root/QChatGPT/data/metadata/llm-models.json > tmp.json && mv tmp.json /root/QChatGPT/data/metadata/llm-models.json
	    					echo -e "\n\033[0;32m模型：\n$modeName\n已被删除喵~\033[0m\n";;
					    *)
							echo -e "\n\033[0;36m你已取消删除语言模型喵~\033[0m\n";;
			  			esac
	            else
					echo -e "\n\033[0;31m你怎么乱选！不给你删了喵~\033[0m\n"
		 		fi
    		fi
	   		;;
	  		9)
            # 设置TTS-token
			if [ ! -f "/root/QChatGPT/data/plugins/NewChatVoice/config/global_config.json" ]; then
            	echo -e "\033[0;33m你还没有下载插件，请先用QQ管理员复制并发送给QQ机器人以下指令:\033[0m\n"
				echo -e "\033[0;33m!plugin get https://mirror.ghproxy.com/https://github.com/the-lazy-me/NewChatVoice.git\033[0m\n"
   			else
		    	echo -e "\033[0;33m请输入你的海豚TTS token(输入链接即可)喵~\033[0m\n"
       			read -p "Token：" token
       			echo -e "\n\033[0;33m请确认你的海豚TTS token喵~（y|N）\033[0m\n"
      			echo -e "\033[0;33mToken："$token"\033[0m"
	 			read -s -n 1 chose
       			case $chose in 
	        	y|Y)
	   				jq --arg token ${token} '."acgn_ttson".token=$token' /root/QChatGPT/data/plugins/NewChatVoice/config/global_config.json > temp.json && mv temp.json /root/QChatGPT/data/plugins/NewChatVoice/config/global_config.json
       				echo -e "\n\033[0;32m海豚TTS token设置成功喵~\033[0m\n";;
			    *)
					echo -e "\n\033[0;36m你已取消设置海豚TTS token喵~\033[0m\n";;
	  			esac
	 		fi
			;;
	   	    *)
			echo -e "\033[0;31m你怎么乱选！不跟你玩了喵~\033[0m\n";;
	  esac
	  echo -e "\033[0;33m3s后返回主菜单喵~\033[0m\n"
   	  sleep 3
      cd /root
}

function clewdSettings { 
    # 3. Clewd设置
    if grep -q '"sactag"' "clewd/config.js"; then
        sactag_value=$(grep '"sactag"' "clewd/config.js" | sed -E 's/.*"sactag": *"([^"]+)".*/\1/')
    else
        sactag_value="默认"
    fi
    clewd_dir=clewd

    echo -e "\033[0;36mhoping：选一个执行喵~\033[0m
\033[0;33m--------------------------------------\033[0m
\033[0;33m选项1 查看 config.js 配置文件\033[0m
\033[0;37m选项2 使用 Vim 编辑 config.js\033[0m
\033[0;33m选项3 添加 Cookies\033[0m
\033[0;37m选项4 修改 Clewd 密码\033[0m
\033[0;33m选项5 修改 Clewd 端口\033[0m
\033[0;37m选项6 修改 Cookiecounter\033[0m
\033[0;33m选项7 修改 rProxy\033[0m
\033[0;37m选项8 修改 PreventImperson状态\033[0m
\033[0;33m选项9 修改 PassParams状态\033[0m
\033[0;37m选项a 修改 padtxt\033[0m
\033[0;33m选项b 切换 config.js配置\033[0m
\033[0;37m选项c 定义 clewd接入模型\033[0m
\033[0;33m选项d 修改 api_rProxy(第三方接口)\033[0m
\033[0;33m--------------------------------------\033[0m
\033[0;31m选项0 更新 clewd(test分支)\033[0m
\033[0;33m--------------------------------------\033[0m
"
    read -s -n 1 option
    echo
    case $option in 
        1) 
            # 查看 config.js
            cat $clewd_dir/config.js
            ;;
        2)
            # 使用 Vim 编辑 config.js
            vim $clewd_dir/config.js
            ;;
        3) 
            # 添加 Cookies
            echo "hoping：请输入你的cookie文本喵~(回车进行保存，如果全部输入完后按一次ctrl+D即可退出输入):"
            while IFS= read -r line; do
                cookies=$(echo "$line" | grep -E -o '"?sessionKey=[^"]{100,120}AA"?' | tr -d "\"'")
                echo "$cookies"
                if [ -n "$cookies" ]; then
                    echo -e "喵喵猜你的cookies是:\n"
                    echo "$cookies"
                    # Format cookies, one per line with quotes
                    cookies=$(echo "$cookies" | tr ' ' '\n' | sed -e 's/^/"/; s/$/"/g')
                    # Join into array
                    cookie_array=$(echo "$cookies" | tr '\n' ',' | sed 's/,$//')
                    # Update config.js
                    sed -i "/\"CookieArray\"/s/\[/\[$cookie_array\,/" ./$clewd_dir/config.js
                    echo "Cookies成功被添加到config.js文件了喵~"
                else
                    echo "没有找到cookie喵~o(╥﹏╥)o，要不检查一下cookie是不是输错了吧？(如果要退出输入请按Ctrl+D)"
                fi
            done
            echo "cookies成功输入了(*^▽^*)"
            ;;
        4) 
            # 修改 Clewd 密码
            read -p "是否修改密码?(y/n)" choice
            if [ "$choice" == "y" ] || [ "$choice" == "Y" ]; then
                # 读取用户输入的新密码
                read -p "请输入新密码\n（不是你本地部署设密码干哈啊？）:" new_pass

                # 修改密码
                sed -i 's/"ProxyPassword": ".*",/"ProxyPassword": "'$new_pass'",/g' $clewd_dir/config.js

                echo "密码已修改为$new_pass"
            else
                echo "未修改密码"
            fi
            ;; 
        5) 
            # 修改 Clewd 端口
            read -p "是否要修改开放端口?(y/n)" choice
            if [ "$choice" == "y" ] || [ "$choice" == "Y" ]; then
                # 读取用户输入的端口号
                read -p "请输入开放的端口号:" custom_port

                # 更新配置文件的端口号
                sed -i 's/"Port": [0-9]*/"Port": '$custom_port'/g' $clewd_dir/config.js
                echo "端口已修改为$custom_port"
            else
                echo "未修改端口号"
            fi
            ;;
        6)  
            # 修改 Cookiecounter
            echo "切换Cookie的频率, 默认为3(每3次切换), 改为-1进入测试Cookie模式"
            read -p "是否要修改Cookiecounter?(y/n)" choice
            if [ "$choice" == "y" ] || [ "$choice" == "Y" ]; then
                # 读取用户输入Cookiecounter
                read -p "请输入需要设置的数值:" cookiecounter

                # 更新配置文件的Cookiecounter
                sed -i 's/"Cookiecounter": .*,/"Cookiecounter": '$cookiecounter',/g' $clewd_dir/config.js
                echo "Cookiecounter已修改为$cookiecounter"
            else
                echo "未修改Cookiecounter"
            fi
            ;;
        7)  
            # 修改 rProxy
            echo -e "\n1. 官网地址claude.ai\n2. 国内镜像地址finechat.ai\n3. 自定义地址\n0. 不修改"
            read -p "输入选择喵：" choice
            case $choice in 
                1)  
                    sed -i 's/"rProxy": ".*",/"rProxy": "",/g' $clewd_dir/config.js
                    ;; 
                2) 
                    sed -i 's#"rProxy": ".*",#"rProxy": "https://chat.finechat.ai",#g' $clewd_dir/config.js
                    ;; 
                3)
                    # 读取用户输入rProxy
                    read -p "请输入需要设置的数值:" rProxy
                    # 更新配置文件的rProxy
                    sed -i 's#"rProxy": ".*",#"rProxy": "'$rProxy'",#g' $clewd_dir/config.js
                    echo "rProxy已修改为$rProxy"
                    ;; 
                *) 
                    echo "不修改喵~"
                    break ;; 
            esac
            ;;
        8)
            PreventImperson_value=$(grep -oP '"PreventImperson": \K[^,]*' clewd/config.js)
            echo -e "当前PreventImperson值为\033[0;33m $PreventImperson_value \033[0m喵~"
            read -p "是否进行更改[y/n]" PreventImperson_choice
            if [ $PreventImperson_choice == "Y" ] || [ $PreventImperson_choice == "y" ]; then
                if [ $PreventImperson_value == 'false' ];
    then
                    #将false替换为true
                    sed -i 's/"PreventImperson": false,/"PreventImperson": true,/g' $clewd_dir/config.js
                    echo -e "hoping：'PreventImperson'已经被修改成\033[0;33m true \033[0m喵~."
                elif [ $PreventImperson_value == 'true' ];
    then
                    #将true替换为false
                    sed -i 's/"PreventImperson": true,/"PreventImperson": false,/g' $clewd_dir/config.js
                    echo -e "hoping：'PreventImperson'值已经被修改成\033[0;33m false \033[0m喵~."
                else
                    echo -e "呜呜X﹏X\nhoping喵未能找到'PreventImperson'."
                fi
            else
                echo "未进行修改喵~"
            fi
            ;;
        9)
            PassParams_value=$(grep -oP '"PassParams": \K[^,]*' clewd/config.js)
            echo -e "当前PassParams值为\033[0;33m $PassParams_value \033[0m喵~"
            read -p "是否进行更改[y/n]" PassParams_choice
            if [ $PassParams_choice == "Y" ] || [ $PassParams_choice == "y" ]; then
                if [ $PassParams_value == 'false' ];
    then
                    #将false替换为true
                    sed -i 's/"PassParams": false,/"PassParams": true,/g' $clewd_dir/config.js
                    echo -e "hoping：'PassParams'已经被修改成\033[0;33m true \033[0m喵~."
                elif [ $PassParams_value == 'true' ];
    then
                    #将true替换为false
                    sed -i 's/"PassParams": true,/"PassParams": false,/g' $clewd_dir/config.js
                    echo -e "hoping：'PassParams'值已经被修改成\033[0;33m false \033[0m喵~."
                else
                    echo -e "呜呜X﹏X\nhoping喵未能找到'PassParams'."
                fi
            else
                echo "未进行修改喵~"
            fi
            ;;
        a)
            current_values=$(grep '"padtxt":' clewd/config.js | sed -e 's/.*"padtxt": "\(.*\)".*/\1/')
            echo -e "当前的padtxt值为: \033[0;33m$current_values\033[0m"
            echo -e "请输入新的padtxt值喵，格式如：1000,1000,15000"
            read new_values
            sed -i "s/\"padtxt\": \([\"'][^\"']*[\"']\|[0-9]\+\)/\"padtxt\": \"$new_values\"/g" clewd/config.js
            echo -e "更新后的padtxt值: \033[0;36m$(grep '"padtxt":' clewd/config.js | sed -e 's/.*"padtxt": "\(.*\)".*/\1/')\033[0m"
            ;;
        b)
            # Check if 'sactag' is already in the Settings
            cd /root/clewd
            if grep -q '"sactag"' "config.js"; then
                sactag_value=$(grep '"sactag"' "config.js" | sed -E 's/.*"sactag": *"([^"]+)".*/\1/')
            else
                # Add 'sactag' to the Settings
                sed -i'' -e '/"Settings": {/,/}/{ /[^,]$/!b; /}/i\        ,"sactag": "默认"' -e '}' "config.js"
                sactag_value="默认"
            fi
            
            print_selected() {
            echo -e "\033[0;33m--------------------------------\033[0m"
            echo -e "\033[0;33m使用上↑，下↓进行控制\n\033[0m回车选择。"
            echo -e "喵喵当前正在使用: \033[5;36m$sactag_value\033[0m"
            }
            
            configbak=() # 初始化一个空数组
            for file in config_*.js; do
                # 提取每个文件名中的 * 部分，需要去掉 'config_' 和 '.js'
                config_string="${file#config_}"
                config_string="${config_string%.js}"
                # 将提取后的字符串添加到数组中
                configbak+=("$config_string")
            done
            # 输出数组内容以验证结果
            echo "${configbak[@]}"
            modules=("${configbak[@]}")
            modules+=(新建 删除 取消)
            
            declare -A selection_status
            for i in "${!modules[@]}"; do
                selection_status[$i]=0
            done
            
            show_menu() {
                print_selected
            	echo -e "\033[0;33m--------------------------------\033[0m"
            	for i in "${!modules[@]}"; do
            	    if [[ "$i" -eq "$current_selection" ]]; then
            		  # 当前选择中的选项使用绿色显示
            		  echo -e "${GREEN}${modules[$i]}${NC}"
            		else
            		  # 其他选项正常显示
            		  echo -e "${modules[$i]} (未选择)"
            		fi
            	done
            	echo -e "\033[0;33m--------------------------------\033[0m"
            }
            
            clear
            current_selection=1
            while true; do
                show_menu
            	# 读取用户输入
            	IFS= read -rsn1 key
            
            	case "$key" in
                    $'\x1b')
            		# 读取转义序列
            		read -rsn2 -t 0.1 key
            		case "$key" in
            	        '[A') # 上箭头
            			  if [[ $current_selection -eq 0 ]]; then
            				current_selection=$((${#modules[@]} - 1))
            			  else
            				((current_selection--))
            			  fi
            			  ;;
            			'[B') # 下箭头
            			  if [[ $current_selection -eq $((${#modules[@]} - 1)) ]]; then
            				current_selection=0
            			  else
            				((current_selection++))
            			  fi
            			  ;;
            		  esac
            		  ;;
            		"") # Enter键
            		  if [[ $current_selection -eq $((${#modules[@]} - 3)) ]]; then
            			#创建新配置
                        echo "给新的config.js命名喵~"
                        while :
                        do
                            read newsactag
                            [ -n "$newsactag" ] && break
                            echo "命名不能为空，快重新输入🐱喵~"
                        done
                        mv config.js "config_$sactag_value.js"
                        ps -ef | grep clewd.js | awk '{print$2}' | xargs kill -9
                        bash start.sh
                        sed -i'' -e "/\"Settings\": {/,/}/{ /[^,]$/!b; /}/i\\        ,\"sactag\": \"$newsactag\"" -e '}' "config.js"
                        cd /root
                        clewdSettings
                        break
                      elif [[ $current_selection -eq $((${#modules[@]} - 2)) ]]; then
                        #删除config.js
                        echo "输入需要删除的配置名称喵~"
                        echo "当前存在"
                        echo "${configbak[@]}"
                        while :
                        do
                            read delsactag
                            configfile=$(ls config_$delsactag.js 2>/dev/null)
                            [ -n "$configfile" ] && break
                            echo "没找到对应配置，检查一下名称是不是输错了喵~"
                        done
                        rm -rf $configfile
                        cd /root
                        break
            		  elif [[ $current_selection -eq $((${#modules[@]} - 1)) ]]; then
            			# 选择 "退出" 选项
            			echo "当前并未选择"
            			cd /root
            			break
            		  else
            			# 切换config.js
            			mv config.js "config_$sactag_value.js"
            			mv "config_${modules[$current_selection]}.js" config.js
            			echo -e "config文件成功切换为：\033[5;36m$(grep '"sactag"' "config.js" | sed -E 's/.*"sactag": *"([^"]+)".*/\1/')\033[0m"
            			sleep 2
            			cd /root
            			break
            		  fi
            		  ;;
            		'q') # 按 'q' 退出
            		  cd /root
            		  break
            		  ;;
            	esac
            	# 清除屏幕以准备下一轮显示
            	clear
            done
            cd ~
            ;;
        c)
            echo "是否添加自定义模型喵[y/n]？"
            read cuschoice
            if [[ "$cuschoice" == [yY] ]]; then
                echo "输入自定义的模型名称喵~"
                read model_name
                sed -i "/((name => ({ id: name }))), {/a\ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ id: '$model_name'},{" clewd/clewd.js
            else
                echo "并未添加自定义模型喵~"
            fi
            ;;
        d)
            # 修改 api_rProxy
            echo -e "是否修改api_rProxy地址喵~?"[y/n]
            read  choice
            case $choice in  
                [yY])
                    # 读取用户输入rProxy
                    read -p "请输入需要设置代理地址喵~:" api_rProxy
                    # 更新配置文件的rProxy
                    sed -i 's#"api_rProxy": ".*",#"api_rProxy": "'$api_rProxy'",#g' $clewd_dir/config.js
                    echo "api_rProxy已修改为$api_rProxy"
                    ;; 
                *) 
                    echo "不修改喵~"
                    ;; 
            esac
            ;;
        0)
			echo -e "hoping：选择更新模式(两种模式都会保留重要数据)喵~\n\033[0;33m--------------------------------------\n\033[0m\033[0;33m选项1 使用git pull进行简单更新\n\033[0m\033[0;37m选项2 几乎重新下载进行全面更新\n\033[0m"
            read -s -n 1 -p "" clewdup_choice
			echo
			cd /root
			case $clewdup_choice in
				1)
					cd /root/clewd
					git checkout -b test origin/test
					git pull
					;;
				2)
					git clone -b test https://mirror.ghproxy.com/https://github.com/teralomaniac/clewd.git /root/clewd_new
					if [ ! -d "clewd_new" ]; then
						echo -e "(*꒦ິ⌓꒦ີ)\n\033[0;33m hoping：因为网络波动下载失败了，更换网络再试喵~\n\033[0m"
						exit 5
					fi
					cp -r clewd/config*.js clewd_new/
					if [ -f "clewd_new/config.js" ]; then
						echo "config.js配置文件已转移，正在删除旧版clewd"
						rm -rf /root/clewd
						mv clewd_new clewd
					fi
					;;
			esac
			clewd_version="$(grep '"version"' "clewd/package.json" | awk -F '"' '{print $4}')($(grep "Main = 'clewd修改版 v'" "clewd/lib/clewd-utils.js" | awk -F'[()]' '{print $3}'))"
            ;;
        *)
            echo "什么都没有执行喵~"
            ;;
    esac
}

function sillyTavernSettings {
    # 4. SillyTavern设置
	echo -e "\033[0;36mhoping：选一个执行喵~\033[0m
\033[0;33m--------------------------------------\033[0m
\033[0;33m选项1 安装 TavernAI-extras（酒馆拓展）\033[0m
\033[0;37m选项2 启动 TavernAI-extras（酒馆拓展）\033[0m
\033[0;33m选项3 修改 酒馆端口\033[0m
\033[0;37m选项4 导入 最新整合预设\033[0m
\033[0;33m选项5 自定义 模型名称\033[0m
\033[0;37m选项6 自定义 unlock上下文长度\033[0m
\033[0;33m选项7 删除 旧版本酒馆(不包括上一版本)\033[0m
\033[0;37m选项8 回退 上一版本酒馆\033[0m
\033[0;33m选项9 导出 当前版本酒馆\033[0m
\033[0;33m--------------------------------------\033[0m
\033[0;31m选项0 更新酒馆\033[0m
\033[0;33m--------------------------------------\033[0m
"
    read -s -n 1 option
    echo
    case $option in 
        0)
			echo -e "hoping：选择更新模式(重要数据会进行转移，但喵喵最好自己有备份)喵~\n\033[0;33m--------------------------------------\n\033[0m\033[0;33m选项1 使用git pull进行简单更新\n\033[0m\033[0;37m选项2 几乎重新下载进行全面更新\n\033[0m"
            read -s -n 1 -p "" stup_choice
			echo
			cd /root
			case $stup_choice in
				1)
					cd /root/SillyTavern
					git pull
					;;
				2)
					if [ -d "SillyTavern_old" ]; then                                   
						NEW_FOLDER_NAME="SillyTavern_$(date +%Y%m%d)"
						mv SillyTavern_old $NEW_FOLDER_NAME
					fi                                                                
					echo -e "
hoping：选择更新正式版或者测试版喵？
\033[0;33m选项1 正式版\033[0m
\033[0;37m选项2 测试版\033[0m"
					while :
					do
					    read -s -n 1 stupdate
					    [ "$stupdate" = 1 ] && { git clone https://mirror.ghproxy.com/https://github.com/SillyTavern/SillyTavern.git SillyTavern_new; break; }
					    [ "$stupdate" = 2 ] && { git clone -b staging https://mirror.ghproxy.com/https://github.com/SillyTavern/SillyTavern.git SillyTavern_new; break; }
					    echo -e "\n\033[5;33m选择错误，快快重新选择喵~\033[0m"
					done

					if [ ! -d "SillyTavern_new" ]; then
						echo -e "(*꒦ິ⌓꒦ີ)\n\033[0;33m hoping：因为网络波动下载失败了，更换网络再试喵~\n\033[0m"
						exit 5
					fi
					
					if [ -d "SillyTavern/data/default-user" ]; then
					    cp -r SillyTavern/data/default-user/characters/. SillyTavern_new/public/characters/
    					cp -r SillyTavern/data/default-user/chats/. SillyTavern_new/public/chats/       
    					cp -r SillyTavern/data/default-user/worlds/. SillyTavern_new/public/worlds/
    					cp -r SillyTavern/data/default-user/groups/. SillyTavern_new/public/groups/
    					cp -r SillyTavern/data/default-user/group\ chats/. SillyTavern_new/public/group\ chats/
    					cp -r SillyTavern/data/default-user/OpenAI\ Settings/. SillyTavern_new/public/OpenAI\ Settings/
    					cp -r SillyTavern/data/default-user/User\ Avatars/. SillyTavern_new/public/User\ Avatars/
    					cp -r SillyTavern/data/default-user/backgrounds/. SillyTavern_new/public/backgrounds/
    					cp -r SillyTavern/data/default-user/settings.json SillyTavern_new/public/settings.json
					else
    					cp -r SillyTavern/public/characters/. SillyTavern_new/public/characters/
    					cp -r SillyTavern/public/chats/. SillyTavern_new/public/chats/       
    					cp -r SillyTavern/public/worlds/. SillyTavern_new/public/worlds/
    					cp -r SillyTavern/public/groups/. SillyTavern_new/public/groups/
    					cp -r SillyTavern/public/group\ chats/. SillyTavern_new/public/group\ chats/
    					cp -r SillyTavern/public/OpenAI\ Settings/. SillyTavern_new/public/OpenAI\ Settings/
    					cp -r SillyTavern/public/User\ Avatars/. SillyTavern_new/public/User\ Avatars/
    					cp -r SillyTavern/public/backgrounds/. SillyTavern_new/public/backgrounds/
    					cp -r SillyTavern/public/settings.json SillyTavern_new/public/settings.json
					fi
					
					mv SillyTavern SillyTavern_old                                  
					mv SillyTavern_new SillyTavern
					echo -e "\033[0;33mhoping：酒馆已更新完毕，启动后若丢失聊天请回退上一版本喵~\033[0m"
					;;
			esac
			st_version=$(grep '"version"' "SillyTavern/package.json" | awk -F '"' '{print $4}')
            ;;
        1)
            #安装TavernAI-extras（酒馆拓展）及其环境
			TavernAI-extrasinstall
            ;;
        2)
            #启动TavernAI-extras（酒馆拓展）
			TavernAI-extrasstart
            ;;
		3)
			if [ ! -f "SillyTavern/config.yaml" ]; then
				echo -e "当前酒馆版本过低，请更新酒馆版本后重试"
				exit
			fi
            read -p "是否要修改开放端口?(y/n)" choice

            if [ "$choice" == "y" ] || [ "$choice" == "Y" ]; then
                # 读取用户输入的端口号
                read -p "请输入开放的端口号:" custom_port
                # 更新配置文件的端口号
                sed -i 's/port: [0-9]*/port: '$custom_port'/g' SillyTavern/config.yaml
                echo "端口已修改为$custom_port"
            else
                echo "未修改端口号"
            fi
            ;;
        4)
            #导入破限
            echo -e "$(curl -s https://raw.githubusercontent.com/hopingmiao/promot/main/STpromotINFO)"
            echo "是否导入当前预设喵？[y/n]"
            read choice
            if [[ "$choice" == [yY] ]]; then
                echo -e "\033[0;33m本操作仅为破限下载提供方便，所有破限皆为收录，喵喵不具有破限所有权\033[0m"
                sleep 2
                rm -rf /root/st_promot
                git clone https://mirror.ghproxy.com/https://github.com/hopingmiao/promot.git /root/st_promot
                if  [ ! -d "/root/st_promot" ]; then
                    echo -e "(*꒦ິ⌓꒦ີ)\n\033[0;33m hoping：因网络波动文件下载失败了，更换网络后再试喵~\n\033[0m"
                exit 6
                fi
                cp -r /root/st_promot/. /root/SillyTavern/public/'OpenAI Settings'/
                echo -e "\033[0;33m破限已成功导入，启动酒馆看看喵~\033[0m"
            else
                echo "当前预设未导入喵~"
            fi
            ;;
        5)
            echo -e "\033[5;33m当前存在自定义模型有：\033[0m"
            echo -e "$(sed -n '/<optgroup label="自定义">/,/<optgroup label="GPT-3.5 Turbo">/{s/.*<option value="\([^"]*\)".*/\1/p}' SillyTavern/public/index.html)"
            echo "是否添加自定义模型喵[y/n]？"
            read cuschoice
            if [[ "$cuschoice" == [yY] ]]; then
                echo "输入自定义的模型名称喵~"
                read CUSTOM_INPUT_VALUE
                grep -q '<optgroup label="自定义">' "SillyTavern/public/index.html" && sed -i "/<optgroup label=\"自定义\">/a\ \ \ \ <option value=\"$CUSTOM_INPUT_VALUE\">$CUSTOM_INPUT_VALUE</option>" "SillyTavern/public/index.html" || { sed -i "/<optgroup label=\"GPT-3.5 Turbo\">/i\<optgroup label=\"自定义\">\n\ \ \ \ <option value=\"$CUSTOM_INPUT_VALUE\">$CUSTOM_INPUT_VALUE</option>\n</optgroup>" "SillyTavern/public/index.html"; sed -i "/<optgroup label=\"Versions\">/i\<optgroup label=\"自定义\">\n\ \ \ \ <option value=\"$CUSTOM_INPUT_VALUE\">$CUSTOM_INPUT_VALUE</option>\n</optgroup>" "SillyTavern/public/index.html"; }
                echo -e "\033[0;33m已添加$CUSTOM_INPUT_VALUE模型喵~\033[0m"
            else
                echo "并未添加喵~"
            fi
            sleep 2
            ;;
        6)
            unlocked_max=$(sed -n 's/^const unlocked_max = \(.*\);$/\1/p' SillyTavern/public/scripts/openai.js)
            echo "当前unlocked_max(最大上下文)为$unlocked_max喵~"
            echo "是否修改最大上下文喵？[y/n]"
            read unlockedchoice
            if [[ "$unlockedchoice" == [yY] ]]; then
                echo "输入unlocked_max值，例如200000"
                read unlocked_max
                sed -i "s/^const unlocked_max = .*;/const unlocked_max = ${unlocked_max};/" "SillyTavern/public/scripts/openai.js"
            else
                echo "并未修改喵~"
            fi
            ;;
        7)
            echo -e "当前存在"
            ls | grep "^SillyTavern_\([^o].*\|..+\.?.*\)$"
            echo -e "是否删除所有旧版本酒馆喵？"
            read delSTChoice
            [[ "$delSTChoice" == [yY] ]] && { echo -e "开始删除喵~"; ls | grep "^SillyTavern_\([^o].*\|..+\.?.*\)$" | xargs -d"\n" rm -r; echo -e "旧版本酒馆删除完成了喵~"; } || echo "什么都没有执行喵~" >&2
            ;;
        8)
            while :
            do
                [ ! -d SillyTavern_old ] && { echo -e "hoping：当前未检查到上一版本喵~"; break; }
                echo -e "版本正在回退中，请稍等喵~"
                mv SillyTavern SillyTavern_temp
                mv SillyTavern_old SillyTavern
                mv SillyTavern_temp SillyTavern_old
                echo -e "hoping：版本回退成功了喵~"
                st_version=$(grep '"version"' "SillyTavern/package.json" | awk -F '"' '{print $4}')
                break   
            done
            ;;
        9)
            [ ! command -v zip &> /dev/null ] && { DEBIAN_FRONTEND=noninteractive apt install zip -y; }
            echo -e "\033[0;33m压缩文件中，请稍等喵~\033[0m"
            rm -rf SillyTavern.zip
            zip -rq SillyTavern.zip SillyTavern/
            echo -e "文件压缩完成"
            python -m http.server 8976 &
            echo -e "hoping：\033[0;33m十秒后将关闭网页并回到主页面喵~\033[0m"
            termux-open-url http://127.0.0.1:8976/SillyTavern.zip
            sleep 10
            rm -rf SillyTavern.zip
            pkill -f 'python -m http.server'
            ;;
        *)
            echo "什么都没有执行喵~"
            ;;
    esac
}

function TavernAI-extrasinstall {

	echo -e "安装TavernAI-extras（酒馆拓展）分为三步骤\n分别大致所需\n三分钟\n\033[0;33m七分钟\n\033[0m\033[0;31m十五分钟\n\033[0m具体时间视情况而定\n\033[0;31m全部安装大致所需\033[0;33m 3 \033[0m\033[0;31mG存储(不包括额外模型)\033[0m"
	echo -e "当出现\n\033[0;32m恭喜TavernAI-extras（酒馆拓展）所需环境已完全安装，可进行启动喵~\033[0m\n则说明安装完毕喵~"
	read -p "是否现在进行安装TavernAI-extras（酒馆拓展）[y/n]？" extrasinstallchoice
	[ "$extrasinstallchoice" = "y" ] || [ "$extrasinstallchoice" = "Y" ] && echo "已开始安装喵~" || exit 7
	#检测环境
	if [ ! -d "/root/TavernAI-extras" ]; then
		echo "hoping:未检测到TavernAI-extras（酒馆拓展），正在通过git下载"
		git clone https://mirror.ghproxy.com/https://github.com/Cohee1207/TavernAI-extras /root/TavernAI-extras
		[ -d /root/TavernAI-extras ] || { echo "TavernAI-extras（酒馆拓展）安装失败，请更换网络后重试喵~"; exit 8; }
	fi
	
	if [ ! -d "/root/myenv" ] || [ ! -f "/root/myenv/bin/activate" ]; then
		rm -rf /root/myenv
		# 更新软件包列表并安装所需软件包，重定向输出。
  	    while ! command -v lsb_release &> /dev/null
            do
	        if ! command -v lsb_release &> /dev/null; then
	        echo -e "\n\033[0;31m检测到你未安装lsb-release喵~\n\033[0m"
	        echo -e "\033[0;33m正在为你下载lsb-release，请稍等一下喵~\n\033[0m"
	        yes | apt update
	 	yes | apt upgrade
	        DEBIAN_FRONTEND=noninteractive apt-get install lsb-release -y
	            if ! command -v lsb_release &> /dev/null; then
	            echo -e "\033[0;31mlsb-release下载失败了，正在重试中，请稍等一下喵~\n\033[0m"
		    sleep 2
		    continue
		    else
	            echo -e "\n\033[0;32mlsb-release安装成功喵~\n\033[0m"
	            fi
	       fi
	     done
		echo "正在更新软件包列表..."
  		echo -e "\n\033[0;33m喵喵正在帮你选择国内代理中，请稍等一下喵~\n\033[0m"
     		bash <(curl -sSL https://linuxmirrors.cn/main.sh) << eof
    		6
eof
		apt update -y > /dev/null 2>&1
		echo -e "\033[0;33m正在安装python3虚拟环境，请稍候\n\033[0;33m(hoping：首次安装大概需要7到15分钟喵~)..."
		read -p "是否现在进行安装喵？[y/n]" python3venvchoicce
		[ "$python3venvchoicce" = "y" ] || [ "$python3venvchoicce" = "Y" ] && DEBIAN_FRONTEND=noninteractive apt install python3 python3-pip python3-venv -y || exit 9
		echo "python3虚拟环境安装完成。正在创建虚拟环境"
		python3 -m venv /root/myenv
		echo "虚拟环境完成，路径为/root/myenv"
	fi
	echo -e "\033[0;31m正在安装requirements.txt所需依赖\n\033[0m(hoping：首次安装大概需要15至30分钟，最后构建时会出现长时间页面无变化，请耐心等待喵~)..."
	read -p "是否现在进行安装喵？[y/n]" requirementschoice
	[ "$requirementschoice" = "y" ] || [ "$requirementschoice" = "Y" ] && { source /root/myenv/bin/activate; pip install -i https://pypi.tuna.tsinghua.edu.cn/simple some-package ; cd /root/TavernAI-extras; pip3 install -r requirements.txt; } || exit 10
	echo -e "喵喵？\n\033[0;32m恭喜TavernAI-extras（酒馆拓展）所需环境已完全安装，可进行启动喵~\033[0m"
	
}

function TavernAI-extrasstart {

	if [ ! -d "/root/TavernAI-extras" ] || [ ! -d "/root/myenv" ] || [ ! -f "/root/myenv/bin/activate" ]; then
	echo "检测到当前环境不完整，先进行TavernAI-extras（酒馆拓展）安装喵~"
	exit 11
	fi
	echo -e "\033[0;33m喵喵小提示：\n\033[0m启动对应拓展时可能需要额外下载，具体情况可以查看官方文档喵~"
	sleep 3
	
	#进入虚拟环境
	source /root/myenv/bin/activate
	cd /root/TavernAI-extras
	#确认依赖已安装
	echo -e "正在检测依赖安装情况喵~"
	pip3 install -r requirements.txt
	clear
	
	# 选项数组
	modules=("caption" "chromadb" "classify" "coqui-tts" "edge-tts" "embeddings" "rvc" "sd" "silero-tts" "summarize" "talkinghead" "websearch" "确认" "退出")

	# 数组中选项的状态，0 - 未选择，1 - 已选定
	declare -A selection_status

	# 初始化选项状态
	for i in "${!modules[@]}"; do
	  selection_status[$i]=0
	  selection_status[4]=1
	done

	# 函数：打印已选中的选项
	print_selected() {
	  selected_modules=()
	  for i in "${!selection_status[@]}"; do
		if [[ "${selection_status[$i]}" -eq 1 ]]; then
		  selected_modules+=("${modules[$i]}")
		fi
	  done
	  echo -e "\033[0;33m--------------------------------\033[0m"
	  echo -e "\033[0;33m使用上↑，下↓进行控制\n\033[0m回车选中，再次选中可取消选定\n\033[0;33m选择完毕后选择确认即可喵~\033[0m"
	  echo "喵喵当前选择了: $(IFS=,; echo -e "\033[0;36m${selected_modules[*]}\033[0m")"
	}

	# 函数：显示菜单
	show_menu() {
	  print_selected
	  echo -e "\033[0;33m--------------------------------\033[0m"
	  for i in "${!modules[@]}"; do
		if [[ "$i" -eq "$current_selection" ]]; then
		  # 当前选择中的选项使用绿色显示
		  echo -e "${GREEN}${modules[$i]} (选择中)${NC}"
		elif [[ "${selection_status[$i]}" -eq 1 ]]; then
		  # 被选定的选项使用红色显示
		  echo -e "${RED}${modules[$i]} (已选定)${NC}"
		else
		  # 其他选项正常显示
		  echo -e "${modules[$i]} (未选择)"
		fi
	  done
	  echo -e "\033[0;33m--------------------------------\033[0m"
	}

	current_selection=0
	while true; do
	  show_menu
	  # 读取用户输入
	  IFS= read -rsn1 key

	  case "$key" in
		$'\x1b')
		  # 读取转义序列
		  read -rsn2 -t 0.1 key
		  case "$key" in
			'[A') # 上箭头
			  if [[ $current_selection -eq 0 ]]; then
				current_selection=$((${#modules[@]} - 1))
			  else
				((current_selection--))
			  fi
			  ;;
			'[B') # 下箭头
			  if [[ $current_selection -eq $((${#modules[@]} - 1)) ]]; then
				current_selection=0
			  else
				((current_selection++))
			  fi
			  ;;
		  esac
		  ;;
		"") # Enter键
		  if [[ $current_selection -eq $((${#modules[@]} - 2)) ]]; then
			# 选择 "确认" 选项
			break
		  elif [[ $current_selection -eq $((${#modules[@]} - 1)) ]]; then
			# 选择 "退出" 选项
			exit 12
		  else
			# 切换选择状态
			selection_status[$current_selection]=$((1 - selection_status[$current_selection]))
		  fi
		  ;;
		'q') # 按 'q' 退出
		  break
		  ;;
	  esac
	  # 清除屏幕以准备下一轮显示
	  clear
	done

	# 构建命令行
	command="python3 server.py"
	if [ ${#selected_modules[@]} -ne 0 ]; then
	  command+=" --enable-module=$(IFS=,; echo "${selected_modules[*]}")"
	fi

	# 打印最终的命令行
	clear
	echo "正在启动相关酒馆拓展喵~:"
	echo "$command"
	eval $command
	
	
	
}

#版本：酒馆:$st_version clewd:$clewd_version 脚本:$version
#最新：\033[5;36m酒馆:$st_latest\033[0m \033[5;32mclewd:$clewd_latest\033[0m \033[0;33m脚本:$latest_version\033[0m
# 主菜单
echo -e "喵喵一键脚本(QChatGPT版)
作者：hoping喵(懒喵~)，水秋喵(苦等hoping喵起床)
来自：Claude2.1先行破限组
群号：704819371，910524479，304690608
类脑Discord(角色卡发布等): https://discord.gg/HWNkueX34q
此程序完全免费，不允许如浅睡纪元等人对脚本/教程进行盗用/商用。

\033[0;34m修改人:瑾年\033[0m
\033[0;34m来自：头脑风暴搞起来\033[0m
"
while :
do 
    echo -e "\033[0;36mhoping喵~让你选一个执行（输入数字即可），懂了吗？\033[0;38m(｡ì _ í｡)\033[0m\033[0m
\033[0;33m--------------------------------------\033[0m
\033[0;31m选项0 退出脚本\033[0m
\033[0;34m选项1 启动One-Api\033[0m
\033[0;37m选项2 启动酒馆\033[0m
\033[0;34m选项3 启动QChatGPT\033[0m
\033[0;37m选项4 启动NapCatQQ\033[0m
\033[0;34m选项5 启动MINIMAX_TTS\033[0m
\033[0;37m选项6 QChatGPT设置\033[0m
\033[0;34m选项7 酒馆设置\033[0m
\033[0;37m选项8 MINIMAX_TTS设置\033[0m
\033[0;34m选项a 启动Clewd\033[0m
\033[0;37m选项b Clewd设置\033[0m
\033[0;33m--------------------------------------\033[0m
\033[0;31m选项9 更新脚本\033[0m
\033[0;33m--------------------------------------\033[0m
\033[0;35m不准选其他选项，听到了吗？
\033[0m\n(⇀‸↼‶)"
    read -s -n 1 option
    echo 
    case $option in 
        0) 
            break ;; 
        1) 
            #启动One-Api
	    ps -ef | grep one-api | awk '{print$2}' | xargs kill -9
            cd /root/one-api
	    #设置npm国内源
	    npm config set registry https://registry.npmmirror.com
            bash start.sh
            echo "One-Api已关闭, 即将返回主菜单"
            cd ../
            ;; 
        2) 
            #启动SillyTavern
	    ps -ef | grep server.js | awk '{print$2}' | xargs kill -9
            cd /root/SillyTavern
	    #设置npm国内源
	    npm config set registry https://registry.npmmirror.com
	    bash start.sh
            echo "酒馆已关闭, 即将返回主菜单"
            cd ../
            ;;   
            
        3) 
            #启动QChatGPT
		cd /root/QChatGPT/bin
  		source activate
    		cd ..
                echo -e "\n\033[0;33m正在启动QChatGpt中，请稍等一下喵~\033[0m"
		python3 main.py
  		deactivate
    		cd /root
            ;; 
        4) 
            #启动NapCatQQ
	    echo -e "\033[0;36m请选择添加QQ号或快速登录（输入数字即可）喵~\033[0m
\033[0;33m--------------------------------------\033[0m
\033[0;34m选项1 添加QQ号\033[0m
\033[0;37m选项2 快速登录QQ号\033[0m
\033[0;34m选项3 查看后台情况\033[0m
\033[0;37m选项4 退出登陆QQ号\033[0m
\033[0;34m选项5 删除QQ号\033[0m
\033[0;33m--------------------------------------\033[0m
\033[0;35m不准选其他选项，听到了喵？"
		read -s -n 1 chose
		case $chose in 
	            1)
		    	echo -e "\n\033[0;33m请输入你的QQ机器人号码喵~\033[0m\n"
       			read -p "QQ：" new_QQ
       			echo -e "\n\033[0;33m请确认你的QQ机器人号码喵~（y|N）\033[0m\n"
      			echo -e "\033[0;33mQQ："$new_QQ"\033[0m"
	 		read -s -n 1 chose
       			case $chose in 
	        	    y|Y)
	        		cp /opt/QQ/resources/app/app_launcher/napcat/config/onebot11.json /opt/QQ/resources/app/app_launcher/napcat/config/onebot11_$new_QQ.json
       				sed -i '17s/false/true/' /opt/QQ/resources/app/app_launcher/napcat/config/onebot11_$new_QQ.json
       				sed -i '18s/\[\]/\["ws:\/\/127.0.0.1:8080\/ws"\]/' /opt/QQ/resources/app/app_launcher/napcat/config/onebot11_$new_QQ.json
       				echo -e "\n\033[0;33m正在启动...请用你输入的QQ号扫码登录喵~\033[0m\n"
	   			sleep 2
				xvfb-run -a qq --no-sandbox;;
			    *)
				echo -e "\n\033[0;36m你已取消登录喵~\033[0m\n";;
	  		esac
			;;
		    2)
      			#获取napcatQQ.json列表
			qList=$(ls -1 /opt/QQ/resources/app/app_launcher/napcat/config/ | awk -F'_' '{print $2}' | awk -F'.' '{print $1}' | awk '!a[$0]++{print}' | awk 'NF{a++;print "\033[0;33m"a"\033[0m""\033[0;33m.\033[0m","\033[0;33m"$0"\033[0m\n";next}1')
			if [ ! "$qList" ]; then
		    		echo -e "\n\033[0;31m你根本没有添加过QQ号，你是在玩我喵喵大人喵？\033[0m\n"
		    	else
				echo -e "\n\033[0;36m请输入数字登录对应的QQ号喵~\033[0m\n"
				echo "$qList"
		    		read -s -n 1 QQchose
				QQnumber=$(ls -1 /opt/QQ/resources/app/app_launcher/napcat/config/ | awk -F'_' '{print $2}' | awk -F'.' '{print $1}' | awk '!a[$0]++{print}'| awk NF | awk -v QQchose=$QQchose NR==$QQchose)
					if [ "$QQnumber" ]; then
	                		echo -e "\n\033[0;36m你确定要登录以下QQ号喵？(y|N)\033[0m\n"
					echo -e "\033[0;33mQQ："$QQnumber"\033[0m"
		  			read -s -n 1 chose
						case $chose in 
			        	    	y|Y)
				     			screen -dmS napcat bash -c "xvfb-run -a qq --no-sandbox -q $QQnumber"
							echo -e "\n\033[0;32m已执行登录命令，可以在后台检查登录状态喵~\033[0m\n";;
					      	*)
							echo -e "\n\033[0;36m你已取消登录喵~\033[0m\n";;
			  			esac
	                		else
					echo -e "\n\033[0;31m你怎么乱选！不给你登录了喵~\033[0m\n"
		 			fi
    			fi
	   		;;
		    3)
			qLogin=$(ps -ef | grep napcat | awk '{print $0}' | awk -F'-q ' '{print $2}' | awk '!a[$0]++{print}' | awk 'NF{a++;print "\033[0;33m"a"\033[0m""\033[0;33m.\033[0m","\033[0;33m"$0"\033[0m\n";next}1')
			if [ ! "$qLogin" ]; then
		    		echo -e "\n\033[0;31m你根本没有登录QQ号，你是在玩我喵喵大人喵？\033[0m\n"
	            		cd /root
		    	else
				echo -e "\n\033[0;36m请选择需要查看后台的QQ号喵~\033[0m\n"
				echo "$qLogin"
		    		read -s -n 1 QQchose
				QQnumber=$(ps -ef | grep napcat | awk '{print $0}' | awk -F'-q ' '{print $2}' | awk '!a[$0]++{print}'| awk NF | awk -v QQchose=$QQchose NR==$QQchose)
					if [ "$QQnumber" ]; then
	                		echo -e "\n\033[0;36m你确定要查看以下QQ号的后台喵？(y|N)\033[0m\n"
					echo -e "\033[0;33mQQ：$QQnumber\033[0m"
		  			read -s -n 1 chose
						case $chose in 
			        	    	y|Y)
		 					echo -e "\n\033[0;36mCtrl+A+D退出后台不退出登录，Ctrl+C退出登录喵~\033[0m"
							echo -e "\033[0;36m看懂了请按任意键继续喵~\033[0m"
       							read -s -n 1
		 					PID=$(ps -ef | grep "SCREEN -dmS napcat bash -c xvfb-run -a qq --no-sandbox -q $QQnumber" | grep -v "grep" | awk -F' +' '{print $2}')
				     			screen -r $PID.napcat;;
					      	*)
							echo -e "\n\033[0;36m你已取消查看后台喵~\033[0m\n";;
			  			esac
	                		else
					echo -e "\n\033[0;31m你怎么乱选！不给你查了喵~\033[0m\n"
		 			fi
    			fi
	   		;;
		    4)
			qLogin=$(ps -ef | grep napcat | awk '{print $0}' | awk -F'-q ' '{print $2}' | awk '!a[$0]++{print}' | awk 'NF{a++;print "\033[0;33m"a"\033[0m""\033[0;33m.\033[0m","\033[0;33m"$0"\033[0m\n";next}1')
			if [ ! "$qLogin" ]; then
		    		echo -e "\n\033[0;31m你根本没有登录QQ号，你是在玩我喵喵大人喵？\033[0m\n"
		    	else
				echo -e "\n\033[0;36m请选择需要退出登录的QQ号喵~\033[0m\n"
				echo "$qLogin"
		    		read -s -n 1 QQchose
				QQnumber=$(ps -ef | grep napcat | awk '{print $0}' | awk -F'-q ' '{print $2}' | awk '!a[$0]++{print}'| awk NF | awk -v QQchose=$QQchose NR==$QQchose)
					if [ "$QQnumber" ]; then
	                		echo -e "\n\033[0;36m你确定要退出登录该QQ号喵？(y|N)\033[0m\n"
					echo -e "\033[0;33mQQ：$QQnumber\033[0m"
		  			read -s -n 1 chose
						case $chose in 
			        	    	y|Y)
		 					PID=$(ps -ef | grep "SCREEN -dmS napcat bash -c xvfb-run -a qq --no-sandbox -q $QQnumber" | grep -v "grep" | awk -F' +' '{print $2}')
				     			kill -9 $PID
	    						echo -e "\n\033[0;32mQQ：$QQnumber已退出登录喵~\033[0m\n";;
					      	*)
							echo -e "\n\033[0;36m你已取消退出登录喵~\033[0m\n";;
			  			esac
	                		else
					echo -e "\n\033[0;31m你怎么乱选！不给你退了喵~\033[0m\n"
		 			fi
    			fi
	   		;;
		    5)
      			#获取napcatQQ.json列表
			qList=$(ls -1 /opt/QQ/resources/app/app_launcher/napcat/config/ | awk -F'_' '{print $2}' | awk -F'.' '{print $1}' | awk '!a[$0]++{print}' | awk 'NF{a++;print "\033[0;33m"a"\033[0m""\033[0;33m.\033[0m","\033[0;33m"$0"\033[0m\n";next}1')
			if [ ! "$qList" ]; then
		    		echo -e "\n\033[0;31m你根本没有添加QQ号，你是在玩我喵喵大人喵？\033[0m\n"
		    	else
				echo -e "\n\033[0;36m请输入数字删除对应的QQ号喵~\033[0m\n"
				echo "$qList"
		    		read -s -n 1 QQchose
				QQnumber=$(ls -1 /opt/QQ/resources/app/app_launcher/napcat/config/ | awk -F'_' '{print $2}' | awk -F'.' '{print $1}' | awk '!a[$0]++{print}'| awk NF | awk -v QQchose=$QQchose NR==$QQchose)
					if [ "$QQnumber" ]; then
	                		echo -e "\n\033[0;36m你确定要删除以下QQ号喵？(y|N)\033[0m\n"
					echo -e "\033[0;33mQQ："$QQnumber"\033[0m"
		  			read -s -n 1 chose
						case $chose in 
			        	    	y|Y)
				     			rm -rf /opt/QQ/resources/app/app_launcher/napcat/config/onebot11_$QQnumber.json
	    						rm -rf /opt/QQ/resources/app/app_launcher/napcat/config/napcat_$QQnumber.json
							echo -e "\n\033[0;32mQQ："$QQnumber" 已删除喵~\033[0m\n";;
					      	*)
							echo -e "\n\033[0;36m你已取消删除喵~\033[0m\n";;
			  			esac
	                		else
					echo -e "\n\033[0;31m你怎么乱选！不给你删除了喵~\033[0m\n"
		 			fi
    			fi
	   		;;
	   	    *)
			echo -e "\n\033[0;31m你怎么乱选！不跟你玩了喵~\033[0m\n";;
	  		esac
			echo -e "\033[0;33m3s后返回主菜单喵~\033[0m\n"
   			sleep 3
            		cd /root
        	;; 
        5) 
            #启动MINIMAX_TTS
		cd /root/MM_Audio/bin
  		source activate
    		cd ..
                echo -e "\n\033[0;33m正在启动MINIMAX_TTS中，请稍等一下喵~\033[0m"
		python3 main.py
  		deactivate
    		cd /root
            ;; 
	6)
            #QChatGPT设置
	    QChatGPTSettings
            ;;
        7) 
            #SillyTavern设置
            sillyTavernSettings
            ;; 

        8) 
            #MINIMAX_TTS设置
            MINIMAX_TTS_Settings
            ;; 
        9)
            # 更新脚本
      	    rm -rf /root/update_QCCN.sh
	    rm -rf /root/one-api/start.sh
      	    while [ ! -f "update_QCCN.sh" ]
            do
                if [ ! -f "update_QCCN.sh" ]; then
		echo -e "\033[0;33m更新脚本已删除，正在通过git重新下载喵...\033[0m\n"
          	curl -O -L https://mirror.ghproxy.com/https://raw.githubusercontent.com/YunZLu/termux_using_openai/main/QC_CN/update_QCCN.sh
      	                if [ ! -f "update_QCCN.sh" ]; then
      		              echo -e "\n\033[0;31m更新脚本下载失败了，正在重试喵...\033[0m\n"
      		              continue
      		        else
      	                      echo -e "\n\033[0;32m更新脚本下载成功，正在进入更新程序喵~\033[0m\n"
			      chmod 777 /root/update_QCCN.sh
			      exec /root/update_QCCN.sh
      		        fi
            fi
            done
	    ;;
        a) 
            #启动Clewd
            port=$(grep -oP '"Port":\s*\K\d+' clewd/config.js)
            echo "端口为$port, 出现 (x)Login in {邮箱} 代表启动成功, 后续出现AI无法应答等报错请检查本窗口喵。"
			ps -ef | grep clewd.js | awk '{print$2}' | xargs kill -9
            cd /root/clewd
	    #设置npm国内源
	    npm config set registry https://registry.npmmirror.com
            bash start.sh
            echo "Clewd已关闭, 即将返回主菜单"
            cd ../
            ;; 
	b) 
            #Clewd设置
            clewdSettings
            ;; 
        *) 
            echo -e "m9( ｀д´ )!!!! \n\033[0;36m坏猫猫居然不听话，存心和我hoping喵~过不去是吧喵？\033[0m\n"
            ;;
    esac
done 
echo "已退出喵喵一键脚本，输入 bash 可重新进入脚本喵~"
exit

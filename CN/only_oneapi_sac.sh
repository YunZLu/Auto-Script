# 主菜单
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

while :
do 
echo -e "\033[0;36m喵喵~让你选一个执行（输入数字即可），懂了喵？\033[0m
\033[0;33m--------------------------------------\033[0m
\033[0;31m选项0 退出脚本\033[0m
\033[0;33m--------------------------------------\033[0m
\033[0;34m选项1 启动One-Api\033[0m
\033[0;33m选项2 安装酒馆\033[0m
\033[0;33m--------------------------------------\033[0m
\033[0;35m不准选其他选项，听到了喵？(⇀‸↼‶)\033[0m"

    read -n 1 option
    echo 
    case $option in 
        0) 
            break ;; 
        1) 
            #启动One-Api
	    ps -ef | grep one-api | awk '{print$2}' | xargs kill -9
            cd one-api
            bash start.sh
            echo -e "\033[0mOne-Api已关闭, 即将返回主菜单喵~\033[0m"
            cd ../
            ;; 
        2) 
            #安装酒馆
            echo -e "\033[0;35m确定要安装酒馆喵?\033[0m"
	    echo -e "\033[0;35m输入Y安装酒馆，或者按回车键返回喵~\033[0m"
     	    read -n 1 choice
            case "$choice" in
   	    y|Y )
	    pkg uninstall nodejs-lts
	    echo ""> .bashrc
            curl -O https://mirror.ghproxy.com/https://raw.githubusercontent.com/YunZLu/termux_using_openai/main/CN/tisac.sh && chmod +x tisac.sh && ./tisac.sh;;
	    * )
            echo -e "\033[0;32m你已选择不安装酒馆喵~\033[0m\n";;
	    esac
            ;; 
        *) 
	    echo -e "\n\033[0;31mo(*≧▽≦)ツ┏━┓\033[0m"
            echo -e "\n\033[0;31m坏猫猫居然不听话，存心和我喵喵过不去是吧？\033[0m\n"
            ;;
    esac
done 
echo -e "\033[0;32m已退出喵喵一键脚本，输入 bash only_oneapi_sac.sh 可重新进入脚本喵~\033[0m\n"
exit

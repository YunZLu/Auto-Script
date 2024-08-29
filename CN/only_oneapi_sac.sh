# 主菜单
echo -e "                                              
\033[0;32m喵喵一键脚本(one-api CN版)\033[0m
\033[0;32m作者：瑾年\033[0m
\033[0;32m来自：头脑风暴搞起来\033[0m
"
while :
do 
echo -e "\033[0;36m喵喵~让你选一个执行（输入数字即可），懂了喵？\033[0m
\033[0;33m--------------------------------------\033[0m
\033[0;31m选项0 退出脚本\033[0m
\033[0;33m--------------------------------------\033[0m
\033[0;34m选项1 启动One-Api\033[0m
\033[0;33m选项2 安装酒馆\033[0m
\033[0;33m--------------------------------------\033[0m
\033[0;35m不准选其他选项，听到了喵？(⇀‸↼‶)\033[0m\n"

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
            echo -e "\n\033[0;35m确定要安装酒馆喵?\033[0m\n"
	    echo -e "\033[0;35m输入Y安装酒馆，或者按回车键返回喵~\033[0m\n"
     	    read -n 1 choice
            case "$choice" in
   	    y|Y )
	    echo ""> .bashrc
            curl -O https://mirror.ghproxy.com/https://raw.githubusercontent.com/YunZLu/termux_using_openai/main/CN/tisac.sh && chmod +x tisac.sh && ./tisac.sh;;
	    * )
            echo -e "\033[0;32m你已选择不安装酒馆喵~\033[0m\n";;
	    esac
            ;; 
        *) 
	    echo -e "\n\033[0;31mo(*≧▽≦)ツ┏━┓\033[0m"
            echo -e "\n\033[0;31m坏猫猫居然不听话，存心和我喵喵~过不去是吧？\033[0m\n"
            ;;
    esac
done 
echo -e "\033[0;32m已退出喵喵一键脚本，输入 bash only_oneapi_sac.sh 可重新进入脚本喵~\033[0m\n"
exit

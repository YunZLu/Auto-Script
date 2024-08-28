# 主菜单
echo -e "                                              
喵喵一键脚本(one-api CN版)
作者：瑾年
来自：头脑风暴搞起来
"
while :
do 
echo -e "\033[0;36m喵喵~让你选一个执行（输入数字即可），懂了吗？\033[0;38m(｡ì _ í｡)\033[0m\033[0m
\033[0;33m--------------------------------------\033[0m
\033[0;31m选项0 退出脚本\033[0m
\033[0;33m--------------------------------------\033[0m
\033[0;34m选项1 启动One-Api\033[0m
\033[0;33m选项2 安装酒馆\033[0m
\033[0;33m--------------------------------------\033[0m
\033[0;35m不准选其他选项，听到了吗？
\033[0m\n(⇀‸↼‶)"
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
            echo "One-Api已关闭, 即将返回主菜单喵~"
            cd ../
            ;; 
        2) 
            #安装酒馆
            echo ""> .bashrc
            echo -e "\033[0;36m确定要安装酒馆喵?\033[0m\n"
	    read -p "输入Y安装酒馆，或者按回车键返回喵~" choice
            case "$choice" in
   	    y|Y )
            curl -O https://mirror.ghproxy.com/https://raw.githubusercontent.com/YunZLu/termux_using_openai/main/CN/tisac.sh && chmod +x tisac.sh && ./tisac.sh;;
	    * )
            echo "你已选择不安装酒馆喵~";;
	    esac
            ;; 
        *) 
            echo -e "m9( ｀д´ )!!!! \n\033[0;36m坏猫猫居然不听话，存心和我喵喵~过不去是吧？\033[0m\n"
            ;;
    esac
done 
echo "已退出喵喵一键脚本，输入 bash only_oneapi_sac.sh 可重新进入脚本喵~"
exit

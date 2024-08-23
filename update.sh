#!/usr/bin/env bash

echo -e "\033[0;31m开魔法！开魔法！开魔法！\033[0m\n"
read -p "确保开了魔法后按回车继续"

while :
do 
read -p "确定要更新启动脚本为one-api版吗? (y/n)"choice

case "$choice" in
    y|Y )
        echo "启动脚本更新中..."
        rm -rf sac.sh
        curl -O https://raw.githubusercontent.com/YunZLu/termux_using_openai/main/sac.sh
        if [ ! -f "$current/root/sac.sh" ]; then
           echo "启动脚本下载失败了，换个魔法或者手动下载试试吧"
        else
           echo "更新启动脚本成功，正在退出"
           bash /root/sac.sh
        fi;;
    n|N )
        echo "你选择了不更新启动脚本，正在退出"
        break ;;
    * )
        echo "m9( ｀д´ )!!!!你选了个啥呀？要不要更新了！"
        ;;
esac
done 
echo "已退出喵喵一键脚本，输入 bash sac.sh 可重新进入脚本喵~"
exit

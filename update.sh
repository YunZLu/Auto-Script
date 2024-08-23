#!/usr/bin/env bash

echo -e "\033[0;31m开魔法！开魔法！开魔法！\033[0m\n"
read -p "确保开了魔法后按回车继续"

read -p "确定要更新脚本吗? (y/n)" choice

case "$choice" in
    y|Y )
        echo "脚本更新中..."
        rm -rf sac.sh
        curl -O https://raw.githubusercontent.com/YunZLu/termux_using_openai/main/sac.sh
        if [ ! -f "$current/root/sac.sh" ]; then
           echo "脚本下载失败了，换个魔法或者手动下载试试吧"
        else
           echo "更新脚本成功，正在退出"
        fi;;
    n|N )
        echo "不更新脚本，正在退出"
        exit;;
    * )
        echo "你选了个啥呀？到底更不更新了！"
        ;;
esac

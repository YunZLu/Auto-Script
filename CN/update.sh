#!/usr/bin/env bash

echo -e "\033[0;31m开魔法！开魔法！开魔法！\033[0m\n"
read -p "确保开了魔法后按回车继续"

read -p "确定要更新吗?输入Y更新，或者按回车键退出喵~" choice

case "$choice" in
    y|Y )
        echo "启动脚本更新中..."
        rm -rf sac.sh
        curl -O https://mirror.ghproxy.com/https://raw.githubusercontent.com/YunZLu/termux_using_openai/main/CN/sac.sh
        if [ ! -f "$current/root/sac.sh" ]; then
           echo "更新失败了，正在帮你重试喵~"
        else
           echo "更新成功，正在退出喵..."
           bash /root/sac.sh
        fi;;
   * )
        echo "你选择了不更新启动脚本，正在退出喵..."
        exit;;
esac

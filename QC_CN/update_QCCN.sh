#!/bin/bash

echo -e "\033[0;35m确定要更新吗?输入Y更新，或者按任意键退出喵~\033[0m"
read -s -n 1 choice
case "$choice" in
    y|Y )
        echo -e "\n\033[0;33m启动脚本更新中，请稍等一下喵...\n\033[0m"
        rm -rf /root/sac.sh
        cd /root
        curl -O https://mirror.ghproxy.com/https://raw.githubusercontent.com/YunZLu/termux_using_openai/main/QC_CN/sac.sh
        if [ ! -f "$current/root/sac.sh" ]; then
           echo -e "\n\033[0;31m更新失败了，正在帮你重试，请稍等一下喵~\n\033[0m"
        else
           echo -e "\n\033[0;32m更新成功，正在重新启动脚本喵...\n\033[0m"
           chmod 777 /root/sac.sh
           exec /root/sac.sh
        fi;;
   * )
        echo -e "\n\033[0;33m你选择了不更新启动脚本，正在重新启动脚本喵...\n\033[0m"
        bash /root/sac.sh
        exit;;
esac

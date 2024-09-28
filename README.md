2024.9.28  更新

新增QChatGPT版本功能：

1、NapCatQQ:接收和发送QQ消息

2、QChatGPT:通过NapCatQQ让QQ接入Claude等模型

2、MINIMAX_TTS：将酒馆接入MINIMAX_TTS语音服务

具体升级命令和配置教程查看腾讯文档：

【腾讯文档】喵喵一键脚本(QchatGPT版)部署教程
https://docs.qq.com/doc/DWnVzakZzTW16ekpN#

————————————————————————————————————————————

2024.8.28  更新

已更新国内代理版本，链接使用代理加速，不需要魔法！！！

只有 one-api 脚本命令（脚本内可升级安装酒馆）：

        curl -O https://mirror.ghproxy.com/https://raw.githubusercontent.com/YunZLu/termux_using_openai/main/CN/only_oneapi_tisac.sh && chmod +x only_oneapi_tisac.sh && ./only_oneapi_tisac.sh

酒馆 + one-api 脚本命令：
        
        curl -O https://mirror.ghproxy.com/https://raw.githubusercontent.com/YunZLu/termux_using_openai/main/CN/tisac.sh && chmod +x tisac.sh && ./tisac.sh

原已部署喵喵一键脚本的，先按0退出脚本，再执行命令：

        curl -O https://raw.githubusercontent.com/YunZLu/termux_using_openai/main/CN/update_CN.sh && chmod +x update_CN.sh && ./update_CN.sh
        

一、脚本介绍

基于喵喵一键脚本，因个人需要，仅增加one-api项目而修改的脚本

目前版本对应喵喵一键脚本v2.9.5

喵喵一键脚本项目：https://github.com/hopingmiao/termux_using_Claue

二、部署教程：

1.部署前准备：

（1）.稳定、稳定、稳定的魔法；

（2）.下载termux

推荐下载网站：

        https://f-droid.org/zh_Hans/packages/com.termux

建议下载推荐版本；

2.开始部署：

（1）.安装termux；

（2）.输入命令：

        curl -O https://raw.githubusercontent.com/YunZLu/termux_using_openai/main/tisac.sh && chmod +x tisac.sh && ./tisac.sh

（3）.按脚本提示安装；


三、原已部署喵喵一键脚本

1.输入0退出喵喵一键脚本;

2.输入命令：

        curl -O https://raw.githubusercontent.com/YunZLu/termux_using_openai/main/update.sh && chmod +x update.sh && ./update.sh

3.等待安装结束。


四、升级脚本（没有需求暂时不会考虑升级）

输入0退出脚本，再输入命令：

        bash updat.sh 
        
根据脚本提示即可完成升级.

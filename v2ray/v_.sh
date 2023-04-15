#!/bin/bash

# 检查系统类型
if [ -f /etc/os-release ]; then
    . /etc/os-release
    os_type=$ID
else
    echo "无法检测系统类型。"
    exit 1
fi

echo -e "\033[1;34m----------------------------------------\033[0m"
echo -e "\033[1m            系统信息\033[0m"
echo -e "\033[1;34m----------------------------------------\033[0m"
echo -e "操作系统: \033[1;33m$PRETTY_NAME\033[0m"
echo -e "\033[1;34m----------------------------------------\033[0m"

# 设置PID文件
pid_file="$HOME/v2ray.pid"

# 检查v2ray是否正在运行
if ! pgrep -x "v2ray" > /dev/null; then
    echo -e "\033[1;33mv2ray服务未运行。\033[0m"
    exit 1
fi

# 关闭v2ray服务
echo -e "\033[1m关闭v2ray服务...\033[0m"
v2ray_pid=$(pgrep -x "v2ray")
kill "$v2ray_pid"
rm "$pid_file"

unset http_proxy
unset https_proxy

# 检查v2ray服务是否已关闭
if ! pgrep -x "v2ray" > /dev/null; then
    echo -e "\033[1;34m----------------------------------------\033[0m"
    echo -e "\033[1;32mv2ray服务已关闭。\033[0m"
else
    echo -e "\033[1;34m----------------------------------------\033[0m"
    echo -e "\033[1;31m错误：v2ray服务未关闭。\033[0m"
    exit 1
fi

echo -e "\033[1;34m----------------------------------------\033[0m"


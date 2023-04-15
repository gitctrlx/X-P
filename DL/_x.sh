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

# 更新系统
if [ "$os_type" = "ubuntu" ] || [ "$os_type" = "debian" ]; then
    echo -e "\033[1;32m更新 apt...\033[0m"
    sudo apt update
    sudo apt upgrade
    echo -e "\033[1;32m安装编译工具...\033[0m"
    sudo apt install -y build-essential
elif [ "$os_type" = "centos" ] || [ "$os_type" = "rhel" ]; then
    echo -e "\033[1;32m更新 yum...\033[0m"
    sudo yum update
    sudo yum upgrade
    echo -e "\033[1;32m安装编译工具...\033[0m"
    sudo yum groupinstall -y "Development Tools"
else
    echo "不支持的系统类型。"
    exit 1
fi

# 检查是否已经安装了 conda
if command -v conda &>/dev/null; then
    echo -e "\033[1;33mConda 已经安装。\033[0m"
    read -p "是否要安装新的 Miniconda？[y/n]: " choice

    if [ "$choice" != "y" ]; then
        echo "跳过安装 Miniconda。"
        exit 0
    fi
fi

# 下载并安装最新版本的 Miniconda
echo -e "\033[1;32m下载并安装 Miniconda...\033[0m"
wget https://repo.anaconda.com/miniconda/Miniconda3-py38_23.1.0-1-Linux-x86_64.sh -O miniconda.sh
bash miniconda.sh -b -p $HOME/miniconda

# 检查环境变量是否已添加
if [[ ":$PATH:" != *":$HOME/miniconda/bin:"* ]]; then
    # 将 Miniconda 添加到 PATH
    echo -e "\033[1;32m添加 Miniconda 到 PATH...\033[0m"
    export PATH="$HOME/miniconda/bin:$PATH"
    echo 'export PATH="$HOME/miniconda/bin:$PATH"' >> ~/.bashrc
    source ~/.bashrc
else
    echo -e "\033[1;33mMiniconda 已在 PATH 中。\033[0m"
fi

rm miniconda.sh

# 初始化conda，重新启动 Bash 使环境变量生效
echo -e "\033[1;32mMiniconda 安装完成。\033[0m"
conda init
bash


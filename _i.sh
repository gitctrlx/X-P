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

# 添加仓库路径到环境变量
echo -e "\033[1;34m添加仓库路径到环境变量...\033[0m"
echo 'export PATH="$HOME/X:$PATH"' >> ~/.bashrc

# 重新加载 .bashrc 以立即应用更改
source ~/.bashrc

# 检查环境变量是否已更新
if [[ ":$PATH:" == *":$HOME/X:"* ]]; then
    echo -e "\033[1;32m环境变量已成功添加。\033[0m"
else
    echo -e "\033[1;31m错误：环境变量添加失败。\033[0m"
    exit 1
fi

# 为所有 .sh 脚本添加执行权限
echo -e "\033[1;34m为所有 .sh 脚本添加执行权限...\033[0m"
find "$HOME/X" -type f -iname "*.sh" -exec chmod +x {} \;

# 询问用户是否要检查所有 .sh 脚本的执行权限
read -p "是否要检查所有 .sh 脚本的执行权限？[y/n]: " check_permission
if [ "$check_permission" = "y" ]; then
    # 检查所有 .sh 脚本是否都具有执行权限
    all_executable=true
    for file in $(find "$HOME/X" -type f -iname "*.sh"); do
        if [[ ! -x "$file" ]]; then
            echo -e "\033[1;31m错误：文件 $file 没有执行权限。\033[0m"
            all_executable=false
        fi
    done

    if $all_executable; then
        echo -e "\033[1;32m所有 '.sh' 脚本已设置为可执行。\033[0m"
    else
        exit 1
    fi
fi

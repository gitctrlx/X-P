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

# 安装 unzip 和下载 v2ray
if ! command -v v2ray &>/dev/null; then
    echo -e "\033[1;32m安装 unzip...\033[0m"
    if [ "$os_type" = "ubuntu" ]; then
        sudo apt update
        sudo apt install -y unzip
    elif [ "$os_type" = "centos" ]; then
        sudo yum install -y unzip
    else
        echo "不支持的操作系统类型。"
        exit 1
    fi

    echo -e "\033[1;32m下载并解压 v2ray...\033[0m"
    if ! wget https://github.com/v2fly/v2ray-core/releases/latest/download/v2ray-linux-64.zip; then
        echo -e "\033[1;31m错误：v2ray 下载失败。\033[0m"
        exit 1
    fi
    mkdir -p $HOME/v2ray
    unzip v2ray-linux-64.zip -d $HOME/v2ray
    rm v2ray-linux-64.zip

    echo -e "\033[1;32m将 v2ray 添加到环境变量...\033[0m"
    export PATH="$HOME/v2ray:$PATH"
    echo 'export PATH="$HOME/v2ray:$PATH"' >> ~/.bashrc

    source ~/.bashrc
    echo -e "\033[1;32mv2ray 安装完成。\033[0m"
else
    echo -e "\033[1;33mv2ray 已经安装。\033[0m"
fi

source ~/.bashrc

# 设置配置文件所在的文件夹
config_dir="$HOME/X/config"

# 设置日志文件
log_file="$HOME/v2ray.log"

# 设置 PID 文件
pid_file="$HOME/v2ray.pid"

echo -e "\033[1;34m----------------------------------------\033[0m"
echo -e "\033[1;34m             V2Ray 控制脚本              \033[0m"
echo -e "\033[1;34m----------------------------------------\033[0m"

# 列出所有可用的配置文件
echo -e "\033[1m可用的配置文件：\033[0m"
ls -1 "$config_dir" | grep -E '^[0-9]+\.json$'

# 询问要使用的配置文件
echo -e "\033[1;34m----------------------------------------\033[0m"
read -p "请输入要使用的配置文件编号： " config_number

# 检查输入的配置文件是否存在
config_file="${config_dir}/${config_number}.json"
if [ ! -f "$config_file" ]; then
    echo -e "\033[1;31m错误：配置文件 ${config_file} 不存在。\033[0m"
    exit 1
fi

# 测试配置文件有效性
echo -e "\033[1;34m----------------------------------------\033[0m"
echo -e "\033[1m测试配置文件有效性：${config_file}\033[0m"
v2ray test -config "$config_file"
test_result=$?
if [ $test_result -ne 0 ]; then
    echo -e "\033[1;31m错误：配置文件 ${config_file} 无效。\033[0m"
    exit 1
fi

# 询问是否开启全局模式
echo -e "\033[1;34m----------------------------------------\033[0m"
read -p "是否开启全局模式？[y/n]: " global_mode
if [ "$global_mode" = "y" ]; then
    # 设置全局模式
    export http_proxy="http://127.0.0.1:10809"
    export https_proxy="http://127.0.0.1:10809"
    echo "全局模式已开启。"
else
    echo "全局模式未开启。"
fi

# 检查并开启 v2ray 服务端口
echo -e "\033[1;34m----------------------------------------\033[0m"
echo -e "\033[1m检查并开启 v2ray 服务端口...\033[0m"
proxy_port="10809" # 替换为您的 v2ray 代理端口

if [ "$os_type" = "ubuntu" ]; then
    sudo ufw status | grep "$proxy_port"
    if [ $? -ne 0 ]; then
        sudo ufw allow "$proxy_port"
        echo -e "\033[1;32m已开启 v2ray 服务端口：$proxy_port\033[0m"
    else
        echo -e "\033[1;33mv2ray 服务端口已开启：$proxy_port\033[0m"
    fi
    sudo ufw status
elif [ "$os_type" = "centos" ]; then
    sudo firewall-cmd --list-ports | grep "$proxy_port"
    if [ $? -ne 0 ]; then
        sudo firewall-cmd --permanent --add-port=${proxy_port}/tcp
        sudo firewall-cmd --permanent --add-port=${proxy_port}/udp
        sudo firewall-cmd --reload
        echo -e "\033[1;32m已开启 v2ray 服务端口：$proxy_port\033[0m"
    else
        echo -e "\033[1;33mv2ray 服务端口已开启：$proxy_port\033[0m"
    fi
    sudo firewall-cmd --list-all
else
echo -e "\033[1;31m错误：不支持的操作系统类型。\033[0m"
exit 1
fi


# 启动 v2ray
echo -e "\033[1;34m----------------------------------------\033[0m"
echo -e "\033[1m启动 v2ray 使用配置文件：${config_file}\033[0m"
nohup v2ray run -config "$config_file" > "$log_file" 2>&1 &

# 保存 v2ray 的进程 ID 到文件中
echo $! > "$pid_file"

# 输出提示信息
echo -e "\033[1;34m----------------------------------------\033[0m"
echo -e "\033[1;32mv2ray 已在后台启动。\033[0m"
echo ""
echo -e "您可以使用以下命令查看日志信息："
echo -e "\033[1mtail -f $log_file\033[0m"
echo ""
echo -e "如需停止 v2ray 服务，请运行以下命令："
echo -e "\033[1mkill $(cat $pid_file); rm $pid_file\033[0m"

# 运行测试 v2ray 是否生效
if pgrep -x "v2ray" > /dev/null; then
    echo -e "\033[1;34m----------------------------------------\033[0m"
    echo -e "\033[1;32mv2ray 服务正在运行。\033[0m"
else
    echo -e "\033[1;34m----------------------------------------\033[0m"
    echo -e "\033[1;31m错误：v2ray 服务未运行。\033[0m"
    exit 1
fi

proxy_port="10809" # 替换为您的 v2ray 代理端口
test_url="http://www.google.com" # 您可以选择一个可以通过代理访问的测试网址
echo -e "\033[1;34m----------------------------------------\033[0m"
echo -e "\033[1;32m正在测试 v2ray 代理服务...\033[0m"
if curl -s -x "http://127.0.0.1:${proxy_port}" --connect-timeout 5 "$test_url" > /dev/null; then
    echo -e "\033[1;32mv2ray 代理已生效。\033[0m"
else
    echo -e "\033[1;31m错误：v2ray 代理未生效。\033[0m"
    
    read -p "是否要关闭 v2ray 代理服务？[y/n]: " user_choice
    if [ "$user_choice" = "y" ]; then
        v2ray_pid=$(pgrep -x "v2ray")
        kill "$v2ray_pid"
        echo -e "\033[1;32mv2ray 服务已关闭。\033[0m"
    else
        echo -e "\033[1;33mv2ray 服务保持运行。\033[0m"
    fi
fi

echo -e "\033[1;34m----------------------------------------\033[0m"

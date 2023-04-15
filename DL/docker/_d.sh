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

function is_docker_installed() {
    if command -v docker &> /dev/null; then
        return 0
    else
        return 1
    fi
}

function show_docker_status() {
    echo "Docker 服务状态："
    sudo systemctl status docker --no-pager
}

function install_docker_ubuntu() {
    sudo apt-get remove docker docker-engine docker.io containerd runc
    sudo apt-get update
    sudo apt-get install \
        ca-certificates \
        curl \
        gnupg

    sudo mkdir -m 0755 -p /etc/apt/keyrings
    curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg
    echo \
      "deb [arch=\"$(dpkg --print-architecture)\" signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu \
      $(. /etc/os-release && echo \"$VERSION_CODENAME\") stable" | \
      sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

    sudo apt-get update
    sudo apt-get install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin
    sudo docker run hello-world

    #出书docker状态
    show_docker_status

    #检查docker是否启动
    if ! sudo systemctl is-active --quiet docker; then  
        echo "Docker服务未启动，正在尝试重启..."  
        sudo systemctl restart docker  
        show_docker_status  
    fi  
}

function install_docker_centos() {
    sudo yum remove docker \
                  docker-client \
                  docker-client-latest \
                  docker-common \
                  docker-latest \
                  docker-latest-logrotate \
                  docker-logrotate \
                  docker-engine
    sudo yum install -y yum-utils
    sudo yum-config-manager \
        --add-repo \
        https://download.docker.com/linux/centos/docker-ce.repo
    sudo yum install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin
    sudo systemctl start docker
    sudo docker run hello-world

    #出书docker状态
    show_docker_status

    #检查docker是否启动
    if ! sudo systemctl is-active --quiet docker; then  
        echo "Docker服务未启动，正在尝试重启..." 
        sudo systemctl restart docker  
        show_docker_status  
    fi
}

function uninstall_docker_ubuntu() {
    sudo apt-get purge docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin docker-ce-rootless-extras
    sudo rm -rf /var/lib/docker
    sudo rm -rf /var/lib/containerd
}

function uninstall_docker_centos() {
    sudo yum remove docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin docker-ce-rootless-extras
    sudo rm -rf /var/lib/docker
    sudo rm -rf /var/lib/containerd
}

if is_docker_installed; then
    echo "Docker 已安装。"
    show_docker_status
    echo "请选择操作："
    echo "1. 卸载 Docker"
    echo "2. 安装最新版 Docker"
    read -p "输入数字 (1 或 2)： " choice

    case $choice in
        1)
            if [ "$os_type" == "ubuntu" ]; then
                uninstall_docker_ubuntu
            elif [ "$os_type" == "centos" ]; then
                uninstall_docker_centos
            else
                echo "不支持的操作系统。"
                exit 1
            fi
            ;;
        2)
            if [ "$os_type" == "ubuntu" ]; then
                uninstall_docker_ubuntu
                install_docker_ubuntu
            elif [ "$os_type" == "centos" ]; then
                uninstall_docker_centos
                install_docker_centos
            else
                echo "不支持的操作系统。"
                exit 1
            fi
            ;;
        *)
            echo "输入错误，请输入 1 或 2。"
            exit 1
            ;;
    esac
else
    echo "Docker 未安装。"
    read -p "是否要安装 Docker？ (y/n)： " install_choice
    case $install_choice in
        y|Y)
            if [ "$os_type" == "ubuntu" ]; then
                install_docker_ubuntu
            elif [ "$os_type" == "centos" ]; then
                install_docker_centos
            else
                echo "不支持的操作系统。"
                exit 1
            fi
            ;;
        *)
            echo "未选择安装 Docker，退出。"
            exit 0
            ;;
    esac
fi

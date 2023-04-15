#!/bin/bash

#设置代理地址和端口
proxy_address="http://127.0.0.1:10809"

#显示当前的代理服务器配置
echo -e "\033[1;34m----------------------------------------\033[0m"
echo -e "\033[1m当前的代理服务器配置：\033[0m"
conda config --get proxy_servers.http
conda config --get proxy_servers.https

#设置 Conda 的代理服务器
echo -e "\033[1;34m----------------------------------------\033[0m"
echo -e "\033[1m已配置为新的代理服务器配置：\033[0m"
conda config --set proxy_servers.http "$proxy_address"
conda config --set proxy_servers.https "$proxy_address"

#显示设置后的代理服务器配置
echo -e "\033[1m新的代理服务器配置：\033[0m"
conda config --get proxy_servers.http
conda config --get proxy_servers.https

#执行 Conda 命令
echo -e "\033[1;34m----------------------------------------\033[0m"
echo -e "\033[1m执行 Conda 命令...\033[0m"
echo ""
conda "$@"

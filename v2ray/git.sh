#!/bin/bash

#设置代理地址和端口
proxy_address="http://127.0.0.1:10809"

#首先取消原来的可能设置的代理端口
git config --global --unset http.proxy
git config --global --unset https.proxy

#显示当前的代理服务器配置
echo -e "\033[1;34m----------------------------------------\033[0m"
echo -e "\033[1m当前的代理服务器配置：\033[0m"
git config --get http.proxy
git config --get https.proxy

#设置 Git 的代理服务器
echo -e "\033[1;34m----------------------------------------\033[0m"
echo -e "\033[1m已配置为新的代理服务器配置：\033[0m"
git config --global http.proxy "$proxy_address"
git config --global https.proxy "$proxy_address"

#显示设置后的代理服务器配置
echo -e "\033[1m新的代理服务器配置：\033[0m"
git config --get http.proxy
git config --get https.proxy

#执行 git 命令
echo -e "\033[1;34m----------------------------------------\033[0m"
echo -e "\033[1m执行 git 命令...\033[0m"
echo ""
git "$@"

#取消代理
echo -e "\033[1;34m----------------------------------------\033[0m"
echo -e "\033[1m正在取消代理...\033[0m"
git config --global --unset http.proxy
git config --global --unset https.proxy
echo "已取消 Git 代理设置。"

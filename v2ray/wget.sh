#!/bin/bash

# 设置代理地址和端口
proxy_address="http://127.0.0.1:10809"

# 通过代理执行 wget 命令
wget -e use_proxy=yes -e http_proxy="$proxy_address" -e https_proxy="$proxy_address" "$@"

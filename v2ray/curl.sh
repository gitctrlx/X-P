#!/bin/bash

# 设置代理地址和端口
proxy_address="http://127.0.0.1:10809"

# 通过代理执行 curl 命令
curl -x "$proxy_address" "$@" 

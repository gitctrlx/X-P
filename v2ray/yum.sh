#!/bin/bash

# 定义变量
config_file="/etc/yum.conf"
http_proxy_setting="proxy=http://127.0.0.1:10809"
https_proxy_setting="proxy=https://127.0.0.1:10809"
temp_file="/tmp/yum.conf.tmp"

# 向 yum 配置文件添加代理设置
add_proxy() {
    added=false
    if ! grep -q "$http_proxy_setting" "$config_file"; then
        echo "$http_proxy_setting" | sudo tee -a "$config_file" > /dev/null
        added=true
    fi

    if ! grep -q "$https_proxy_setting" "$config_file"; then
        echo "$https_proxy_setting" | sudo tee -a "$config_file" > /dev/null
        added=true
    fi

    if $added; then
        echo "代理设置已成功添加。"
    else
        echo "代理设置已存在，无需添加。"
    fi
}

# 从 yum 配置文件中删除代理设置
remove_proxy() {
    removed=false
    if grep -q "$http_proxy_setting" "$config_file"; then
        sudo grep -v "$http_proxy_setting" "$config_file" > "$temp_file"
        sudo mv "$temp_file" "$config_file"
        removed=true
    fi

    if grep -q "$https_proxy_setting" "$config_file"; then
        sudo grep -v "$https_proxy_setting" "$config_file" > "$temp_file"
        sudo mv "$temp_file" "$config_file"
        removed=true
    fi

    if $removed; then
        echo "代理设置已成功删除。"
    else
        echo "未找到代理设置，无需删除。"
    fi
}

# 主函数
main() {
    echo "请选择操作："
    echo "1. 将 V2Ray 代理端口添加到 yum 配置文件"
    echo "2. 从 yum 配置文件中删除 V2Ray 代理端口"
    read -p "输入选项 (1/2): " choice

    case $choice in
        1)
            add_proxy
            ;;
        2)
            remove_proxy
            ;;
        *)
            echo "输入错误，请重新运行脚本并输入正确的选项。"
            ;;
    esac
}

main

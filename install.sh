#!/bin/bash

# 安装Xcode Command Line Tools
# xcode-select --install

# 安装 Homebrew
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

# 解析配置并安装软件
while IFS='=' read -r key value; do
    if [[ $key == "name" ]]; then
        software_name=$value
    elif [[ $key == "cask" ]]; then
        software_cask=$value
    elif [[ $key == "config" ]]; then
        software_config=$value
    elif [[ $key == "config_file" ]]; then
        software_config_file=$value
        # 安装软件
        if [[ "$software_cask" == "true" ]]; then
            echo "正在安装 $software_name (cask)..."
            brew install --cask "$software_name"
        else
            echo "正在安装 $software_name..."
            brew install "$software_name"
        fi
        echo "$software_name 安装完成！"

        # 应用配置
        if [[ ! -z "$software_config" && ! -z "$software_config_file" ]]; then
            echo "应用配置：$software_config 到 $HOME/$software_config_file"
            echo "$software_config" >> "$HOME/$software_config_file"
        fi
        # 重置变量以读取下一段配置
        unset software_name software_cask software_config software_config_file
    fi
done < config.txt

echo "开发环境配置完成！"

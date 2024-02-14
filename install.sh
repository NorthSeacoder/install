#!/bin/bash

# 安装Xcode Command Line Tools
# xcode-select --install

# 安装 Homebrew
if ! command -v brew &> /dev/null; then
    echo "Homebrew 未安装，开始安装 Homebrew..."
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
else
    echo "Homebrew 已安装."
fi

# 安装软件函数
install_software() {
    local name="$1"
    local use_cask="$2"
    local config="$3"
    local config_file="$4"

    # 检查是否已安装
    if [[ "$use_cask" == "true" ]]; then
        if brew list --cask | grep -q "^$name\$"; then
            echo "$name (cask) 已安装，跳过..."
            return
        fi
    else
        if brew list | grep -q "^$name\$"; then
            echo "$name 已安装，跳过..."
            return
        fi
    fi

    # 安装软件
    if [[ "$use_cask" == "true" ]]; then
        echo "正在安装 $name (cask)..."
        brew install --cask "$name"
    else
        echo "正在安装 $name..."
        brew install "$name"
    fi
    echo "$name 安装完成！"

    # 应用配置
    if [[ -n "$config" && -n "$config_file" ]]; then
        echo "应用配置：$config 到 $HOME/$config_file"
        echo "$config" >> "$HOME/$config_file"
    fi
}

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
        install_software "$software_name" "$software_cask" "$software_config" "$software_config_file"
        # 重置变量以读取下一段配置
        unset software_name software_cask software_config software_config_file
    fi
done < list.txt

echo "开发环境配置完成！"

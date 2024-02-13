#!/bin/bash

# 设置脚本以在使用未定义变量时退出，增强脚本的健壮性。
set -u

# 安装 Homebrew
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

# 使用 Homebrew 安装常用软件
brew_install() {
    echo "正在安装 $1..."
    brew install $1
    echo "$1 安装完成！"
}

# 安装 Zsh 和 Oh My Zsh
brew_install zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"


# 安装 Git
brew_install git

# 安装 nvm (Node Version Manager)
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.1/install.sh | bash

# 初始化 NVM 和加载 NVM 脚本到当前会话
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# 安装 Node.js (最新LTS版本)
nvm install --lts
nvm use --lts

# 安装 nrm (Node Registry Manager)
npm install -g nrm

# 使用 nrm 切换至淘宝源，加快npm包的安装速度（可选）
nrm use taobao

# 安装 Visual Studio Code
brew install --cask visual-studio-code

# 安装其他软件（示例）
# brew install --cask google-chrome
# brew install --cask iterm2

# 扩展：安装其他任何需要的软件
# brew_install <软件名>
# brew install --cask <软件名>

echo "开发环境配置完成！"
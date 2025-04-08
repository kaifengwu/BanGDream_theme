#!/bin/bash

echo "📦 正在安装 Roselia 主题所需依赖..."

# 系统依赖
sudo apt update
sudo apt install -y imagemagick fish wezterm

# 检查是否安装成功
if ! command -v identify >/dev/null; then
  echo "❌ ImageMagick 安装失败，请手动安装"
fi

if ! command -v fish >/dev/null; then
  echo "❌ fish shell 安装失败，请手动安装"
fi

if ! command -v wezterm >/dev/null; then
  echo "❌ wezterm 安装失败，请手动安装"
fi

INSTALL_DIR="$(pwd)"

echo "📁 当前安装目录: $INSTALL_DIR"
echo "🔗 开始建立配置文件软链接..."

# 1. wezterm.lua
WEZTERM_TARGET="$HOME/.config/wezterm/wezterm.lua"
WEZTERM_SOURCE="$INSTALL_DIR/wezterm.lua"
mkdir -p "$(dirname "$WEZTERM_TARGET")"
ln -sf "$WEZTERM_SOURCE" "$WEZTERM_TARGET" && \
echo "✅ 已链接 wezterm.lua" || \
echo "❌ 失败: $WEZTERM_SOURCE -> $WEZTERM_TARGET"

# 2. Neovim Lua 模块 BanGDream/
NVIM_BDG_LUA_TARGET="$HOME/.config/nvim/lua/BanGDream"
NVIM_BDG_LUA_SOURCE="$INSTALL_DIR/BanGDream"
mkdir -p "$(dirname "$NVIM_BDG_LUA_TARGET")"
ln -sfn "$NVIM_BDG_LUA_SOURCE" "$NVIM_BDG_LUA_TARGET" && \
echo "✅ 已链接 Neovim 模块: BanGDream/" || \
echo "❌ 失败: $NVIM_BDG_LUA_SOURCE -> $NVIM_BDG_LUA_TARGET"

# 3. Neovim 主题 BanGDream_vim_theme/
NVIM_THEME_TARGET="$HOME/.config/nvim/themes/BanGDream_vim_theme"
NVIM_THEME_SOURCE="$INSTALL_DIR/BanGDream_vim_theme"
mkdir -p "$(dirname "$NVIM_THEME_TARGET")"
ln -sfn "$NVIM_THEME_SOURCE" "$NVIM_THEME_TARGET" && \
echo "✅ 已链接 Neovim 主题文件夹: BanGDream_vim_theme/" || \
echo "❌ 失败: $NVIM_THEME_SOURCE -> $NVIM_THEME_TARGET"

echo "🎉 所有配置链接已完成。"

INIT_VIM="$HOME/.config/nvim/init.vim"

echo "📝 准备将 Roselia 主题指令写入 $INIT_VIM"

# 要插入的配置内容
read -r -d '' ROSALIA_CONFIG << 'EOF'
" 主题设置
command! RoseliaTheme source ~/.config/nvim/themes/BanGDream_vim_theme/Roselia.vim
command! PoppinPartyTheme source ~/.config/nvim/themes/BanGDream_vim_theme/Poppin.vim
autocmd VimEnter * RoseliaTheme
autocmd VimEnter * call DisplayRoseliaLogo()
autocmd VimEnter * call RandomPickOnBufRead()
autocmd VimLeavePre * call RandomPickOnBufRead(1)
nnoremap <leader>c :call RandomPickOnBufRead(2)<CR>
EOF

# 检查是否已存在这些内容（用关键词判断）
if grep -q "RoseliaTheme" "$INIT_VIM"; then
  echo "✅ init.vim 中已包含 Roselia 配置，跳过插入"
else
  echo "🔧 插入 Roselia 配置到 $INIT_VIM"
  mkdir -p "$(dirname "$INIT_VIM")"
  echo "$ROSALIA_CONFIG" >> "$INIT_VIM"
  echo "✅ 插入完成"
fi

LUA_INIT="$HOME/.config/nvim/lua/init.lua"
LUA_LINE='require("BanGDream.Roselia")'

echo "📝 检查 Lua 初始化文件: $LUA_INIT"

# 如果已经包含目标行，则跳过
if grep -Fxq "$LUA_LINE" "$LUA_INIT" 2>/dev/null; then
  echo "✅ init.lua 已包含 BanGDream.Roselia，跳过插入"
else
  echo "🔧 插入 require 行到 init.lua"
  mkdir -p "$(dirname "$LUA_INIT")"
  echo "$LUA_LINE" >> "$LUA_INIT"
  echo "✅ 插入完成"
fi


echo "🖼️ 正在设置初始背景图和贴纸..."

INSTALL_DIR="$(pwd)"  # 安装目录
WEZTERM_DIR="$HOME/.config/wezterm"
mkdir -p "$WEZTERM_DIR"

# 设置背景图链接
BACKGROUND_DIR="$INSTALL_DIR/nvim/themes/BanGDream_vim_theme/Roselia_background"
BACKGROUND_TARGET="$WEZTERM_DIR/background.jpg"

FIRST_BG=$(find "$BACKGROUND_DIR" -type f | sort | head -n 1)

if [ -n "$FIRST_BG" ]; then
  ln -sf "$FIRST_BG" "$BACKGROUND_TARGET"
  echo "✅ 已链接背景图到: $(basename "$FIRST_BG")"
else
  echo "❌ 未找到背景图文件夹内容: $BACKGROUND_DIR"
fi

# 设置贴纸链接
STICKER_DIR="$INSTALL_DIR/nvim/themes/BanGDream_vim_theme/Roselia_sticker/Ako"
STICKER_TARGET="$WEZTERM_DIR/sticker.jpg"

FIRST_STICKER=$(find "$STICKER_DIR" -type f | sort | head -n 1)

if [ -n "$FIRST_STICKER" ]; then
  ln -sf "$FIRST_STICKER" "$STICKER_TARGET"
  echo "✅ 已链接贴纸图到: $(basename "$FIRST_STICKER")"
else
  echo "❌ 未找到贴纸图文件夹内容: $STICKER_DIR"
fi

mkdir -p ~/.local/share/fonts
cd ~/.local/share/fonts

wget https://github.com/ryanoasis/nerd-fonts/releases/download/v3.2.1/JetBrainsMono.zip -O JetBrainsMono.zip

if file JetBrainsMono.zip | grep -q "Zip archive data"; then
  unzip JetBrainsMono.zip
  rm JetBrainsMono.zip
  fc-cache -fv
  echo "✅ Nerd Font 安装成功"
else
  echo "❌ 下载的 JetBrainsMono.zip 不是有效的 zip 文件，请检查网络或链接"
  rm -f JetBrainsMono.zip
fi

echo "🌐 正在安装 WezTerm 终端..."

# 安装 WezTerm（适用于 Debian/Ubuntu 12 或以上版本）
WEZTERM_DEB="WezTerm-debian12.deb"
WEZTERM_URL="https://github.com/wez/wezterm/releases/latest/download/$WEZTERM_DEB"

# 下载 .deb 包
wget -O "$WEZTERM_DEB" "$WEZTERM_URL"

# 安装 .deb 包
if sudo apt install -y ./"$WEZTERM_DEB"; then
  echo "✅ WezTerm 安装成功"
  rm -f "$WEZTERM_DEB"
else
  echo "❌ WezTerm 安装失败，请检查网络或系统版本"
fi


echo "🛠️ 尝试设置 wezterm 为默认终端..."

# 检查 wezterm 是否已安装
if command -v wezterm >/dev/null 2>&1; then

  # 创建 wezterm.desktop 文件（如果它还没有注册）
  DESKTOP_FILE="$HOME/.local/share/applications/org.wezfurlong.wezterm.desktop"

  if [ ! -f "$DESKTOP_FILE" ]; then
    echo "📄 注册 wezterm.desktop 到本地应用目录"

    mkdir -p "$(dirname "$DESKTOP_FILE")"

    cat > "$DESKTOP_FILE" <<EOF
[Desktop Entry]
Name=WezTerm
Comment=GPU-accelerated terminal emulator
Exec=wezterm
Terminal=false
Type=Application
Categories=System;TerminalEmulator;
Icon=utilities-terminal
StartupNotify=true
EOF

    update-desktop-database ~/.local/share/applications
  fi

  # 设置默认 x-terminal-emulator（仅适用于 Ubuntu/Debian）
  sudo update-alternatives --install /usr/bin/x-terminal-emulator x-terminal-emulator /usr/bin/wezterm 100

  sudo update-alternatives --set x-terminal-emulator /usr/bin/wezterm

  echo "✅ 已设置 wezterm 为默认终端 (x-terminal-emulator)"
else
  echo "❌ wezterm 未安装，无法设置为默认终端"
fi


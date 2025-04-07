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
NVIM_BDG_LUA_SOURCE="$INSTALL_DIR/nvim/lua/BanGDream"
mkdir -p "$(dirname "$NVIM_BDG_LUA_TARGET")"
ln -sfn "$NVIM_BDG_LUA_SOURCE" "$NVIM_BDG_LUA_TARGET" && \
echo "✅ 已链接 Neovim 模块: BanGDream/" || \
echo "❌ 失败: $NVIM_BDG_LUA_SOURCE -> $NVIM_BDG_LUA_TARGET"

# 3. Neovim 主题 BanGDream_vim_theme/
NVIM_THEME_TARGET="$HOME/.config/nvim/themes/BanGDream_vim_theme"
NVIM_THEME_SOURCE="$INSTALL_DIR/nvim/themes/BanGDream_vim_theme"
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

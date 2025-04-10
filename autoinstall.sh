#!/bin/bash

echo "📦 正在安装 BanGDream 主题所需依赖..."

# 系统依赖
sudo apt update
sudo apt install -y imagemagick fish

# 检查是否安装成功
if ! command -v identify >/dev/null; then
  echo "❌ ImageMagick 安装失败，请手动安装"
fi

if ! command -v fish >/dev/null; then
  echo "❌ fish shell 安装失败，请手动安装"
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

echo "📝 准备将 BanGDream 主题指令写入 $INIT_VIM"

# 要插入的配置内容
read -r -d '' ROSALIA_CONFIG << 'EOF'
"BanGDream_Config
" ===== 🌟 BanGDream Theme Selector =====
let g:bangdream_theme = "Roselia"   " ← 可设为 Roselia,Poppin,Afterglow(设置为空则没有主题)

" 🌙 加载 BanGDream 模块
if g:bangdream_theme ==# 'Roselia'
  " 🌹 Roselia
  lua require("BanGDream.Roselia")
  command! RoseliaTheme source ~/.config/nvim/themes/BanGDream_vim_theme/Roselia/Roselia.vim
  autocmd VimEnter * RoseliaTheme
  autocmd VimEnter * call DisplayRoseliaLogo()
elseif g:bangdream_theme ==# 'Poppin'
  " ⭐ Poppin'Party
  lua require("BanGDream.Poppin")
  command! PoppinPartyTheme source ~/.config/nvim/themes/BanGDream_vim_theme/Poppin/Poppin.vim
  autocmd VimEnter * PoppinPartyTheme
  autocmd VimEnter * call DisplayPoppinLogo()
elseif g:bangdream_theme ==# 'Afterglow'
  " 🌇 Afterglow
  lua require("BanGDream.Afterglow")
  command! AfterglowTheme source ~/.config/nvim/themes/BanGDream_vim_theme/Afterglow/Afterglow.vim
  autocmd VimEnter * AfterglowTheme
  autocmd VimEnter * call DisplayAfterglowLogo()
endif


" 主题设置
if g:bangdream_theme ==# 'Roselia' || g:bangdream_theme ==# 'Poppin' || g:bangdream_theme ==# 'Afterglow'
	autocmd VimEnter * call RandomPickOnBufRead()
	autocmd VimLeavePre * call RandomPickOnBufRead(1)
	nnoremap <leader>c :call RandomPickOnBufRead(2)<CR>
endif
"BanGDream_Config_end
EOF

# 检查是否已存在这些内容（用关键词判断）
if grep -q "BanGDream_Config" "$INIT_VIM"; then
  echo "✅ init.vim 中已包含 BanGDream 配置，跳过插入"
else
  echo "🔧 插入 BanGDream 配置到 $INIT_VIM"
  mkdir -p "$(dirname "$INIT_VIM")"
  echo "$ROSALIA_CONFIG" >> "$INIT_VIM"
  echo "✅ 插入完成"
fi

echo "🖼️ 正在设置初始背景图和贴纸..."

INSTALL_DIR="$(pwd)"
WEZTERM_DIR="$HOME/.config/wezterm"
mkdir -p "$WEZTERM_DIR"

# 设置背景图链接
BACKGROUND_DIR="$INSTALL_DIR/BanGDream_vim_theme/Roselia/Roselia_background"
BACKGROUND_TARGET="$WEZTERM_DIR/background.jpg"
FIRST_BG=$(find "$BACKGROUND_DIR" -type f | sort | head -n 1)

if [ -n "$FIRST_BG" ]; then
  ln -sf "$FIRST_BG" "$BACKGROUND_TARGET"
  echo "✅ 已链接背景图到: $(basename "$FIRST_BG")"
else
  echo "❌ 未找到背景图文件夹内容: $BACKGROUND_DIR"
fi

# 设置贴纸链接
STICKER_DIR="$INSTALL_DIR/BanGDream_vim_theme/Roselia/Roselia_sticker/Ako"
STICKER_TARGET="$WEZTERM_DIR/sticker.jpg"
FIRST_STICKER=$(find "$STICKER_DIR" -type f | sort | head -n 1)

if [ -n "$FIRST_STICKER" ]; then
  ln -sf "$FIRST_STICKER" "$STICKER_TARGET"
  echo "✅ 已链接贴纸图到: $(basename "$FIRST_STICKER")"
else
  echo "❌ 未找到贴纸图文件夹内容: $STICKER_DIR"
fi

echo "🌐 正在下载安装 WezTerm AppImage..."

APPIMAGE_URL="https://github.com/wez/wezterm/releases/latest/download/WezTerm-linux-x86_64.AppImage"
APPIMAGE_PATH="$HOME/Downloads/WezTerm-linux-x86_64.AppImage"
LOCAL_BIN="$HOME/.local/bin"
WEZTERM_LINK="$LOCAL_BIN/wezterm"

mkdir -p "$LOCAL_BIN"

# 下载 AppImage（如未存在）
if [ -f "$APPIMAGE_PATH" ]; then
  echo "📦 AppImage 已存在，跳过下载"
else
  wget -O "$APPIMAGE_PATH" "$APPIMAGE_URL" || {
    echo "❌ 下载失败，请检查网络连接"
    exit 1
  }
fi

chmod +x "$APPIMAGE_PATH"
ln -sf "$APPIMAGE_PATH" "$WEZTERM_LINK"
echo "✅ WezTerm AppImage 安装完成，命令: wezterm"

# 检查 PATH
if ! echo "$PATH" | grep -q "$LOCAL_BIN"; then
  echo "🔧 未检测到 ~/.local/bin 在 PATH 中，尝试写入 ~/.bashrc"
  if ! grep -q "$LOCAL_BIN" "$HOME/.bashrc"; then
    echo "export PATH=\"$LOCAL_BIN:\$PATH\"" >> "$HOME/.bashrc"
    echo "✅ 已将 ~/.local/bin 添加至 PATH"
  fi
  export PATH="$LOCAL_BIN:$PATH"
fi

# 验证
if "$WEZTERM_LINK" --version >/dev/null 2>&1; then
  echo "🧪 WezTerm 版本: $($WEZTERM_LINK --version)"
else
  echo "❌ wezterm 执行失败，AppImage 可能有问题"
fi
mkdir -p ~/.local/share/fonts
cd ~/.local/share/fonts

# 如果已经存在 JetBrainsMono 字体就跳过
if ls JetBrainsMono-*.ttf >/dev/null 2>&1; then
  echo "✅ Nerd Font 已安装，跳过下载"
else
  echo "🌐 正在下载安装 JetBrainsMono Nerd Font..."

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
fi



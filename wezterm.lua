local wezterm = require 'wezterm'

--wezterm.on("window-config-reloaded", function(window, pane)
  --if window.toast_notification then
    --window:toast_notification(
      --"Roselia",
      --"🎤 湊 友希那\n🎸 氷川 紗夜\n🎹 白金 燐子\n🥁 宇田川 あこ\n 🎸 今井 リサ",
      --nil,
      --3
    --)
  --else
    --wezterm.log_info("toast_notification 不可用")
  --end
--end)
local config_path = os.getenv("HOME") .. "/.config/nvim/themes/BanGDream_vim_theme/sticker.conf"
local show_sticker, sticker_height, position_v, position_h

-- 读取文件内容
local lines = {}
-- trim 函数（去除前后空白）
local function trim(s)
  return s:match("^%s*(.-)%s*$")
end

-- split 函数
local function split(str, sep)
  local result = {}
  for s in string.gmatch(str, "([^" .. sep .. "]+)") do
    table.insert(result, s)
  end
  return result
end

-- 安全读取三行
local file = io.open(config_path, "r")
if file then
  for line in file:lines() do
    table.insert(lines, trim(line))
  end
  file:close()
end

local show_sticker = lines[1] == "true"
local sticker_height = lines[2] or "17%"
local pos = split(lines[3] or "Top Right", " ")
local vertical = pos[1] or "Top"
local horizontal = pos[2] or "Right"

return {
  font_size = 16.0,
  enable_tab_bar = false,

  
font = wezterm.font_with_fallback {
  "JetBrainsMono Nerd Font",
  --"Noto Sans CJK SC",       -- ✅ 中文 fallback
  "WenQuanYi Micro Hei",    -- 适用于 Linux
},

warn_about_missing_glyphs = false,



  -- 🌹 Roselia 官方配色风格
  colors = {
    foreground = "#DDDDFF",  -- 明亮字体
    background = "#1a1c2c",  -- 深夜背景，保持统一

    cursor_bg = "#881188",       -- 友希那紫
    cursor_border = "#881188",
    cursor_fg = "#1a1c2c",

    selection_bg = "#BBBBBB",    -- 燐子银白
    selection_fg = "#1a1c2c",
ansi = {
      "#1a1c2c", -- 黑（背景）
      "#DD2200", -- 红：莉莎
      "#00AABB", -- 绿：纱夜
      "#DD0088", -- 黄：亚子（近粉）
      "#3344AA", -- 蓝：Roselia
      "#881188", -- 紫：友希那
      "#66B2FF", -- 蓝：辅助高亮
      "#BBBBBB", -- 青：燐子
    },
brights = {
      "#1a1c2c", -- 黑（背景）
      "#DD2200", -- 红：莉莎
      "#00AABB", -- 绿：纱夜
      "#DD0088", -- 黄：亚子（近粉）
      "#AA44CC", -- 紫：友希那
      "#3344AA", -- 蓝：Roselia
      "#BBBBBB", -- 青：燐子
      "#66B2FF", -- 蓝：辅助高亮
    },
 
    --brights = {
      --"#333344", "#FF6655", "#33FFCC", "#FF66AA",
      --"#5566FF", "#AA44CC", "#66B2FF", "#FFFFFF",
    --},

    tab_bar = {
      background = "#1a1c2c",
      active_tab = {
        bg_color = "#3344AA", -- Roselia 主色
        fg_color = "#DDDDFF", -- 明亮字体
        intensity = "Bold",
      },
      inactive_tab = {
        bg_color = "#1a1c2c",
        fg_color = "#777799",
      },
      inactive_tab_hover = {
        bg_color = "#2a2c3c",
        fg_color = "#DDDDFF",
      },
      new_tab = {
        bg_color = "#1a1c2c",
        fg_color = "#888899",
      },
      new_tab_hover = {
        bg_color = "#2a2c3c",
        fg_color = "#ffffff",
        italic = true,
      },
    },
  },

  -- 🌸 其他 UI 设置
  window_padding = { left = 8, right = 8, top = 4, bottom = 4 },
  enable_scroll_bar = false,
  window_close_confirmation = "NeverPrompt",


  window_background_opacity = 1,
  background = {
  {
    source = {
      File = os.getenv("HOME") .. "/.config/wezterm/background.jpg"
    },
    opacity = 1,
    hsb = { brightness = 0.05 },
    attachment = "Fixed"
  },
{
    source = {
      File =  os.getenv("HOME") .. "/.config/wezterm/sticker.jpg"
    },
    opacity = (show_sticker and 1 or 0) * 0.9,
    width = "300px",
    attachment = "Fixed",
    hsb = { brightness = 1 },
    height = sticker_height,
    repeat_x = "NoRepeat",
    repeat_y = "NoRepeat",
    vertical_align = vertical, --Top,Middle,Bottom
    horizontal_align = horizontal, --Left,Center,Right
  },
},

}

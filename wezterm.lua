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



return {
  font_size = 16.0,


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
      "#3344AA", -- 蓝：Roselia
      "#AA44CC", -- 紫：友希那
      "#66B2FF", -- 蓝：辅助高亮
      "#BBBBBB", -- 青：燐子
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
      File = "/home/kaifeng/.config/wezterm/background.jpg"
    },
    opacity = 1,
    hsb = { brightness = 0.1 },
    attachment = "Fixed"
  },
{
    source = {
      File = "/home/kaifeng/my_wallpaper/meme/meme/e23628858e06988294fc31a84ca8bfd80e95d1de_raw.jpg"
    },
    opacity = 0,
    width = "10%",
    height = "17%",
    repeat_x = "NoRepeat",
    repeat_y = "NoRepeat",
    vertical_align = "Bottom",
    horizontal_align = "Center",
  },
},

}

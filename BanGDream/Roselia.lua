-- 浮窗持久缓存
_G.roselia_color_buf = nil
_G.roselia_color_win = nil
_G.roselia_last_hl_group = _G.roselia_last_hl_group or nil



-- 显示颜色贴纸浮窗
function _G.ShowRoseliaColor()
  local line = vim.fn.line(".")
  local col = vim.fn.col(".")
  local syn_id = vim.fn.synID(line, col, 1)
  local trans_id = vim.fn.synIDtrans(syn_id)
  local fg = vim.fn.synIDattr(trans_id, "fg#")

  local color_to_character = {
  ["#881188"] = "Yukina",
  ["#00aabb"] = "Sayo",
  ["#dd2200"] = "Lisa",
  ["#bbbbbb"] = "Rinko",
  ["#dd0088"] = "ako",
  ["Empty"] = "Roselia"
}

  local color_to_icon= {
  ["#881188"] = "🎤",
  ["#00aabb"] = "🎸",
  ["#dd2200"] = "🎸",
  ["#bbbbbb"] = "🎹",
  ["#dd0088"] = "🥁",
  ["Empty"] = "🌹"
}


  if fg == "" then
    fg = "Empty"
	character = "Roselia"
	icon = "🌹"
  else
    character = color_to_character[fg] or "Roselia"
    icon = color_to_icon[fg] or "🌹"
    fg = string.upper(fg)
  end 

  local msg = {
    "🎨: " .. fg,
    "🌹: ".. character .. icon,
  }

local roselia_colors = {
  ["#881188"] = { name = "Yukina", hl = "RoseliaYukina", hex = "#881188" },
  ["#00AABB"] = { name = "Sayo",   hl = "RoseliaSayo",   hex = "#00AABB" },
  ["#DD2200"] = { name = "Lisa",   hl = "RoseliaLisa",   hex = "#DD2200" },
  ["#BBBBBB"] = { name = "Rinko",  hl = "RoseliaRinko",  hex = "#BBBBBB" },
  ["#DD0088"] = { name = "Ako",    hl = "RoseliaAko",    hex = "#DD0088" },
  ["#A98AD8"] = { name = "Roselia",    hl = "Roselia",    hex = "#A98AD8" },
}
-- 提前注册所有高亮组
for _, info in pairs(roselia_colors) do
  vim.cmd(string.format("highlight! %s guifg=%s gui=bold", info.hl, info.hex))
end
local info = roselia_colors[fg]
local hl_group = info and info.hl

 -- ✅ 高亮组未变，直接 return，不更新浮窗
  if hl_group == _G.roselia_last_hl_group then
    return
  end
  _G.roselia_last_hl_group = hl_group
  -- 已存在浮窗则更新
  if _G.roselia_color_buf and vim.api.nvim_buf_is_valid(_G.roselia_color_buf)
    and _G.roselia_color_win and vim.api.nvim_win_is_valid(_G.roselia_color_win) then
    vim.api.nvim_buf_set_lines(_G.roselia_color_buf, 0, -1, false, msg)

	if hl_group then
    vim.defer_fn(function()
      vim.api.nvim_buf_add_highlight(_G.roselia_color_buf, -1, hl_group, 0, 6, -1)
      vim.api.nvim_buf_add_highlight(_G.roselia_color_buf, -1, hl_group, 1, 6, -1)
    end, 20)
    end
  else
  -- 新建浮窗
  local buf = vim.api.nvim_create_buf(false, true)
  vim.api.nvim_buf_set_lines(buf, 0, -1, false, msg)

  local win = vim.api.nvim_open_win(buf, false, {
    relative = "editor",
    anchor = "NE",
    row = 0,
    col = vim.o.columns,
    width = vim.fn.strdisplaywidth(msg[1]) + 4,
    height = #msg,
    border = "none",
    style = "minimal",
    focusable = false,
    noautocmd = true,
  })

  if hl_group then
      vim.api.nvim_buf_add_highlight(buf, -1, hl_group, 0, 6, -1)
      vim.api.nvim_buf_add_highlight(buf, -1, hl_group, 1, 6, -1)
  end

  _G.roselia_color_buf = buf
  _G.roselia_color_win = win
  end


  -- 路径映射配置（你可以自己改）
local base_path = os.getenv("HOME") .. "/.config/nvim/themes/BanGDream_vim_theme/Roselia_sticker"
local target_symlink = os.getenv("HOME") .. "/.config/wezterm/sticker.jpg"

-- 成员 -> 文件夹映射
local character_to_folder = {
  Yukina = "Yukina",
  Sayo   = "Sayo",
  Lisa   = "Lisa",
  Rinko  = "Rinko",
  ako    = "Ako"
}


local config_file = os.getenv("HOME") .. "/.config/nvim/themes/BanGDream_vim_theme/Roselia_sticker/sticker.conf"
-- 获取图片宽高
local function get_image_size(path, callback)
  vim.fn.jobstart({ "identify", "-format", "%w %h", path }, {
    stdout_buffered = true,
    on_stdout = function(_, data)
      if data and data[1] then
        local w, h = data[1]:match("(%d+)%s+(%d+)")
        if w and h then
          callback(tonumber(w), tonumber(h))
        end
      end
    end,
  })
end

-- 写入 sticker.conf 的第 2 行
local function update_sticker_height(height_percent)
  local lines = vim.fn.readfile(config_file)
  lines[2] = string.format("%.1f%%", height_percent)
  vim.fn.writefile(lines, config_file)
end


-- 如果匹配到了角色并存在对应文件夹
if character and character_to_folder[character] then
  local folder = base_path .. "/" .. character_to_folder[character]

  -- 获取该目录下所有图片
  local handle = io.popen('ls "' .. folder .. '"')
  local result = handle:read("*a")
  handle:close()

  local files = {}
  for line in string.gmatch(result, "[^\r\n]+") do
    table.insert(files, line)
  end

  if #files > 0 then
    -- 随机选择一张
    math.randomseed(os.time())
    local pick = files[math.random(#files)]
    local img_path = folder .. "/" .. pick

    -- 创建软链接
	get_image_size(img_path, function(w, h)
	local term_width = vim.fn.winwidth(0)
	local term_height = vim.fn.winheight(0)
	local term_aspect_ratio = term_width / term_height

	local height_percent = (h / w) * 10 * term_aspect_ratio


    update_sticker_height(height_percent) end)
    local cmd = { "ln", "-sf", img_path, target_symlink }
    vim.loop.spawn("ln", { args = { "-sf", img_path, target_symlink } }, function() end)
	vim.fn.jobstart({ "wezterm", "cli", "reload-config" }, { detach = true })
  end
end

end



vim.api.nvim_create_autocmd("CursorHold", {
  pattern = "*",
  callback = function()
    vim.schedule(function()
      _G.ShowRoseliaColor()
    end)
  end,
})


local M = {}

-- 🌹 贴纸开关配置文件路径
local config_file = vim.fn.expand("~/.config/nvim/themes/BanGDream_vim_theme/Roselia_sticker/sticker.conf")

-- 🌹 切换 sticker.conf 第一行 true/false
function M.toggle_sticker_enabled()
  local lines = {}
  if vim.fn.filereadable(config_file) == 1 then
    lines = vim.fn.readfile(config_file)
  end

  -- 如果文件为空，初始化为 false
  if #lines == 0 then
    lines = { "false" }
  end

  -- 切换状态
  local current = lines[1]
  if current == "true" then
    lines[1] = "false"
  else
    lines[1] = "true"
  end

  -- 写回文件
  vim.fn.writefile(lines, config_file)

  -- 🔄 刷新 wezterm 配置

  -- 提示
  vim.notify("🎭 贴纸开关切换为: " .. lines[1] .. "（已刷新 wezterm）", vim.log.levels.INFO)
  vim.fn.jobstart({ "wezterm", "cli", "reload-config" }, { detach = true })
end

-- 🌹 绑定快捷键 <leader>n
vim.keymap.set("n", "<leader>n", M.toggle_sticker_enabled, {
  desc = "切换 Roselia 贴纸开关",
  silent = true,
})

return M


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
  ["#881188"] = "Yukina🎤",
  ["#00aabb"] = "Sayo🎸",
  ["#dd2200"] = "Lisa🎸",
  ["#bbbbbb"] = "Rinko🎹",
  ["#dd0088"] = "ako🥁",
  ["Empty"] = "Roselia"
}

  if fg == "" then
    fg = "Empty"
	character = "Roselia"
  else
    character = color_to_character[fg] or "Roselia"
    fg = string.upper(fg)
  end 

  local msg = {
    "🎨: " .. fg,
    "🌹: ".. character,
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
    return
  end

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
vim.api.nvim_create_autocmd("CursorHold", {
  pattern = "*",
  callback = function()
    vim.schedule(function()
      _G.ShowRoseliaColor()
    end)
  end,
})

-- 浮窗持久缓存
_G.poppin_color_buf = nil
_G.poppin_color_win = nil
_G.poppin_last_hl_group = _G.poppin_last_hl_group or nil

-- 显示颜色贴纸浮窗
function _G.ShowPoppinColor()
	local line = vim.fn.line(".")
	local col = vim.fn.col(".")
	local syn_id = vim.fn.synID(line, col, 1)
	local trans_id = vim.fn.synIDtrans(syn_id)
	local fg = vim.fn.synIDattr(trans_id, "fg#")
	fg = string.upper(fg)

	local color_to_character = {
		["#FF5522"] = "Kasumi",
		["#0077DD"] = "Otae",
		["#FF55BB"] = "Rimi",
		["#AA66DD"] = "Arisa",
		["#FFCC11"] = "Saaya",
		["Empty"] = "Poppin\'Party"
	}

	local color_to_icon = {
		["#FF5522"] = "🎤",
		["#0077DD"] = "🎸",
		["#FF55BB"] = "🎸",
		["#AA66DD"] = "🎹",
		["#FFCC11"] = "🥁",
		["Empty"] = "⭐"
	}

	if fg == "" then
		fg = "Empty"
		character = "Poppin\'Party"
		icon = "⭐"
	else
		character = color_to_character[fg] or "Poppin\'Party"
		icon = color_to_icon[fg] or "⭐"
	end

	local msg = {
		"🎨: " .. fg,
		"⭐: " .. character .. icon,
	}

	local poppin_colors = {
		["#FF5522"] = { name = "Kasumi", hl = "PoppinKasumi", hex = "#FF5522" },
		["#0077DD"] = { name = "Otae", hl = "PoppinOtae", hex = "#0077DD" },
		["#FF55BB"] = { name = "Rimi", hl = "PoppinRimi", hex = "#FF55BB" },
		["#AA66DD"] = { name = "Arisa", hl = "PoppinArisa", hex = "#AA66DD" },
		["#FFCC11"] = { name = "Saaya", hl = "PoppinSaaya", hex = "#FFCC11" },
		["#FF3377"] = { name = "Poppin", hl = "Poppin", hex = "#FF3377" },
	}

	for _, info in pairs(poppin_colors) do
		vim.cmd(string.format("highlight! %s guifg=%s gui=bold", info.hl, info.hex))
	end

	local info = poppin_colors[fg]
	local hl_group = info and info.hl

	if hl_group == _G.poppin_last_hl_group then
		return
	end
	_G.poppin_last_hl_group = hl_group

	if _G.poppin_color_buf and vim.api.nvim_buf_is_valid(_G.poppin_color_buf)
		and _G.poppin_color_win and vim.api.nvim_win_is_valid(_G.poppin_color_win) then
		vim.api.nvim_buf_set_lines(_G.poppin_color_buf, 0, -1, false, msg)

		if hl_group then
			vim.defer_fn(function()
				vim.api.nvim_buf_add_highlight(_G.poppin_color_buf, -1, hl_group, 0, 6, -1)
				vim.api.nvim_buf_add_highlight(_G.poppin_color_buf, -1, hl_group, 1, 2, -1)
			end, 20)
		end
	else
		local buf = vim.api.nvim_create_buf(false, true)
		vim.api.nvim_buf_set_lines(buf, 0, -1, false, msg)

		local win = vim.api.nvim_open_win(buf, false, {
			relative = "editor",
			anchor = "NE",
			row = 0,
			col = vim.o.columns - 23,
			width = vim.fn.strdisplaywidth(msg[2]) + 8,
			height = #msg,
			border = "none",
			style = "minimal",
			focusable = false,
			noautocmd = true,
		})

		if hl_group then
			vim.api.nvim_buf_add_highlight(buf, -1, hl_group, 0, 6, -1)
			vim.api.nvim_buf_add_highlight(buf, -1, hl_group, 1, 2, -1)
		end

		_G.poppin_color_buf = buf
		_G.poppin_color_win = win
	end

	if not _G.poppin_sticker_enabled then
		return
	end

	local base_path = os.getenv("HOME") .. "/.config/nvim/themes/BanGDream_vim_theme/Poppin/Poppin_sticker"
	local target_symlink = os.getenv("HOME") .. "/.config/wezterm/sticker.jpg"

	local character_to_folder = {
		Kasumi = "Kasumi",
		Otae = "Otae",
		Rimi = "Rimi",
		Arisa = "Arisa",
		Saaya = "Saaya",
		["Poppin'Party"] = "Poppin"
}


	local config_file = os.getenv("HOME") .. "/.config/nvim/themes/BanGDream_vim_theme/sticker.conf"

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

	local function update_sticker_height(height_percent)
		local lines = vim.fn.readfile(config_file)
		lines[2] = string.format("%.1fpx", height_percent)
		vim.fn.writefile(lines, config_file)
	end

	if character and character_to_folder[character] then
		local folder = base_path .. "/" .. character_to_folder[character]

		local handle = io.popen('ls "' .. folder .. '"')
		local result = handle:read("*a")
		handle:close()

		local files = {}
		for line in string.gmatch(result, "[^\r\n]+") do
			table.insert(files, line)
		end

		if #files > 0 then
			math.randomseed(os.time())
			local pick = files[math.random(#files)]
			local img_path = folder .. "/" .. pick

			get_image_size(img_path, function(w, h)
				local term_width = vim.fn.winwidth(0)
				local term_height = vim.fn.winheight(0)
				local term_aspect_ratio = term_width / term_height
				local height_percent = (h / w) * 300 -- * term_aspect_ratio
				update_sticker_height(height_percent)
			end)

			vim.loop.spawn("ln", { args = { "-sf", img_path, target_symlink } }, function() end)
			vim.fn.jobstart({ "wezterm", "cli", "reload-config" }, { detach = true })
		end
	end
end

vim.api.nvim_create_autocmd("CursorHold", {
	pattern = "*",
	callback = function()
		vim.schedule(function()
			_G.ShowPoppinColor()
		end)
	end,
})

-- ⭐ 贴纸开关切换模块
local M = {}

local config_file = vim.fn.expand("~/.config/nvim/themes/BanGDream_vim_theme/sticker.conf")

do
	local init_lines = vim.fn.readfile(config_file)
	if #init_lines > 0 and init_lines[1] == "true" then
		_G.poppin_sticker_enabled = true
	else
		_G.poppin_sticker_enabled = false
	end
end

function M.toggle_sticker_enabled()
	local lines = {}
	if vim.fn.filereadable(config_file) == 1 then
		lines = vim.fn.readfile(config_file)
	end

	if #lines == 0 then
		lines = { "false" }
	end

	local current = lines[1]
	local switched = false

	if current == "true" then
		lines[1] = "false"
		_G.poppin_sticker_enabled = false
	else
		lines[1] = "true"
		_G.poppin_sticker_enabled = true
		switched = true
	end

	vim.fn.writefile(lines, config_file)

	vim.notify("🎭 贴纸开关切换为: " .. lines[1], vim.log.levels.INFO)

	-- ✅ 延迟一点点，确保上一行 writefile 完成后再 reload
	if switched then
		vim.defer_fn(function()
			vim.fn.jobstart({ "wezterm", "cli", "reload-config" }, { detach = true })
		end, 30)  -- 延迟 30ms
	end
end

function _G.reload_wezterm()
	vim.fn.jobstart({ "wezterm", "cli", "reload-config" }, {
		detach = true,
		on_exit = function(_, code)
			if code == 0 then
				vim.notify("✅ wezterm 配置已刷新")
			else
				vim.notify("❌ wezterm 刷新失败，退出码 " .. code, vim.log.levels.ERROR)
			end
		end
	})
end


vim.keymap.set("n", "<leader>n", function()
	-- 第一步：切换贴纸状态
	M.toggle_sticker_enabled()

	-- 第二步：延迟刷新 wezterm 配置
	vim.defer_fn(function()
		vim.fn.jobstart({ "wezterm", "cli", "reload-config", "--config-file", vim.fn.expand("~/.config/wezterm/wezterm.lua") }, { detach = true })
	end, 50)
end, {
	desc = "切换 Poppin 贴纸开关 + 刷新 wezterm",
	silent = true,
})

vim.api.nvim_create_autocmd("VimLeavePre", {
	callback = function()
		local config_file = vim.fn.expand("~/.config/nvim/themes/BanGDream_vim_theme/sticker.conf")
		local lines = vim.fn.readfile(config_file)
		if #lines == 0 then
			lines = { "false" }
		else
			lines[1] = "false"
		end
		vim.fn.writefile(lines, config_file)
	end,
})


return M


local M = {}

function M.format(component, text, hl_group)
	text = text:gsub("%%", "%%%%")
	if not hl_group or hl_group == "" then
		return text
	end
	component.hl_cache = component.hl_cache or {}
	local lualine_hl_group = component.hl_cache[hl_group]
	if not lualine_hl_group then
		local utils = require("lualine.utils.utils")
		local gui = vim.tbl_filter(function(x)
			return x
		end, {
			utils.extract_highlight_colors(hl_group, "bold") and "bold",
			utils.extract_highlight_colors(hl_group, "italic") and "italic",
		})

		lualine_hl_group = component:create_hl({
			fg = utils.extract_highlight_colors(hl_group, "fg"),
			gui = #gui > 0 and table.concat(gui, ",") or nil,
		}, "LV_" .. hl_group) --[[@as string]]
		component.hl_cache[hl_group] = lualine_hl_group
	end
	return component:format_hl(lualine_hl_group) .. text .. component:get_default_hl()
end

function M.pretty_path(opts)
	opts = vim.tbl_extend("force", {
		relative = "cwd",
		modified_hl = "MatchParen",
		directory_hl = "",
		filename_hl = "Bold",
		modified_sign = "",
		readonly_icon = " 󰌾 ",
		length = 3,
	}, opts or {})

	return function(self)
		local path = vim.fn.expand("%:p") --[[@as string]]
		if path == "" then
			return ""
		end
		path = vim.fs.normalize(path)

		-- root = the directory nvim was started in (cwd)
		local cwd = vim.fs.normalize(vim.uv.cwd() or vim.fn.getcwd())

		-- case-insensitive prefix match on Windows
		local cpath, ccwd = path, cwd
		if cpath:find(ccwd, 1, true) == 1 then
			path = path:sub(#cwd + 2)
		end

		local sep = package.config:sub(1, 1)
		local parts = vim.split(path, "[\\/]")

		if opts.length ~= 0 and #parts > opts.length then
			parts = { parts[1], "…", unpack(parts, #parts - opts.length + 2, #parts) }
		end

		if opts.modified_hl and vim.bo.modified then
			parts[#parts] = parts[#parts] .. opts.modified_sign
			parts[#parts] = M.format(self, parts[#parts], opts.modified_hl)
		else
			parts[#parts] = M.format(self, parts[#parts], opts.filename_hl)
		end

		local dir = ""
		if #parts > 1 then
			dir = table.concat({ unpack(parts, 1, #parts - 1) }, sep)
			dir = M.format(self, dir .. sep, opts.directory_hl)
		end

		local readonly = ""
		if vim.bo.readonly then
			readonly = M.format(self, opts.readonly_icon, opts.modified_hl)
		end

		return dir .. parts[#parts] .. readonly
	end
end

function M.get_lsps()
	local buf = vim.api.nvim_get_current_buf()
	local clients = vim.lsp.get_clients({ bufnr = buf })
	if #clients == 0 then
		return ""
	end
	local names = {}
	for _, client in ipairs(clients) do
		if client.name ~= "null-ls" and client.name ~= "none-ls" and client.name ~= "efm" then
			names[#names + 1] = client.name
		end
	end
	return table.concat(names, "|")
end

return M

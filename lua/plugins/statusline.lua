return {
	{
		"nvim-lualine/lualine.nvim",
		dependencies = {
			"nvim-tree/nvim-web-devicons",
		},

		config = function()
			require("lualine").setup({
				options = {
					icons_enabled = true,
					component_separators = { left = "", right = "|" },
					section_separators = { left = "", right = "" },
					theme = "tokyonight",
				},
				sections = {
					lualine_a = { "mode" },
					lualine_b = { { "branch", icon = "" } },
					lualine_c = {
						{
							"diagnostics",
							symbols = {
								error = " ",
								warn = " ",
								hint = " ",
								info = " ",
							},
						},
						{ "filetype", icon_only = true, separator = "", padding = { left = 1, right = 0 } },
						{ "filename", path = 1 },
					},
					lualine_x = {
						{
							"diff",
							symbols = {
								added = " ",
								modified = " ",
								removed = " ",
							},
						},
					},
					lualine_y = {
						{
							function()
								local enc = (vim.bo.fenc ~= "" and vim.bo.fenc) or vim.o.enc
								if enc and enc:lower() ~= "utf-8" then
									return enc
								end
								return ""
							end,
							draw_empty = true,
						},
					},
					lualine_z = {
						{ "progress", separator = " ", padding = { left = 1, right = 0 } },
						{ "location", padding = { left = 0, right = 1 } },
					},
				},
			})
		end,
	},
}

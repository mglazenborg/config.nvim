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
					lualine_b = { "diff", "diagnostics" },
					lualine_c = { { "filename", path = 1 } },
					lualine_x = { "filetype", "encoding" },
				},
			})
		end,
	},
}

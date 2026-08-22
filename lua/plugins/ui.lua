return {
	{
		"nvim-lualine/lualine.nvim",
		dependencies = {
			"folke/tokyonight.nvim",
		},

		config = function()
			local icons = require("config.icons")
			local util = require("util.lualine")

			require("lualine").setup({
				options = {
					theme = "tokyonight",
					component_separators = { left = "", right = "|" },
					section_separators = { left = "", right = "" },
				},
				sections = {
					lualine_a = { "mode" },
					lualine_b = { { "branch", icon = icons.git.branch } },
					lualine_c = {
						{
							"diagnostics",
							symbols = {
								error = icons.diagnostics.error,
								warn = icons.diagnostics.warn,
								hint = icons.diagnostics.hint,
								info = icons.diagnostics.info,
							},
						},
						{ "filetype", icon_only = true, separator = "", padding = { left = 1, right = 0 } },
						{ util.pretty_path(), padding = { left = 0, right = 1 } },
					},
					lualine_x = {
						{
							require("lazy.status").updates,
							cond = require("lazy.status").has_updates,
						},
						{
							"diff",
							symbols = {
								added = icons.git.Added,
								modified = icons.git.Modified,
								removed = icons.git.Removed,
							},
							source = function()
								local gitsigns = vim.b.gitsigns_status_dict
								if gitsigns then
									return {
										added = gitsigns.added,
										modified = gitsigns.changed,
										removed = gitsigns.removed,
									}
								end
							end,
						},
					},
					lualine_y = {
						{ util.get_lsps, icon = "󰣖" },
					},
					lualine_z = {
						{ "progress", separator = " ", padding = { left = 1, right = 0 } },
						{ "location", padding = { left = 0, right = 1 } },
					},
				},
			})
		end,
	},

	{
		"nvim-mini/mini.icons",
		lazy = true,
		opts = {
			file = {
				[".keep"] = { glyph = "󰊢", hl = "MiniIconsGrey" },
				["devcontainer.json"] = { glyph = "", hl = "MiniIconsAzure" },
			},
			filetype = {
				dotenv = { glyph = "", hl = "MiniIconsYellow" },
			},
		},
		init = function()
			package.preload["nvim-web-devicons"] = function()
				require("mini.icons").mock_nvim_web_devicons()
				return package.loaded["nvim-web-devicons"]
			end
		end,
	},

	{
		"folke/snacks.nvim",
		lazy = false,
		opts = {
			statuscolumn = {
				enabled = true,
				left = { "mark", "sign" },
				right = { "fold", "git" },
				folds = {
					open = true,
					git_hl = true,
				},
				refresh = 50,
			},
		},
	},
}

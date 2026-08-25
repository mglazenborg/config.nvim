return {
	{
		"folke/tokyonight.nvim",
		lazy = false,
		opts = {},
		config = function()
			require("tokyonight").setup({
				transparent = true,
				styles = {
					floats = "transparent",
				},
				on_colors = function() end,
				on_highlights = function(hl, c)
					hl.BlinkCmpMenu = { bg = c.bg_dark }
					hl.BlinkCmpMenuBorder = { bg = c.bg_dark, fg = c.bg_dark }
					hl.BlinkCmpDoc = { bg = c.bg_dark }
					hl.BlinkCmpDocBorder = { bg = c.bg_dark, fg = c.bg_dark }
					hl.BlinkCmpSignatureHelp = { bg = c.bg_dark }
					hl.BlinkCmpSignatureHelpBorder = { bg = c.bg_dark, fg = c.bg_dark }
				end,
			})
			require("tokyonight").load()
		end,
	},
}

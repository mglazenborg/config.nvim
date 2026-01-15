return {
	{
		"nvim-mini/mini.pairs",

		config = function()
			require("mini.pairs").setup({})
		end,
	},
	{
		"folke/snacks.nvim",
		priority = 1000,
		lazy = false,

		config = function()
			require("snacks").setup({
				indent = {
					indent = {
						enabled = true,
					},
					animate = {
						enabled = false,
					},
				},
			})
		end,
	},
	{
		"folke/lazydev.nvim",
		ft = "lua",
		opts = {
			library = {
				{ path = "${3rd}/luv/library", words = { "vim%.uv" } },
			},
		},
	},
}

return {
	"neovim/nvim-lspconfig",
	dependencies = {
		{ "j-hui/fidget.nvim", opts = {} },
		{ "saghen/blink.cmp", version = "1.x" },

		"mason-org/mason.nvim",
		"mason-org/mason-lspconfig.nvim",
		"stevearc/conform.nvim",
		"b0o/SchemaStore.nvim",
	},

	config = function()
		require("conform").setup({
			formatters_by_ft = {},
		})

		require("fidget").setup({
			notification = {
				window = { winblend = 0 },
			},
		})

		require("mason").setup()
		require("mason-lspconfig").setup({
			ensure_installed = {
				"lua_ls",
				"gopls",
			},
		})

		require("blink.cmp").setup({
			completion = {
				menu = { border = "single" },
				documentation = { auto_show = true, window = { border = "single" } },
			},
			signature = { enabled = true, window = { border = "single" } },
		})

		vim.diagnostic.config({
			virtual_text = true,
		})
	end,
}

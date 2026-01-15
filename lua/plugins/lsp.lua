return {
	"neovim/nvim-lspconfig",
	dependencies = {
		{ "j-hui/fidget.nvim", opts = {} },
		{ "saghen/blink.cmp", version = "1.x" },
		{
			"L3MON4D3/LuaSnip",
			version = "v2.x",
			dependencies = {
				"rafamadriz/friendly-snippets",
			},
		},

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

		require("luasnip.loaders.from_vscode").lazy_load()
		require("blink.cmp").setup({
			sources = {
				default = { "lsp", "snippets", "path" },
			},
			snippets = { preset = "luasnip" },
			completion = {
				menu = { border = "single" },
				documentation = { auto_show = true, window = { border = "single" } },
				ghost_text = { enabled = true },
			},
			signature = { enabled = true, window = { border = "single" } },
		})

		vim.diagnostic.config({
			virtual_text = true,
			signs = {
				text = {
					[vim.diagnostic.severity.ERROR] = " ",
					[vim.diagnostic.severity.WARN] = " ",
					[vim.diagnostic.severity.HINT] = " ",
					[vim.diagnostic.severity.INFO] = " ",
				},
			},
		})
	end,
}

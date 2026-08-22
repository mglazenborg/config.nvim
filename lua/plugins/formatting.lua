return {
	{
		"stevearc/conform.nvim",
		dependencies = { "mason-org/mason.nvim" },
		event = { "BufWritePre" },
		cmd = "ConformInfo",
		keys = {
			{
				"<leader>cf",
				function()
					require("conform").format({ async = true })
				end,
				mode = { "n", "v" },
				desc = "Format buffer",
			},
		},
		opts = {
			default_format_opts = {
				timeout_ms = 3000,
				lsp_format = "fallback",
			},
			format_on_save = {
				timeout_ms = 3000,
				lsp_format = "fallback",
			},
			formatters_by_ft = {
				lua = { "stylua" },
				sh = { "shfmt" },
				qml = { "qmlformat" },
			},
			formatters = {
				injected = { options = { ignore_errors = true } },
				qmlformat = {
					command = "/usr/lib/qt6/bin/qmlformat",
					prepend_args = { "-w", "2" },
				},
			},
		},
	},
}

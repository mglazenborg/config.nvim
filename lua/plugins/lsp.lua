return {
	{
		"neovim/nvim-lspconfig",
		event = { "BufReadPre", "BufNewFile" },
		dependencies = {
			"mason-org/mason.nvim",
			"mason-org/mason-lspconfig.nvim",
		},
		config = function()
			local icons = require("config.icons")

			vim.diagnostic.config({
				underline = true,
				update_in_insert = false,
				severity_sort = true,
				virtual_text = { spacing = 4, source = "if_many", prefix = "●" },
				signs = {
					text = {
						[vim.diagnostic.severity.ERROR] = icons.diagnostics.error,
						[vim.diagnostic.severity.WARN] = icons.diagnostics.warn,
						[vim.diagnostic.severity.HINT] = icons.diagnostics.hint,
						[vim.diagnostic.severity.INFO] = icons.diagnostics.info,
					},
				},
			})

			vim.lsp.config("lua_ls", {
				settings = {
					Lua = {
						workspace = { checkThirdParty = false },
						codeLens = { enable = true },
						completion = { callSnippet = "Replace" },
						doc = { privateName = { "^_" } },
						hint = {
							enable = true,
							setType = false,
							paramType = true,
							paramName = "Disable",
							semicolon = "Disable",
							arrayIndex = "Disable",
						},
					},
				},
			})

			require("mason-lspconfig").setup({
				automatic_enable = true,
				ensure_installed = {
					"lua_ls",
				},
			})

			vim.api.nvim_create_autocmd("LspAttach", {
				callback = function(ev)
					local builtin = require("telescope.builtin")
					local buf = ev.buf
					local client = vim.lsp.get_client_by_id(ev.data.client_id)

					local function map(lhs, rhs, desc, opts, mode)
						vim.keymap.set(
							mode or "n",
							lhs,
							rhs,
							vim.tbl_extend("force", { buf = buf, desc = "LSP: " .. desc }, opts or {})
						)
					end

					map("gd", function()
						builtin.lsp_definitions({ reuse_win = true })
					end, "Goto Definition")
					map("gr", function()
						builtin.lsp_references()
					end, "References", { nowait = true })
					map("gI", function()
						builtin.lsp_implementations({ reuse_win = true })
					end, "Goto Implementation")
					map("gy", function()
						builtin.lsp_type_definitions({ reuse_win = true })
					end, "Goto T[y]pe Definition")

					map("<leader>ca", vim.lsp.buf.code_action, "Code Action", nil, { "n", "x" })
					map("<leader>cc", vim.lsp.codelens.run, "Run Codelens")
					map("<leader>cr", vim.lsp.buf.rename, "Rename")

					-- Enable inlay hints if LSP supports it
					if
						client
						and client:supports_method("textDocument/inlayHint", buf)
						and vim.bo[buf].buftype == ""
					then
						vim.lsp.inlay_hint.enable(true, { bufnr = buf })
					end

					-- Enable Codelens if LSP supports it
					if client and client:supports_method("textDocument/codeLens", buf) then
						vim.lsp.codelens.enable(true, { bufnr = buf })
					end
				end,
			})
		end,
	},

	{
		"mason-org/mason.nvim",
		cmd = "Mason",
		keys = { { "<leader>cm", "<cmd>Mason<cr>", desc = "Mason" } },
		build = ":MasonUpdate",
		opts = {
			ensure_installed = {
				"stylua",
				"shfmt",
			},
			ui = { border = "single" },
		},
		config = function(_, opts)
			require("mason").setup(opts)
			local mr = require("mason-registry")
			mr.refresh(function()
				for _, tool in ipairs(opts.ensure_installed) do
					local p = mr.get_package(tool)
					if not p:is_installed() then
						p:install()
					end
				end
			end)
		end,
	},
}

return {
	"nvim-treesitter/nvim-treesitter",
	lazy = false,
	build = ":TSUpdate",

	config = function()
		require("nvim-treesitter").install({
			"bash",
			"diff",
			"lua",
			"luadoc",
			"markdown",
			"markdown_inline",
			"vim",
			"vimdoc",
			"terraform",
			"hcl",
			"yaml",
			"go",
			"gomod",
			"gowork",
			"gosum",
		})

		vim.api.nvim_create_autocmd("FileType", {
			group = vim.api.nvim_create_augroup("treesitter", { clear = true }),
			callback = function(args)
				local bufnr = args.buf
				local ok, parser = pcall(vim.treesitter.get_parser, bufnr)
				if not ok or not parser then
					return
				end
				pcall(vim.treesitter.start)
			end,
		})
	end,
}

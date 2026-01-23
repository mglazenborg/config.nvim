return {
	"MeanderingProgrammer/render-markdown.nvim",
	opts = {},

	config = function()
		require("render-markdown").setup({
			render_modes = {},
		})

		vim.keymap.set("n", "<leader>md", function()
			require("render-markdown").preview()
		end)
	end,
}

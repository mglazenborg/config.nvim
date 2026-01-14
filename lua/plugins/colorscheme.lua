function BobRoss(color)
	color = color or "tokyonight"
	vim.cmd.colorscheme(color)
end

return {
	{
        "folke/tokyonight.nvim",
        lazy = false,
        opts = {},
        config = function()
		require("tokyonight").setup({
			transparent = true,
			styles = {
				sidebars = "transparent",
				floats = "transparent",
			},
		})
            BobRoss()
        end
    },
}

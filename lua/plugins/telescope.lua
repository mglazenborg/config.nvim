return {
    "nvim-telescope/telescope.nvim", tag = "v0.2.1",
    dependencies = {
        { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },

        "nvim-lua/plenary.nvim",
    },

    config = function()
        require("telescope").setup({})

        local builtin = require("telescope.builtin")
        vim.keymap.set("n", "<leader>fd", builtin.find_files, {})   -- Find
        vim.keymap.set("n", "<leader>gw", builtin.grep_string, {})  -- Grep Word
        vim.keymap.set("n", "<leader>fg", builtin.live_grep, {})    -- Find Grep
        vim.keymap.set("n", "<leader>fh", builtin.help_tags, {})    -- Find Help

        -- OLD BINDINGS
        -- vim.keymap.set("n", "<leader>sf", builtin.find_files, {})   -- Search Files
        -- vim.keymap.set("n", "<leader>sw", builtin.grep_string, {})  -- Search Word (under cursor)
        -- vim.keymap.set("n", "<leader>sg", builtin.live_grep, {})    -- Search Grep
        -- vim.keymap.set("n", "<leader>sh", builtin.help_tags, {})    -- Search Help
    end,
}

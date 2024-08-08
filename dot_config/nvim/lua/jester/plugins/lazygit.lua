return {
    { 
        "kdheepak/lazygit.nvim",
        opts = {},
        dependencies = {
            "nvim-lua/plenary.nvim",
        },
        config = function()
            vim.keymap.set("n", "<leader>gg", "<CMD>LazyGit<CR>")
        end,
    },
}

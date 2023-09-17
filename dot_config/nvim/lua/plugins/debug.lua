return {
    {
        "mfussenegger/nvim-dap",
        keys = {
            { "<leader>db", "<cmd>lua require'dap'.toggle_breakpoint()<CR>", desc = "Debug breakpoint" },
            { "<leader>dn", "<cmd>lua require'dap'.continue()<CR>", desc = "Debug continue"},
            { "<leader>ds", "<cmd>lua require'dap'.step_over()<CR>", desc = "Debug step over"},
            { "<leader>di", "<cmd>lua require'dap'.step_into()<CR>", desc = "Debug step into"},
            { "<leader>do", "<cmd>lua require'dap'.step_out()<CR>", desc = "Debug step into"},
            { "<leader>dc", "<cmd>lua require'dap'.clear_breakpoints()<CR>", desc = "Clear debug breakpoints"},
        },
    },
    {
        "nvim-telescope/telescope-dap.nvim",
        dependencies = {
            "mfussenegger/nvim-dap",
            "nvim-telescope/telescope.nvim",
            "nvim-treesitter/nvim-treesitter",
        },
        config = function()
            require('telescope').load_extension('dap')
            vim.keymap.set("n", "<leader>dl", require'telescope'.extensions.dap.list_breakpoints)
        end,
    },
    {
        "rcarriga/nvim-dap-ui",
        dependencies = {"mfussenegger/nvim-dap"},
        keys = {
            { "<leader>du", "<cmd>lua require'dapui'.toggle()<CR>", desc = "Toggle DAP UI"},
        },
        config = function()
            require("dapui").setup()
        end,
    },
    {
        "theHamsta/nvim-dap-virtual-text",
        config = function()
            require("nvim-dap-virtual-text").setup()
        end,
    },
    {
        "mfussenegger/nvim-dap-python",
        config = function()
            require('dap-python').setup()
        end,
    },
}

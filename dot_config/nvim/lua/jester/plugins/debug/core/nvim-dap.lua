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
}

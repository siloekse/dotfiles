return {
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
}

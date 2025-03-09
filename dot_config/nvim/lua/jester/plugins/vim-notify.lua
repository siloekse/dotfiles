return {
    { 
        "rcarriga/nvim-notify",
        opts = {},
        config = function()
            vim.notify = require("notify")
            vim.notify.setup{
                render = "compact",
                background_colour = "#000000",
            }
        end,
    },
}

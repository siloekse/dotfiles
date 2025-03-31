return {
    {
        'VonHeikemen/lsp-zero.nvim',
        branch = 'v4.x',
        dependencies = {
            -- LSP Support
            { 'neovim/nvim-lspconfig' },
            {'williamboman/mason.nvim'},
            {'williamboman/mason-lspconfig.nvim'},

            -- Autocompletion
            {
                'neovim/nvim-lspconfig',
                dependencies = { 'saghen/blink.cmp' },

                -- example using `opts` for defining servers
                opts = {
                    servers = {
                        lua_ls = {}
                    }
                },
                config = function(_, opts)
                    local lspconfig = require('lspconfig')
                    for server, config in pairs(opts.servers) do
                        -- passing config.capabilities to blink.cmp merges with the capabilities in your
                        -- `opts[server].capabilities, if you've defined it
                        config.capabilities = require('blink.cmp').get_lsp_capabilities(config.capabilities)
                        lspconfig[server].setup(config)
                    end
                end

            },

            -- Language servers
            {'ranjithshegde/ccls.nvim'},

            -- Format code
            {'lukas-reineke/lsp-format.nvim'},
        },
        config = function()
            require("mason").setup()
            require("mason-lspconfig").setup({
                ensure_installed = {
                    'pyright',
                    'ruff',
                    'clangd',
                    'zls',
                    -- 'rust_analyzer',
                },
            })

            local lsp = require("lsp-zero")

            require("lsp-format").setup {}

            lsp.on_attach(function(client, bufnr)
                local opts = {buffer = bufnr, remap = false}
                local builtin = require('telescope.builtin')

                vim.keymap.set('n', 'gd', builtin.lsp_definitions, opts)
                vim.keymap.set("n", "gi", builtin.lsp_implementations, opts)
                vim.keymap.set('n', 'gr', builtin.lsp_references, opts)
                vim.keymap.set("n", "K", function() vim.lsp.buf.hover() end, opts)
                vim.keymap.set("n", "<leader>ht", function() vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled()) end, opts)
                vim.keymap.set("n", "<leader>vws", function() vim.lsp.buf.workspace_symbol() end, opts)
                vim.keymap.set("n", "<leader>vd", function() vim.diagnostic.open_float() end, opts)
                vim.keymap.set("n", "[d", function() vim.diagnostic.goto_next() end, opts)
                vim.keymap.set("n", "]d", function() vim.diagnostic.goto_prev() end, opts)
                vim.keymap.set("n", "<leader>vca", function() vim.lsp.buf.code_action() end, opts)
                vim.keymap.set("n", "<leader>vrr", function() vim.lsp.buf.references() end, opts)
                vim.keymap.set("n", "<leader>vrn", function() vim.lsp.buf.rename() end, opts)
                vim.keymap.set("i", "<C-h>", function() vim.lsp.buf.signature_help() end, opts)
                vim.keymap.set({ 'n', 'v' }, '<leader>f', function()
                    vim.lsp.buf.format { async = true }
                end, { desc = '[lsp] format buffer' } )
                 

                if client.name == 'ruff' then
                    -- Disable hover in favor of pyright
                    -- client.server_capabilities.hoverProvider = false
                end
                vim.lsp.inlay_hint.enable(true)
            end)

            require('lspconfig').pyright.setup {
                settings = {
                    pyright = {
                        disableOrganizeImports = true,
                    },
                    python = {
                        analysis = {
                            ignore = { '*' },
                        },
                    },
                },
            }
            require("lspconfig").clangd.setup {}
            require("lspconfig").ruff.setup { on_attach = require("lsp-format").on_attach }
            -- require("lspconfig").rust_analyzer.setup { 
            --    on_attach = require("lsp-format").on_attach,
            --    settings = {
            --        inlay_hints = {enable = true},
            --    }
            --}
            require("lspconfig").zls.setup {}
            lsp.setup()

            vim.diagnostic.config({
                virtual_text = true
            })
        end,
    },
}

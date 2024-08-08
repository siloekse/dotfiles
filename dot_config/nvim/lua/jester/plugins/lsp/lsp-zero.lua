return {
    {
        'VonHeikemen/lsp-zero.nvim',
        branch = 'v1.x',
        dependencies = {
            -- LSP Support
            {'neovim/nvim-lspconfig'},
            {'williamboman/mason.nvim'},
            {'williamboman/mason-lspconfig.nvim'},

            -- Autocompletion
            {'hrsh7th/nvim-cmp'},
            {'hrsh7th/cmp-buffer'},
            {'hrsh7th/cmp-path'},
            {'saadparwaiz1/cmp_luasnip'},
            {'hrsh7th/cmp-nvim-lsp'},
            {'hrsh7th/cmp-nvim-lua'},

            -- Snippets
            {'L3MON4D3/LuaSnip'},
            {'rafamadriz/friendly-snippets'},

            -- Language servers
            {'ranjithshegde/ccls.nvim'},

            -- Rust lsp
            {'simrat39/rust-tools.nvim'},

        },
        config = function()
            require("mason").setup()
            require("mason-lspconfig").setup()

            local lsp = require("lsp-zero")

            lsp.preset("recommended")

            lsp.ensure_installed({
                'tsserver',
                'rust_analyzer',
                'pyright',
                'ruff_lsp',
                'clangd',
            })

            -- Fix Undefined global 'vim'
            lsp.configure('lua-language-server', {
                settings = {
                    Lua = {
                        diagnostics = {
                            globals = { 'vim' }
                        }
                    }
                }
            })


            local cmp = require('cmp')
            local cmp_select = {behavior = cmp.SelectBehavior.Select}
            local cmp_mappings = lsp.defaults.cmp_mappings({
                ['<C-p>'] = cmp.mapping.select_prev_item(cmp_select),
                ['<C-n>'] = cmp.mapping.select_next_item(cmp_select),
                ['<C-y>'] = cmp.mapping.confirm({ select = true }),
                ['<Tab>'] = cmp.mapping.confirm({ select = true }),
                ["<C-Space>"] = cmp.mapping.complete(),
            })
            cmp_mappings['<S-Tab>'] = nil

            lsp.setup_nvim_cmp({
                mapping = cmp_mappings
            })

            lsp.set_preferences({
                suggest_lsp_servers = false,
                sign_icons = {
                    error = 'E',
                    warn = 'W',
                    hint = 'H',
                    info = 'I'
                }
            })

            lsp.on_attach(function(client, bufnr)
                local opts = {buffer = bufnr, remap = false}
                local builtin = require('telescope.builtin')

                -- vim.keymap.set("n", "gD", function() vim.lsp.buf.declaration() end, opts)
                -- vim.keymap.set("n", "gd", function() vim.lsp.buf.definition() end, opts)
                vim.keymap.set('n', 'gd', builtin.lsp_definitions, opts)
                -- vim.keymap.set("n", "gi", function() vim.lsp.buf.implementation() end, opts)
                vim.keymap.set("n", "gi", builtin.lsp_implementations, opts)
                -- vim.keymap.set("n", "gr", function() vim.lsp.buf.references() end, opts)
                vim.keymap.set('n', 'gr', builtin.lsp_references, opts)
                vim.keymap.set("n", "K", function() vim.lsp.buf.hover() end, opts)
                vim.keymap.set("n", "<leader>vws", function() vim.lsp.buf.workspace_symbol() end, opts)
                vim.keymap.set("n", "<leader>vd", function() vim.diagnostic.open_float() end, opts)
                vim.keymap.set("n", "[d", function() vim.diagnostic.goto_next() end, opts)
                vim.keymap.set("n", "]d", function() vim.diagnostic.goto_prev() end, opts)
                vim.keymap.set("n", "<leader>vca", function() vim.lsp.buf.code_action() end, opts)
                vim.keymap.set("n", "<leader>vrr", function() vim.lsp.buf.references() end, opts)
                vim.keymap.set("n", "<leader>vrn", function() vim.lsp.buf.rename() end, opts)
                vim.keymap.set("i", "<C-h>", function() vim.lsp.buf.signature_help() end, opts)

                if client.name == 'ruff_lsp' then
                    -- Disable hover in favor of pyright
                    -- client.server_capabilities.hoverProvider = false
                end
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

            lsp.format_on_save({
                format_opts = {
                    async = false,
                    timeout_ms = 10000,
                },
                servers = {
                    -- ['pyright'] = {'python'},
                    ['ruff_lsp'] = {'python'},
                    ['rust_analyzer'] = {'rust'},
                    -- if you have a working setup with null-ls
                    -- you can specify filetypes it can format.
                    -- ['null-ls'] = {'javascript', 'typescript'},
                }
            })

            lsp.setup()

            vim.diagnostic.config({
                virtual_text = true
            })
        end,
    },
}

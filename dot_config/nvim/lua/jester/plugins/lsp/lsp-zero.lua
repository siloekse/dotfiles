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
            },
            {'hrsh7th/cmp-nvim-lsp'},
            {'hrsh7th/cmp-buffer'},
            {'hrsh7th/cmp-path'},
            {'hrsh7th/cmp-cmdline'},
            {'hrsh7th/nvim-cmp'},

            -- For vsnip users.
            {'hrsh7th/cmp-vsnip'},
            {'hrsh7th/vim-vsnip'},

            -- Snippets
            {'L3MON4D3/LuaSnip'},
            -- {'rafamadriz/friendly-snippets'},

            -- Language servers
            {'ranjithshegde/ccls.nvim'},

            -- Format code
            {'lukas-reineke/lsp-format.nvim'},
        },
        config = function()
            require("mason").setup()
            require("mason-lspconfig").setup({
                ensure_installed = {
                    'tsserver',
                    'pyright',
                    'ruff_lsp',
                    'clangd',
                    'rust_analyzer',
                },
            })

            local lsp = require("lsp-zero")

            require("lsp-format").setup {}

            local cmp = require('cmp')
            local cmp_action = require('lsp-zero').cmp_action()

            cmp.setup({
              sources = {
                {name = 'nvim_lsp'},
              },
              snippet = {
                expand = function(args)
                  require('luasnip').lsp_expand(args.body)
                end,
              },
              mapping = cmp.mapping.preset.insert({
                -- ["<C-Space>"] = cmp.mapping.complete(),
                -- confirm completion item
                ['<C-y>'] = cmp.mapping.confirm({ select = true }),
                -- ['<C-y>'] = cmp.mapping.confirm({select = false}),

                -- toggle completion menu
                ['<C-e>'] = cmp_action.toggle_completion(),

                -- tab complete
                ['<Tab>'] = cmp.mapping.confirm({ select = true }),
                -- ['<Tab>'] = cmp_action.tab_complete(),
                -- ['<S-Tab>'] = cmp.mapping.select_prev_item(),
                ['<C-p>'] = cmp.mapping.select_prev_item(cmp_select),
                ['<C-n>'] = cmp.mapping.select_next_item(cmp_select),

                -- navigate between snippet placeholder
                ['<C-d>'] = cmp_action.luasnip_jump_forward(),
                ['<C-b>'] = cmp_action.luasnip_jump_backward(),

                -- scroll documentation window
                ['<C-f>'] = cmp.mapping.scroll_docs(-5),
                ['<C-d>'] = cmp.mapping.scroll_docs(5),
              }),
            })

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

                if client.name == 'ruff_lsp' then
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
            require("lspconfig").ruff_lsp.setup { on_attach = require("lsp-format").on_attach }
            require("lspconfig").rust_analyzer.setup { 
                on_attach = require("lsp-format").on_attach,
                settings = {
                    inlay_hints = {enable = true},
                }
            }

            lsp.setup()

            vim.diagnostic.config({
                virtual_text = true
            })
        end,
    },
}

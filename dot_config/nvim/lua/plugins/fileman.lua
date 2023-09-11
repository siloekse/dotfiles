return {
  {
	  'nvim-telescope/telescope.nvim',
      tag = '0.1.0',
	  dependencies = {
          {'nvim-lua/plenary.nvim'}
      }
  },
  {'theprimeagen/harpoon'},
  {'nvim-treesitter/nvim-treesitter',
  build = ":TSUpdate",
  config = function () 
      local configs = require("nvim-treesitter.configs")

      configs.setup({
          ensure_installed = {
              "c",
              "lua",
              "vim",
              "vimdoc",
              "query",
              "elixir",
              "heex",
              "javascript",
              "html",
              "python"
          },
          sync_install = false,
          highlight = { enable = true },
          indent = { enable = true },  
      })
  end
  },
  {'nvim-treesitter/playground'},
}

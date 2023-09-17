-- Bootstrap
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

-- Init
require("lazy").setup({
    spec = {
        {import = "jester.plugins"},
        {import = "jester.plugins.lsp"},
        {import = "jester.plugins.debug"},
        {import = "jester.plugins.debug.core"},
        {import = "jester.plugins.debug.lng"},
    },
})

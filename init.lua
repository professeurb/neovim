-- https://github.com/fadelpamungkas/dotfiles

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

require('profb/mappings')
require('profb/options')

require("lazy").setup("profb/plugins", {
  defaults = { lazy = true },
  install = { colorscheme = { "kanagawa", "nightfox" } },
  checker = { enabled = true, notify = false },
  change_detection = {
    notify = false,
  },
  performance = {
    rtp = {
      disabled_plugins = {
        "gzip",
        "matchit",
        "matchparen",
        "netrwPlugin",
        "tarPlugin",
        "tohtml",
        "tutor",
        "zipPlugin",
      },
    },
  },
})

vim.cmd([[ colorscheme kanagawa ]])

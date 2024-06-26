return {
  { 'rebelot/kanagawa.nvim', event = 'VeryLazy' },
  { 'folke/tokyonight.nvim', event = 'VeryLazy' },
  {
    -- https://github.com/catppuccin/nvim
    'catppuccin/nvim',
    name = 'catppuccin',
    event = 'VeryLazy',
    config = {
      integrations = {
        nvimtree = true,
        which_key = true,
        mason = true,
        ufo = true,
      },
    },
  },
  { 'EdenEast/nightfox.nvim',           event = 'VeryLazy' },
  { 'ellisonleao/gruvbox.nvim',         event = 'VeryLazy' },
  { 'numToStr/Sakura.nvim',             event = 'VeryLazy' },
  { 'dracula/vim',                      event = 'VeryLazy' },
  { 'rose-pine/neovim',                 event = 'VeryLazy', name = 'rose-pine' },
  { 'fenetikm/falcon',                  event = 'VeryLazy' },
  { 'nyoom-engineering/oxocarbon.nvim', event = 'VeryLazy' },
  { 'xero/miasma.nvim',                 event = 'VeryLazy' },
  { 'bluz71/vim-nightfly-colors',       event = 'VeryLazy', name = 'nightfly' },
  { 'everforest-nvim',                  event = 'VeryLazy' },
}

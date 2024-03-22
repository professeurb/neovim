return {
  'MunifTanjim/nui.nvim',
  'nvim-lua/plenary.nvim',
  {
    'folke/trouble.nvim',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    cmd = { 'TroubleToggle' },
    keys = { { '<leader>tt', '<cmd>TroubleToggle<cr>', desc = '[T]oggle [T]rouble' } },
    config = true,
  },
  {
    -- https://github.com/tummetott/unimpaired.nvim
    'tummetott/unimpaired.nvim',
    event = 'VeryLazy',
    config = true,
  },
  {
    'nvim-tree/nvim-web-devicons',
    enabled = vim.g.have_nerd_font,
    config = {
      default = true,
    },
  },
  {
    'folke/noice.nvim',
    event = 'VeryLazy',
    opts = {
      -- add any options here
    },
    dependencies = {
      -- if you lazy-load any plugin below, make sure to add proper `module="..."` entries
      'MunifTanjim/nui.nvim',
      -- OPTIONAL:
      --   `nvim-notify` is only needed, if you want to use the notification view.
      --   If not available, we use `mini` as the fallback
      'rcarriga/nvim-notify',
    },
  },
  {
    -- https://github.com/folke/todo-comments.nvim
    'folke/todo-comments.nvim',
    dependencies = { 'nvim-lua/plenary.nvim' },
    keys = {
      { '<leader>td', '<cmd>TodoTrouble<cr>', desc = '[T]oggle to[D]os' },
      { '<leader>ft', '<cmd>TodoTelescope<cr>', desc = '[F]ind [T]odos' },
    },
    event = 'VimEnter',
    opts = {},
  },
  {
    'abecodes/tabout.nvim',
    dependencies = 'nvim-treesitter/nvim-treesitter',
    cmd = { 'Tabout', 'TaboutBack', 'TaboutToggle' },
    event = 'VimEnter',
    config = function()
      require('tabout').setup { ignore_beginning = false }
    end,
  },
  {
    '2kabhishek/termim.nvim',
    cmd = { 'Fterm', 'FTerm', 'Sterm', 'STerm', 'Vterm', 'VTerm' },
  },
  {
    -- https://github.com/stevearc/oil.nvim
    'stevearc/oil.nvim',
    opts = {},
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    cmd = { 'Oil' },
    keys = {
      { '-', mode = { 'n' }, '<cmd>Oil<cr>', desc = 'Open Parent Directory' },
    },
  },
  {
    'hedyhli/outline.nvim',
    lazy = true,
    cmd = { 'Outline', 'OutlineOpen' },
    keys = { { '<leader>to', '<cmd>Outline<CR>', desc = '[T]oggle [O]utline' } },
    opts = {},
  },
  {
    -- https://github.com/chentoast/marks.nvim
    'chentoast/marks.nvim',
    config = true,
    event = 'VimEnter',
  },
  {
    'folke/flash.nvim',
    event = 'VimEnter',
    opts = {},
    -- stylua: ignore
    keys = {
      { "s", mode = { "n", "x", "o" }, function() require("flash").jump() end,       desc = "Flash" },
      { "S", mode = { "n", "o", "x" }, function() require("flash").treesitter() end, desc = "Flash Treesitter" },
      { "r", mode = "o",               function() require("flash").remote() end,     desc = "Remote Flash" },
      {
        "R",
        mode = { "o", "x" },
        function() require("flash").treesitter_search() end,
        desc =
        "Treesitter Search"
      },
      {
        "<c-s>",
        mode = { "c" },
        function() require("flash").toggle() end,
        desc =
        "Toggle Flash Search"
      },
    },
  },
  { -- A Neovim plugin helping you establish good command workflow and habit
    'm4xshen/hardtime.nvim',
    enabled = false,
    event = 'VimEnter',
    dependencies = { 'MunifTanjim/nui.nvim', 'nvim-lua/plenary.nvim' },
    opts = {},
  },
  {
    'sustech-data/wildfire.nvim',
    event = 'VimEnter',
    dependencies = { 'nvim-treesitter/nvim-treesitter' },
    opts = {
      keymaps = {
        init_selection = '<C-space>',
        node_incremental = '<C-space>',
        node_decremental = '<C-bs>',
      },
    },
  },
  {
    -- https://github.com/Pheon-Dev/pigeon
    'Pheon-Dev/pigeon',
    event = 'VimEnter',
    opts = {
      enabled = false,
      os = 'osx', -- windows, osx
      plugin_manager = 'lazy', -- packer, paq, vim-plug
      callbacks = {
        killing_pigeon = nil,
        respawning_pigeon = nil,
      },
    },
  },
  {
    -- https://www.ejmastnak.com/tutorials/vim-latex/intro/
    'lervag/vimtex',
    ft = 'tex', -- without ft, it's not working too
    config = function()
      vim.cmd 'call vimtex#init()'
    end,
  },
  {
    'kristijanhusak/vim-dadbod-ui',
    dependencies = {
      { 'tpope/vim-dadbod', lazy = true },
      { 'kristijanhusak/vim-dadbod-completion', ft = { 'sql', 'mysql', 'plsql' }, lazy = true },
    },
    cmd = {
      'DBUI',
      'DBUIToggle',
      'DBUIAddConnection',
      'DBUIFindBuffer',
    },
    init = function()
      -- Your DBUI configuration
      vim.g.db_ui_use_nerd_fonts = 1
    end,
  },
}

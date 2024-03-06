return {
  'MunifTanjim/nui.nvim',
  'nvim-lua/plenary.nvim',
  {
    'folke/trouble.nvim',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    cmd = { 'TroubleToggle' },
    keys = { { '<leader>tt', '<cmd>TroubleToggle<cr>', desc = 'Trouble' } },
    config = true,
  },
  { 'tummetott/unimpaired.nvim', event = 'VeryLazy', config = true },
  {
    'nvim-tree/nvim-web-devicons',
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
    'abecodes/tabout.nvim',
    dependencies = 'nvim-treesitter/nvim-treesitter',
    cmd = { 'Tabout', 'TaboutBack', 'TaboutToggle' },
    event = 'VeryLazy',
    config = function()
      require('tabout').setup { ignore_beginning = false }
    end,
  },
  {
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
    keys = { -- Example mapping to toggle outline
      { '<leader>to', '<cmd>Outline<CR>', desc = 'Toggle outline' },
    },
    opts = {
      -- Your setup opts here
    },
  },
  {
    'chentoast/marks.nvim',
    config = true,
    event = 'VeryLazy',
  },
  {
    'folke/flash.nvim',
    event = 'VeryLazy',
    ---@type Flash.Config
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
  {
    'm4xshen/hardtime.nvim',
    dependencies = { 'MunifTanjim/nui.nvim', 'nvim-lua/plenary.nvim' },
    opts = {},
  },
  {
    'sustech-data/wildfire.nvim',
    event = 'VeryLazy',
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
    'Pheon-Dev/pigeon',
    event = 'VeryLazy',
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
    'nvim-lualine/lualine.nvim',
    dependencies = {
      'nvim-tree/nvim-web-devicons',
      'meuter/lualine-so-fancy.nvim',
    },
    event = 'BufReadPre',
    opts = {
      options = {
        theme = 'seoul256',
        component_separators = { left = '│', right = '│' },
        section_separators = { left = '', right = '' },
        globalstatus = true,
        refresh = {
          statusline = 100,
        },
      },
      sections = {
        lualine_a = {
          { 'fancy_mode', width = 3 },
        },
        lualine_b = {
          { 'fancy_branch' },
          { 'fancy_diff' },
        },
        lualine_c = {
          { 'fancy_cwd', substitute_home = true },
        },
        lualine_x = {
          { 'fancy_macro' },
          { 'fancy_diagnostics' },
          { 'fancy_searchcount' },
          { 'fancy_location' },
        },
        lualine_y = {
          { 'fancy_filetype', ts_icon = '' },
        },
        lualine_z = {
          { 'fancy_lsp_servers' },
        },
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

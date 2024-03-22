return {
  'nvim-treesitter/nvim-treesitter',
  build = ':TSUpdate',
  event = 'BufReadPost',

  dependencies = {
    'nvim-treesitter/nvim-treesitter-textobjects',
    'RRethy/nvim-treesitter-textsubjects',
    'JoosepAlviste/nvim-ts-context-commentstring',
  },
  config = function()
    local treesitter = require 'nvim-treesitter.configs'
    treesitter.setup {
      ensure_installed = {
        'c',
        'latex',
        'lua',
        'vim',
        'vimdoc',
        'markdown',
        'nix',
        'norg',
        'php',
        'python',
        'sql',
        'json',
      },

      -- install parsers synchronously (only applied to `ensure_installed`)
      sync_install = false,
      -- list of parsers to ignore installing (for "all")
      ignore_install = { 'phpdoc', 'comment' },
      --
      highlight = {
        enable = true,
        disable = {},
        additional_vim_regex_highlighting = false,
      },
      -- incremental_selection = {
      --   enable = true,
      --   keymaps = {
      --     init_selection = "<C-space>",
      --     node_incremental = "<C-space>",
      --     scope_incremental = "<C-s>",
      --     node_decremental = "<C-bs>",
      --   },
      -- },
      indent = {
        enable = true,
      },
      textobjects = {
        select = {
          enable = true,
          lookahead = true, -- automatically jump forward to textobj, similar to targets.vim
          keymaps = {
            -- you can use the capture groups defined in textobjects.scm
            ['af'] = '@function.outer',
            ['if'] = '@function.inner',
            ['ac'] = '@class.outer',
            ['ic'] = '@class.inner',
          },
        },
        move = {
          enable = true,
          set_jumps = true, -- whether to set jumps in the jumplist
          goto_next_start = {
            [']m'] = '@function.outer',
            [']]'] = '@class.outer',
          },
          goto_next_end = {
            [']n'] = '@function.outer',
            [']['] = '@class.outer',
          },
          goto_previous_start = {
            ['[m'] = '@function.outer',
            ['[['] = '@class.outer',
          },
          goto_previous_end = {
            ['[n'] = '@function.outer',
            ['[]'] = '@class.outer',
          },
        },
      },
    }
  end,
}

return {
  'nvim-telescope/telescope.nvim',
  event = 'VimEnter',
  cmd = { 'Telescope' },
  dependencies = {
    'nvim-lua/plenary.nvim',
    {
      'nvim-telescope/telescope-fzf-native.nvim',
      build = 'make',
      cond = function()
        return vim.fn.executable 'make' == 1
      end,
    },
    'nvim-telescope/telescope-ui-select.nvim',
  },
  config = function()
    local telescope = require 'telescope'
    -- local actions = require 'telescope.actions'

    telescope.setup {
      defaults = {
        path_display = { 'truncate ' },
        -- mappings = {
        --   i = {
        --     ['<C-k>'] = actions.move_selection_previous,                                                           -- move to prev result
        --     ['<C-j>'] = { actions.move_selection_next, type = 'action', opts = { nowait = true, silent = true } }, -- move to next result
        --     ['<C-q>'] = actions.send_selected_to_qflist + actions.open_qflist,
        --   },
        -- },
      },
      extensions = {
        ['ui-select'] = {
          require('telescope.themes').get_dropdown(),
        },
      },
    }

    -- load extensions
    pcall(require('telescope').load_extension, 'fzf')
    pcall(require('telescope').load_extension, 'ui-select')

    -- set keymaps
    local keymap = vim.keymap -- for conciseness
    local builtin = require 'telescope.builtin'

    keymap.set('n', '<leader>ff', '<cmd>Telescope find_files<cr>', { desc = 'Fuzzy find files in cwd' })
    keymap.set('n', '<leader>fr', '<cmd>Telescope oldfiles<cr>', { desc = 'Fuzzy find recent files' })
    keymap.set('n', '<leader>fs', '<cmd>Telescope live_grep<cr>', { desc = 'Find string in cwd' })
    keymap.set('n', '<leader>fg', '<cmd>Telescope grep_string<cr>', { desc = 'Find string under cursor in cwd' })
    keymap.set('n', '<leader>fR', '<cmd>Telescope registers<cr>', { desc = 'Registers' })
    keymap.set('n', '<leader>fh', builtin.help_tags, { desc = 'Help' })
    keymap.set('n', '<leader>fd', builtin.diagnostics, { desc = 'Diagnostics' })
    keymap.set('n', '<leader>fb', builtin.buffers, { desc = 'Buffers' })
    keymap.set('n', '<leader>fk', builtin.keymaps, { desc = 'Keymaps' })
    keymap.set('n', '<leader>fc', function()
      require('telescope.builtin').colorscheme { enable_preview = true }
    end, { desc = 'Switch colorscheme' })
    vim.keymap.set('n', '<leader>/', function()
      -- You can pass additional configuration to telescope to change theme, layout, etc.
      builtin.current_buffer_fuzzy_find(require('telescope.themes').get_dropdown {
        winblend = 10,
        previewer = false,
      })
    end, { desc = '[/] Fuzzily search in current buffer' })
    vim.keymap.set('n', '<leader>f/', function()
      builtin.live_grep {
        grep_open_files = true,
        prompt_title = 'Live Grep in Open Files',
      }
    end, { desc = '[S]earch [/] in Open Files' })
  end,
}

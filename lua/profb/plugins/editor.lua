return {
  { 'numToStr/Comment.nvim', config = true, event = 'BufReadPre' },
  {
    'windwp/nvim-autopairs',
    event = 'BufReadPre',
    config = function()
      local ap = require 'nvim-autopairs'
      local Rule = require 'nvim-autopairs.rule'
      ap.setup()
      ap.add_rule(Rule('$$', '$$', 'tex'))
      ap.add_rule(Rule('$', '$', 'tex'))
      ap.add_rule(Rule('\\(', '\\)', 'tex'))
      ap.add_rule(Rule('\\[', '\\]', 'tex'))
    end,
  },
  {
    'monaqa/dial.nvim',
    event = 'BufReadPre',
    config = function()
      vim.api.nvim_set_keymap('n', '<C-a>', require('dial.map').inc_normal(), { desc = 'Increment', noremap = true })
      vim.api.nvim_set_keymap('n', '<C-x>', require('dial.map').dec_normal(), { desc = 'Decrement', noremap = true })
      vim.api.nvim_set_keymap('v', '<C-a>', require('dial.map').inc_visual(), { desc = 'Increment', noremap = true })
      vim.api.nvim_set_keymap('v', '<C-x>', require('dial.map').dec_visual(), { desc = 'Decrement', noremap = true })
      vim.api.nvim_set_keymap('v', 'g<C-a>', require('dial.map').inc_gvisual(), { desc = 'Increment', noremap = true })
      vim.api.nvim_set_keymap('v', 'g<C-x>', require('dial.map').dec_gvisual(), { desc = 'Decrement', noremap = true })
    end,
  },
  { 'm4xshen/autoclose.nvim', config = true, event = 'InsertEnter' },
  {
    'rareitems/put_at_end.nvim',
    keys = {
      {
        '<C-;>',
        function()
          require('put_at_end').put_semicolon()
        end,
        desc = 'Put a semicolon at the end of the line',
      },
      {
        '<C-.>',
        function()
          require('put_at_end').put_period()
        end,
        desc = 'Put a period at the end of the line',
      },
      {
        '<C-,>',
        function()
          require('put_at_end').put_comma()
        end,
        desc = 'Put a comma at the end of the line',
      },
    },
  },
  {
    'Wansmer/treesj',
    keys = { '<space>m', '<space>j', '<space>s' },
    dependencies = { 'nvim-treesitter/nvim-treesitter' },
    config = true,
  },
  {
    'kylechui/nvim-surround',
    version = '*',
    event = 'VeryLazy',
    config = true,
  },
}

-- On s'inspire de
-- https://github.com/nvim-lua/kickstart.nvim/blob/master/init.lua
return {
  'folke/which-key.nvim',
  event = 'VimEnter',
  config = function()
    local wk = require 'which-key'
    wk.setup {
      show_help = false,
      plugins = { spelling = true },
      key_labels = { ['<leader>'] = 'SPC' },
      triggers = 'auto',
    }
    wk.register({
      w = { '<cmd>update!<CR>', 'Save' },
      -- q = { "<cmd>lua require('util').smart_quit()<CR>", 'Quit' },
      f = { name = '[F]ind', _ = 'which_key_ignore' },
      g = { name = '[G]it', _ = 'which_key_ignore' },
      t = { name = '[T]oggle', _ = 'which_key_ignore' },
      c = { name = '[C]ode', _ = 'which_key_ignore' },
    }, { prefix = '<leader>' })
  end,
}

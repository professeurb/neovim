local M = {}

function M.setup()
  require("nvim-treesitter.configs").setup {
    -- A list of parser names, or "all"
    ensure_installed = "all",

    -- Install languages synchronously (only applied to `ensure_installed`)
    sync_install = false,

    autopairs = { enable = true },
    highlight = {
      -- `false` will disable the whole extension
      enable = true,
      additional_vim_regex_highlighting = true
    },
    rainbow = { enable = true },
    context_commentstring = { enable = true,
      enable_autocmd = false, },
  textsubjects = {
    enable = true,
    prev_selection = ',', -- (Optional) keymap to select the previous selection
    keymaps = {
      ['.'] = 'textsubjects-smart',
      [';'] = 'textsubjects-container-outer',
      ['i;'] = 'textsubjects-container-inner',
    },
  }
  }
end

return M

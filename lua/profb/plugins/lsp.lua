return {
  {
    'williamboman/mason.nvim',
    cmd = 'Mason',
    dependencies = {
      'WhoIsSethDaniel/mason-tool-installer.nvim',
    },
    config = function()
      local mason = require 'mason'

      local mason_tool_installer = require 'mason-tool-installer'

      -- enable mason and configure icons
      mason.setup {
        ui = {
          icons = {
            package_installed = '✓',
            package_pending = '➜',
            package_uninstalled = '✗',
          },
        },
      }
      mason_tool_installer.setup {
        ensure_installed = {
          'prettierd', -- prettier formatter
          'stylua', -- lua formatter
          'isort', -- python formatter
          'blackd-client', -- python formatter
          'black',
          'pylint', -- python linter
          'eslint_d', -- js linter
          'alejandra',
          'clang-format',
          'php-cs-fixer',
        },
      }
    end,
  },
  {
    'stevearc/conform.nvim',
    event = { 'BufReadPre', 'BufNewFile' },
    config = function()
      local conform = require 'conform'

      conform.setup {
        formatters_by_ft = {
          javascript = { 'prettierd' },
          typescript = { 'prettierd' },
          javascriptreact = { 'prettierd' },
          typescriptreact = { 'prettierd' },
          svelte = { 'prettierd' },
          css = { 'prettierd' },
          html = { 'prettierd' },
          json = { 'prettierd' },
          yaml = { 'prettierd' },
          markdown = { 'prettierd' },
          graphql = { 'prettierd' },
          lua = { 'stylua' },
          python = { 'isort', 'black' },
          nix = { 'alejandra' },
          c = { 'clang_format' },
          php = { 'php_cs_fixer' },
        },
        format_on_save = {
          lsp_fallback = true,
          async = false,
          timeout_ms = 500,
        },
      }
      -- conform.formatters.clang_format = { '-style=~/.clang-format' }

      vim.keymap.set({ 'n', 'v' }, '<leader>cf', function()
        conform.format {
          lsp_fallback = true,
          async = false,
          timeout_ms = 500,
        }
      end, {
        desc = 'Format file or range (in visual mode)',
      })
    end,
  },
  {
    'j-hui/fidget.nvim',
    tag = 'legacy',
    event = 'LspAttach',
    config = true,
  },
}

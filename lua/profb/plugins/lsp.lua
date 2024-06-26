local function has(client, cap)
  return client.server_capabilities[cap .. 'Provider']
end

local function map(client, buffer, lhs, rhs, opts)
  opts = opts or {}
  if opts.has and not has(client, opts.has) then
    return
  end
  vim.keymap.set(
    opts.mode or 'n',
    lhs,
    type(rhs) == 'string' and ('<cmd>%s<cr>'):format(rhs) or rhs,
    ---@diagnostic disable-next-line: no-unknown
    { silent = true, buffer = buffer, expr = opts.expr, desc = opts.desc }
  )
end

return {
  {
    -- https://github.com/neovim/nvim-lspconfig
    'neovim/nvim-lspconfig',
    event = 'BufReadPre',
    dependencies = {
      { 'folke/neodev.nvim', config = true },
      { 'j-hui/fidget.nvim' },
      { 'williamboman/mason-lspconfig.nvim' },
      { 'folke/which-key.nvim' },
      { 'nvim-telescope/telescope.nvim' },
    },
    config = function()
      local lspconfig = require 'lspconfig'
      local servers = {
        texlab = {
          auxDirectory = '.',
          bibtexFormatter = 'texlab',
          latexFormatter = 'latexindent',
          latexindent = { modifyLineBreaks = false },
        },
        ocamllsp = { cmd = { 'ocamllsp', '--fallback-read-dot-merlin' } },
        pylsp = { plugins = { black = { enabled = true } } },
        astro = {},
        svelte = {},
        bashls = {},
        html = {},
        lua_ls = {
          settings = {
            Lua = {
              runtime = { version = 'LuaJIT' },
              workspace = {
                checkThirdParty = false,
                library = {
                  '${3rd}/luv/library',
                  unpack(vim.api.nvim_get_runtime_file('', true)),
                },
              },
              completion = {
                callSnippet = 'Replace',
              },
            },
          },
        },
        rust_analyzer = {},
        rnix = {},
        nil_ls = { settings = { ['nil'] = { formatting = { command = { 'alejandra', '-q' } } } } },
        clangd = {},
        marksman = {},
      }
      for lsp, cfg in pairs(servers) do
        lspconfig[lsp].setup(cfg)
      end
      vim.api.nvim_create_autocmd('LspAttach', {
        callback = function(args)
          local bufnr = args.buf
          local client = vim.lsp.get_client_by_id(args.data.client_id)
          local builtin = require 'telescope.builtin'
          map(client, bufnr, 'gd', 'Telescope lsp_definitions', { desc = 'Goto Definition' })
          map(client, bufnr, 'gr', 'Telescope lsp_references', { desc = 'References' })
          -- map(client, bufnr, 'gD', 'Telescope lsp_declarations', { desc = 'Goto Declaration' })
          -- map(client, bufnr, 'gI', 'Telescope lsp_implementations', { desc = 'Goto Implementation' })
          map(client, bufnr, 'gb', 'Telescope lsp_type_definitions', { desc = 'Goto Type Definition' })
          map(client, bufnr, 'K', vim.lsp.buf.hover, { desc = 'Hover Documentation' })
          map(client, bufnr, '<leader>cr', vim.lsp.buf.rename, { expr = true, desc = '[R]ename', has = 'rename' })
          map(client, bufnr, '<leader>cs', builtin.lsp_document_symbols, { desc = 'Document Symbols' })
          map(client, bufnr, '<leader>cS', builtin.lsp_dynamic_workspace_symbols, { desc = 'Workspace Symbols' })
        end,
      })
      vim.cmd [[
  augroup _lsp
    autocmd!
    autocmd BufWritePre * lua vim.lsp.buf.format({ async = false })
  augroup end
]]

      -- local capabilities = vim.lsp.protocol.make_client_capabilities()
      -- capabilities = vim.tbl_deep_extend('force', capabilities, require('cmp_nvim_lsp').default_capabilities())
    end,
  },
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
          -- 'alejandra',
          'latexindent',
          'clang-format',
          'php-cs-fixer',
          'ocamlformat',
          'jdtls',
          'beautysh',
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
          c = { 'clang_format' },
          css = { 'prettierd' },
          graphql = { 'prettierd' },
          html = { 'prettierd' },
          javascript = { 'prettierd' },
          javascriptreact = { 'prettierd' },
          java = { 'google-java-format' },
          json = { 'prettierd' },
          lua = { 'stylua' },
          markdown = { 'prettier' },
          mdx = { 'prettier' },
          nix = { 'alejandra' },
          ocaml = { 'ocamlformat' },
          php = { 'pretty-php' },
          python = { 'isort', 'black' },
          svelte = { 'prettierd' },
          tex = { 'latexindent' },
          typescript = { 'prettierd' },
          typescriptreact = { 'prettierd' },
          yaml = { 'prettierd' },
          astro = { 'prettierd' },
        },
        format_on_save = {
          lsp_fallback = true,
          async = false,
          timeout_ms = 500,
        },
        notify_on_error = false,
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
    'williamboman/mason-lspconfig.nvim',
    dependencies = { 'williamboman/mason.nvim', 'neovim/nvim-lspconfig' },
    config = true,
  },
  {
    'j-hui/fidget.nvim',
    tag = 'legacy',
    event = 'LspAttach',
    config = true,
  },
}

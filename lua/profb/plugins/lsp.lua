function has(client, cap)
  return client.server_capabilities[cap .. "Provider"]
end

function map(client, buffer, lhs, rhs, opts)
  opts = opts or {}
  if opts.has and not has(client, opts.has) then
    return
  end
  vim.keymap.set(
    opts.mode or "n",
    lhs,
    type(rhs) == "string" and ("<cmd>%s<cr>"):format(rhs) or rhs,
    ---@diagnostic disable-next-line: no-unknown
    { silent = true, buffer = buffer, expr = opts.expr, desc = opts.desc }
  )
end

return {
  { "williamboman/mason.nvim", cmd = "Mason", config = true },
  {
    "williamboman/mason-lspconfig.nvim",
    dependencies = "williamboman/mason.nvim",
    opts = {
      automatic_installation = true,
      ensure_installed = {
        "texlab", "tailwindcss", "ocamllsp", "pylsp", "svelte", "lua_ls", "nil_ls", "clangd", "marksman"
      }
    }
  },
  {
    "jose-elias-alvarez/null-ls.nvim",
    config = function()
      local null_ls = require("null-ls")
      null_ls.setup {
        debug = false,
        sources = {
          null_ls.builtins.formatting.prettierd.with {
            extra_args = { "--no-semi", "--single-quote", "--jsx-single-quote" },
            filetypes = { "astro", "css", "javascript", "djangohtml", "html", "json", "yaml", "markdown", "svelte" },
          },
          null_ls.builtins.formatting.clang_format
          -- formatting.black.with({ extra_args = { "--fast" } }),
          -- formatting.stylua,
          -- diagnostics.flake8
        },
      }
    end
  },
  {
    "j-hui/fidget.nvim",
    tag = "legacy",
    event = "LspAttach",
    config = true
  },
  {
    "neovim/nvim-lspconfig",
    event = "BufReadPre",
    dependencies = {
      { "folke/neodev.nvim",                config = true },
      { 'j-hui/fidget.nvim' },
      { "williamboman/mason-lspconfig.nvim" },
      { "folke/which-key.nvim" }
    },
    config = function()
      local lspconfig = require("lspconfig")
      local servers = {
        texlab = {
          auxDirectory = ".",
          bibtexFormatter = "texlab",
          latexFormatter = "latexindent",
          latexindent = { modifyLineBreaks = false },
        },
        ocamllsp = { cmd = { "ocamllsp", "--fallback-read-dot-merlin" } },
        pylsp = { plugins = { black = { enabled = true } } },
        svelte = {},
        lua_ls = {
          settings = {
            Lua = {
              workspace = {
                checkThirdParty = false,
              },
              completion = {
                callSnippet = "Replace",
              },
            },
          },
        },
        rust_analyzer = {},
        nil_ls = { settings = { ['nil'] = { formatting = { command = { "alejandra", "-q" } } } } },
        clangd = {},
        marksman = {}
      }

      for lsp, cfg in pairs(servers) do
        lspconfig[lsp].setup(cfg)
      end

      vim.api.nvim_create_autocmd("LspAttach", {
        callback = function(args)
          local bufnr = args.buf
          local client = vim.lsp.get_client_by_id(args.data.client_id)
          map(client, bufnr, "gd", "Telescope lsp_definitions", { desc = "Goto Definition" })
          map(client, bufnr, "gr", "Telescope lsp_references", { desc = "References" })
          map(client, bufnr, "gD", "Telescope lsp_declarations", { desc = "Goto Declaration" })
          map(client, bufnr, "gI", "Telescope lsp_implementations", { desc = "Goto Implementation" })
          map(client, bufnr, "gb", "Telescope lsp_type_definitions", { desc = "Goto Type Definition" })
          map(client, bufnr, "K", vim.lsp.buf.hover, { desc = "Hover" })
          map(client, bufnr, "<leader>cr", vim.lsp.buf.rename, { expr = true, desc = "Rename", has = "rename" })
          map(client, bufnr, "<leader>cs", require("telescope.builtin").lsp_document_symbols,
            { desc = "Document Symbols" })
          map(client, bufnr, "<leader>cS", require("telescope.builtin").lsp_dynamic_workspace_symbols,
            { desc = "Workspace Symbols" })
        end,
      })

      vim.cmd [[
  augroup _lsp
    autocmd!
    autocmd BufWritePre * lua vim.lsp.buf.format({ async = false })
  augroup end
]]
    end
  },
}

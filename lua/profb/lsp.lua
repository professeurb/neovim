local lspconfig_status_ok, lspconfig = pcall(require, "lspconfig")
if not lspconfig_status_ok then
  return
end

local servers = {
  texlab = {
    auxDirectory = ".",
    bibtexFormatter = "texlab",
    latexFormatter = "latexindent",
    latexindent = { modifyLineBreaks = false },
  },
  ocamllsp = {},
  pylsp = {},
  svelte = {},
  sumneko_lua = {
    settings = {
      Lua = {
        diagnostics = {
          globals = { "vim" },
        },
        workspace = {
          library = {
            [vim.fn.expand("$VIMRUNTIME/lua")] = true,
            [vim.fn.stdpath("config") .. "/lua"] = true,
          },
        },
      },
    },
  },
}

for lsp, cfg in pairs(servers) do
  lspconfig[lsp].setup(cfg)
end

vim.cmd([[
  augroup _lsp
    autocmd!
    autocmd BufWritePre * lua vim.lsp.buf.format({ async = false })
  augroup end
]])

-- null-ls

local null_ls_status_ok, null_ls = pcall(require, "null-ls")
if not null_ls_status_ok then
  return
end

-- https://github.com/jose-elias-alvarez/null-ls.nvim/tree/main/lua/null-ls/builtins/formatting
local formatting = null_ls.builtins.formatting
-- local diagnostics = null_ls.builtins.diagnostics

null_ls.setup({
  debug = false,
  sources = {
    formatting.prettier.with {
      extra_args = { "--no-semi", "--single-quote", "--jsx-single-quote" },
      filetypes = { "astro", "css", "javascript", "djangohtml", "html", "json", "yaml", "markdown", "svelte" },
    },
    -- formatting.black.with({ extra_args = { "--fast" } }),
    -- formatting.stylua,
    -- diagnostics.flake8
  },
})

-- fidget
require "fidget".setup {}

-- whick-key
local which_key_status_ok, which_key = pcall(require, "which-key")
if not which_key_status_ok then
  return
end

which_key.register({
  l = {
    name = "LSP",
    a = { "<cmd>lua vim.lsp.buf.code_action()<cr>", "Code Action" },
    d = {
      "<cmd>Telescope diagnostics<cr>",
      "Diagnostics",
    },
    f = { "<cmd>lua vim.lsp.buf.format( { async = true } )<cr>", "Format" },
    i = { "<cmd>LspInfo<cr>", "Info" },
    I = { "<cmd>LspInstallInfo<cr>", "Installer Info" },
    j = {
      "<cmd>lua vim.lsp.diagnostic.goto_next()<CR>",
      "Next Diagnostic",
    },
    k = {
      "<cmd>lua vim.lsp.diagnostic.goto_prev()<cr>",
      "Prev Diagnostic",
    },
    l = { "<cmd>lua vim.lsp.codelens.run()<cr>", "CodeLens Action" },
    q = { "<cmd>lua vim.lsp.diagnostic.set_loclist()<cr>", "Quickfix" },
    r = { "<cmd>lua vim.lsp.buf.rename()<cr>", "Rename" },
    s = { "<cmd>Telescope lsp_document_symbols<cr>", "Document Symbols" },
    S = {
      "<cmd>Telescope lsp_dynamic_workspace_symbols<cr>",
      "Workspace Symbols",
    },
  },
}, { prefix = "<leader>" })

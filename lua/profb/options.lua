local options = {
  -- autoread = true,
  -- backspace = { "indent", "eol", "start" },
  backup = false, -- creates a backup file
  breakindent = true, -- enable break indent
  clipboard = 'unnamedplus', -- system clipboard
  cmdheight = 2, -- more space in command line
  -- compatible = false,
  completeopt = { 'menu', 'menuone', 'noselect' }, -- for cmp
  conceallevel = 1,
  cursorline = true, -- highlight the current line
  expandtab = true, -- convert tabs to spaces
  foldlevel = 10, -- start with open folds
  grepprg = 'rg --vimgrep --smart-case --follow', -- use ripgrep
  -- hidden = true,
  hlsearch = true, -- highlight all matches on previous search pattern
  ignorecase = true, -- ignore case in search patterns
  inccommand = 'split', -- preview substitution live
  -- incsearch = true,
  -- laststatus = 3,
  list = true,
  listchars = { tab = '» ', leadmultispace = '┊ ', trail = '·', nbsp = '␣' },
  mouse = 'a',
  number = true,
  numberwidth = 4, -- number column width
  relativenumber = true,
  ruler = true,
  scrolloff = 10,
  shiftwidth = 2, -- number of spaces for indentation
  showmode = false, -- don't show the mode, it's in the status line
  sidescrolloff = 8,
  signcolumn = 'yes', -- always show the sign column
  smartcase = true,
  smartindent = true,
  softtabstop = 2,
  -- spell = true,
  -- spelllang = { "en_us" },
  splitbelow = true,
  splitright = true,
  swapfile = false,
  tabstop = 2,
  termguicolors = true,
  textwidth = 0,
  timeoutlen = 300, -- time to wait for a mapped sequence to complete in ms
  undodir = os.getenv 'HOME' .. '/.local/share/nvim/undodir',
  undofile = true,
  updatetime = 600, -- faster update times
  wildmenu = true,
  wildignorecase = true,
  wildmode = 'longest,list,full',
  wrap = false,
  writebackup = false, -- if a file is being edited by another program
}

for k, v in pairs(options) do
  vim.opt[k] = v
end

vim.opt.shortmess:append 'c'
vim.opt.wildignore:append '**/node_modules/*'
vim.opt.wildignore:append '**/.git/*'
vim.opt.wildignore:append '**/build/*'

vim.g.have_nerd_font = true -- because I do

-- Highlight on yank
-- vim.cmd [[
--   augroup YankHighlight
--     autocmd!
--     autocmd TextYankPost * silent! lua vim.highlight.on_yank()
--   augroup end
-- ]]

-- Highlight when yanking (copying) text
--  Try it with `yap` in normal mode
--  See `:help vim.highlight.on_yank()`
vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking (copying) text',
  group = vim.api.nvim_create_augroup('YankHightlight', { clear = true }),
  callback = function()
    vim.highlight.on_yank()
  end,
})

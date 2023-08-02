local opts = { noremap = true, silent = true }
local term_opts = { silent = true }

local map = vim.api.nvim_set_keymap

map("", "<Space>", "<Nop>", opts)
vim.g.mapleader = ' '
vim.g.maplocalleader = ','

-- NO ARROWS
map('', '<Left>', '<Nop>', opts)
map('', '<Right>', '<Nop>', opts)
map('', '<Up>', '<Nop>', opts)
map('', '<Down>', '<Nop>', opts)

-- Better split navigation
map("n", "<C-h>", "<C-w>h", opts)
map("n", "<C-j>", "<C-w>j", opts)
map("n", "<C-k>", "<C-w>k", opts)
map("n", "<C-l>", "<C-w>l", opts)

-- Remap for dealing with word wrap
vim.keymap.set('n', 'k', "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
vim.keymap.set('n', 'j', "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })

-- Switch buffer
map('n', '[b', ':bnext<CR>', opts)
map('n', ']b', ':bprev<CR>', opts)

-- Cancel search highlighting with ESC
map("n", "<ESC>", ":nohlsearch<Bar>:echo<CR>", opts)

-- Center search results
map("n", "n", "nzz", opts)
map("n", "N", "Nzz", opts)

-- Insert mode
map('i', 'jk', '<esc>', opts)

-- Visual mode
map('v', '<', '<gv', opts)
map('v', '>', '>gv', opts)

-- Visual block mode
map("x", "J", ":move '>+1<CR>gv-gv", opts)
map("x", "K", ":move '<-2<CR>gv-gv", opts)

-- Terminal --
-- Better terminal navigation
map("t", "<C-h>", "<C-\\><C-N><C-w>h", term_opts)
map("t", "<C-j>", "<C-\\><C-N><C-w>j", term_opts)
map("t", "<C-k>", "<C-\\><C-N><C-w>k", term_opts)
map("t", "<C-l>", "<C-\\><C-N><C-w>l", term_opts)
map("t", "jk", "<C-\\><C-n>", opts)

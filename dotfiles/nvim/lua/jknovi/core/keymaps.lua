local g = vim.g

-- follow the leader
g.mapleader = ","

-- move to telescope config
local telescope = require('telescope.builtin')

vim.keymap.set('n', '<C-p>', telescope.find_files, {})
vim.keymap.set('n', '<C-g>', telescope.live_grep, {})

-- Nerdtree
vim.keymap.set('n', '<C-n>', ":NvimTreeToggle<cr>")
vim.keymap.set('n', '<C-d>', ":NvimTreeFindFile<cr>")

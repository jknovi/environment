local g = vim.g

-- follow the leader
g.mapleader = ","

-- move to telescope config
local telescope = require('telescope.builtin')

vim.keymap.set('n', '<leader>ff', telescope.find_files, {})
vim.keymap.set('n', '<C-p>', telescope.find_files, {})

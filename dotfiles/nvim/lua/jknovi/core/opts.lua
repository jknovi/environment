local opt = vim.opt

-- line numbers
opt.relativenumber = true
opt.number = true

-- tabs & identation
opt.tabstop = 4
opt.softtabstop = 4
opt.shiftwidth = 4
opt.expandtab = true
opt.smartindent = true

-- line wrapping
opt.wrap = false

-- No swaps plz!
opt.swapfile = false
opt.backup = false
opt.undodir = os.getenv("HOME") .. "/.vim/undodir"
opt.undofile = true

-- search
opt.hlsearch = true
opt.incsearch = true
opt.ignorecase = true
opt.smartcase = true
opt.showmatch = true

-- appearence
opt.termguicolors = true
opt.background = "dark"
opt.scrolloff = 8

-- Spell
vim.opt.spelllang = 'en_us'
vim.opt.spell = true

vim.signcolumn = yes

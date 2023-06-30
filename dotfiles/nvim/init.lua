local cmd = vim.cmd
local api = vim.api
local g = vim.g

-- Disable netrw
g.loaded_netrw = 1
g.loaded_netrwPlugin = 1

require("jknovi.core.opts")

require("jknovi.plugins")
require("jknovi.core.keymaps")

require("jknovi.lsp").setup()

-- Mappings and configs for specific languages
require("jknovi.lang")

cmd.colorscheme('gruvbox')
--cmd.colorscheme('tokyonight')

api.nvim_set_hl(0, "Normal", { bg = "none" })
api.nvim_set_hl(0, "NormalFloat", { bg = "none" })

local lsp = require('lsp-zero').preset({})

lsp.on_attach(function(_, bufnr)
  lsp.default_keymaps({buffer = bufnr})
end)

lsp.setup()

local api = vim.api
local cmd = vim.cmd
local opt = vim.opt
local fn = vim.fn
local loop = vim.loop

local lazypath = fn.stdpath('data') .. '/lazy/lazy.nvim'

-- Auto-install lazy.nvim if not present
if not loop.fs_stat(lazypath) then
  print('Installing lazy.nvim....')
  fn.system({
    'git',
    'clone',
    '--filter=blob:none',
    'https://github.com/folke/lazy.nvim.git',
    '--branch=stable', -- latest stable release
    lazypath,
  })
  print('Done.')
end

opt.rtp:prepend(lazypath)

return require('lazy').setup({
    {'folke/neodev.nvim'},
    {
        'nvim-lualine/lualine.nvim',
        dependencies = { 'nvim-tree/nvim-web-devicons', opt = true },
    },
    {'folke/tokyonight.nvim'},
    {'gruvbox-community/gruvbox'},
    {
        'nvim-telescope/telescope.nvim',
        dependencies = {
            'nvim-lua/plenary.nvim',
            'nvim-lua/popup.nvim',
        },
        -- config = function()
        --     require("jknovi.plugins.telescope").setup()
        -- end,
    },
    {
        "hrsh7th/nvim-cmp",
        event = "InsertEnter",
        dependencies = {
            { "hrsh7th/cmp-buffer" },
            { "hrsh7th/cmp-nvim-lsp" },
            { "hrsh7th/cmp-path" },
            { "hrsh7th/cmp-vsnip" },
            { "hrsh7th/vim-vsnip" },
            { "hrsh7th/cmp-nvim-lsp-signature-help" },
        },
        config = function()
            require("jknovi.plugins.cmp").setup()
        end
    },
    {
        "neovim/nvim-lspconfig",
    },
    {
        'VonHeikemen/lsp-zero.nvim',
        branch = 'v2.x',
        dependencies = {
            -- LSP Support
            {'neovim/nvim-lspconfig'},             -- Required
            {                                      -- Optional
                'williamboman/mason.nvim',
                build = function()
                    pcall(cmd, 'MasonUpdate')
                end,
            },
            {'williamboman/mason-lspconfig.nvim'}, -- Optional

            -- Autocompletion
            {'hrsh7th/nvim-cmp'},     -- Required
            {'hrsh7th/cmp-nvim-lsp'}, -- Required
            {'L3MON4D3/LuaSnip'},     -- Required
        }
    },
    {
        'nvim-treesitter/nvim-treesitter',
        build = ':TSUpdate',
    },
    {
        'scalameta/nvim-metals',
        dependencies = {
            {'nvim-lua/plenary.nvim'},
            {'mfussenegger/nvim-dap'}
        }
    },
    { "tpope/vim-fugitive" },
    {
        "windwp/nvim-autopairs",
        event = "InsertEnter",
        config = function()
            require("nvim-autopairs").setup()
        end
    },
})


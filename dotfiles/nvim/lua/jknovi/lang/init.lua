local api = vim.api

api.nvim_create_autocmd("FileType", {
    pattern = {"scala", "gradle", "groovy"},
    callback = function()
        vim.opt_local.shiftwidth = 2
        vim.opt_local.tabstop = 2
    end,
})

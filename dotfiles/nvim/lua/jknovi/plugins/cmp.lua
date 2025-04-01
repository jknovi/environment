local setup = function()
	local cmp = require("cmp")
	cmp.setup({
		sources = {
			{ name = "nvim_lsp", priority = 10 },
			{ name = "buffer" },
			{ name = "vsnip" },
			{ name = "path" },
			{ name = "nvim_lsp_signature_help" },
		},
		snippet = {
			expand = function(args)
				-- Comes from vsnip
				vim.fn["vsnip#anonymous"](args.body)
			end,
        },
        mapping = cmp.mapping.preset.insert({
            ["<CR>"] = cmp.mapping({
                i = function(fallback)
                    if cmp.visible() and cmp.get_active_entry() then
                        cmp.confirm({ behavior = cmp.ConfirmBehavior.Replace, select = false })
                    else
                        fallback()
                    end
                end,
                s = cmp.mapping.confirm({ select = true }),
                c = cmp.mapping.confirm({ behavior = cmp.ConfirmBehavior.Replace, select = true }),
            }),
            ["<Tab>"] = function(fallback)
                if cmp.visible() then
                    cmp.select_next_item()
                else
                    fallback()
                end
            end,
            ["<S-Tab>"] = function(fallback)
                if cmp.visible() then
                    cmp.select_prev_item()
                else
                    fallback()
                end
            end,
        }),
    })
end

return {
	setup = setup,
}

local api = vim.api
local map = vim.keymap.set

local setup = function()
  require("neodev").setup({
    -- add any options here, or leave empty to use the default settings
  })
  local lsp_config = require("lspconfig")
  local capabilities = require("cmp_nvim_lsp").default_capabilities()

  lsp_config.util.default_config = vim.tbl_extend("force", lsp_config.util.default_config, {
    capabilities = capabilities,
  })

  vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, { border = "single" })

  local lsp_group = api.nvim_create_augroup("lsp", { clear = true })

  local on_attach = function(_, bufnr)
    -- LSP agnostic mappings
    map("n", "gD", vim.lsp.buf.definition)
    map("n", "gtD", vim.lsp.buf.type_definition)
    map("n", "K", vim.lsp.buf.hover)
    map("n", "gi", vim.lsp.buf.implementation)
    map("n", "gr", vim.lsp.buf.references)
    map("n", "<leader>sh", vim.lsp.buf.signature_help)
    map("n", "<leader>rn", vim.lsp.buf.rename)
    map("n", "<leader>ca", vim.lsp.buf.code_action)
    map("n", "<leader>cl", vim.lsp.codelens.run)
    map("n", "<leader>awf", vim.lsp.buf.add_workspace_folder)

    map("n", "<leader>o", function()
      vim.lsp.buf.format({ async = true })
    end)

    api.nvim_buf_set_option(bufnr, "omnifunc", "v:lua.vim.lsp.omnifunc")
  end

  -- These server just use the vanilla setup
  local servers = { "bashls", "dockerls", "html", "gopls", "protols" }
  for _, server in pairs(servers) do
    lsp_config[server].setup({ on_attach = on_attach })
  end


  lsp_config.lua_ls.setup({
    on_attach = on_attach,
    commands = {
      Format = {
        function()
          require("stylua-nvim").format_file()
        end,
      },
    },
    settings = {
      Lua = {
        diagnostics = { globals = { "vim", "it", "describe", "before_each" } },
        telemetry = { enable = false },
      },
    },
  })

  lsp_config.clangd.setup{
    on_new_config = function(new_config, new_root_dir)
        if new_root_dir:find("liquid[-]core") then
            new_config.cmd = {
                new_root_dir.."/external/toolchains/clang/bin/clangd",
                "--background-index",
                "--clang-tidy",
                "--cross-file-rename",
                "--header-insertion=iwyu",
            }
        elseif new_root_dir:find("graphane") then
            new_config.cmd = {
                new_root_dir.."/external/toolchains_llvm++llvm+llvm_toolchain_llvm/bin/clangd",
                "--background-index",
                "--clang-tidy",
                "--cross-file-rename",
                "--header-insertion=iwyu",
            }
        else
            new_config.cmd = {
                "/usr/bin/clangd",
                "--background-index",
                "--clang-tidy",
                "--cross-file-rename",
                "--header-insertion=iwyu",
            }
        end
    end,
    on_attach = on_attach,
    root_dir = require('lspconfig.util').root_pattern('compile_commands.json', '.git'),
    on_attach = on_attach 
  }

  -- Uncomment for trace logs from neovim
  -- vim.lsp.set_log_level('trace')
end

return {
  setup = setup,
}

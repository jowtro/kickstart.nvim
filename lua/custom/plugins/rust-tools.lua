return {
  "simrat39/rust-tools.nvim",
  dependencies = { "neovim/nvim-lspconfig", "mfussenegger/nvim-dap" },
  config = function()
    local rt = require("rust-tools")
    rt.setup({
      server = {
        -- This is where rust-analyzer is configured
        settings = {
          ["rust-analyzer"] = {
            cargo = { allFeatures = true },
            checkOnSave = {
              command = "clippy",
            },
          },
        },
      },
    })
  end,
}


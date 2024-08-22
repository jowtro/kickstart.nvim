--+-------------------------------------------------+
--| A | B | C                             X | Y | Z |
--+-------------------------------------------------+
return {
  'nvim-lualine/lualine.nvim',
  dependencies = { 'nvim-tree/nvim-web-devicons' },
  opts = {
    theme = 'gruvbox',
    sections = {
      lualine_c = { "os.date('%a')", 'data', "require'lsp-status'.status()" },
    },
  },
}

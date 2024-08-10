return {
  {
    'akinsho/toggleterm.nvim',
    version = '*',
    config = true,
    opts = {
      vim.keymap.set('n', '<A-h>', '<cmd>ToggleTerm direction=horizontal<CR>', { noremap = true, silent = true, desc = 'Toggle Terminal Horizontal' }),
      vim.keymap.set('n', '<A-v>', '<cmd>ToggleTerm direction=vertical<CR>', { noremap = true, silent = true, desc = 'Toggle Terminal Vertical' }),
    },
  },
}

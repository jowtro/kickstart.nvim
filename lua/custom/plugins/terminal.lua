return {
  {
    'akinsho/toggleterm.nvim',
    version = '*',
    config = true,
    opts = {
      vim.keymap.set('n', '<leader>th', '<cmd>ToggleTerm direction=horizontal<CR>', { noremap = true, silent = true, desc = 'Toggle Terminal Horizontal' }),
      vim.keymap.set('n', '<leader>tv', '<cmd>ToggleTerm direction=vertical<CR>', { noremap = true, silent = true, desc = 'Toggle Terminal Vertical' }),
    },
  },
}

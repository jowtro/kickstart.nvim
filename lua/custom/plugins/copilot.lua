return {
  {
    'github/copilot.vim',
    config = function()
      -- Optional: Configure GitHub Copilot settings
      vim.g.copilot_no_tab_map = true -- Disable default tab mapping
      -- Optional: Map keys to accept or reject suggestions
      -- add accept with tab
      -- add reject with shift-tab
      vim.api.nvim_set_keymap('i', '<Tab>', 'copilot#Accept("<Tab>")', { expr = true, silent = true }) -- Map Tab to accept suggestion
    end,
  },
}

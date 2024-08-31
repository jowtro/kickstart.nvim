return {
  -- other plugins
  {
    "f-person/git-blame.nvim",
    config = function()
      -- Optional: Customize git-blame options here
      vim.g.gitblame_enabled = 1
      vim.g.gitblame_message_template = '<author> • <date> • <summary>'
      vim.g.gitblame_date_format = '%Y-%m-%d'
    end
  },
}

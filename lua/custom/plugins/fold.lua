-- zc  | Close fold
-- zo  | Open fold
-- za  | Toggle fold under cursor (close if open, open if closed)
-- zA  | Toggle all folds under cursor (open all if closed, close all if open)
-- zM  | Close all folds in the file
-- zR  | Open all folds in the file
-- zm  | Increase fold level throughout the buffer
-- zr  | Decrease fold level throughout the buffer
-- zj  | Move to the next fold
-- zk  | Move to the previous fold
-- zd  | Delete the fold under the cursor
-- zE  | Eliminate all folds in the window
return {
  {
    'tmhedberg/SimpylFold',
    ft = 'python',
    config = function()
      -- SimpylFold configuration
      vim.g.SimpylFold_docstring_preview = 1
      vim.g.SimpylFold_fold_docstring = 0
      vim.g.SimpylFold_fold_import = 0
    end,
  },
}

return function()
  local python_install_path = "/home/jowtro/.local/share/nvim/mason/packages/debugpy/venv/bin/python"
  require('dap-python').setup(python_install_path) -- Debug with default settings.

  -- We can set additional custom config by below mechanism as well
  --[[
    table.insert(require('dap').configurations.python,
    {
      type = 'python',
      request = 'launch',
      name = 'My custom launch configuration',
      program = '${file}',
      cwd = vim.fn.getcwd(),
      console= "integratedTerminal",
    })
    --]]
  -- insert remote Atach configuration
  table.insert(require('dap').configurations.python, {
    -- This is the same configuration as in your VSCode file
    name = 'Python: Remote Attach',
    type = 'python',
    request = 'attach',
    connect = {
      host = '127.0.0.1',
      port = 5678,
    },
    pathMappings = {
      {
        localRoot = vim.fn.getcwd(), -- Maps to the current working directory in Neovim
        remoteRoot = '.', -- Adjust this to match your remote directory structure
      },
    },
    justMyCode = true,
  })
  table.insert(require('dap').configurations.python, {
    name = 'Pytest: Current File',
    type = 'python',
    request = 'launch',
    module = 'pytest',
    args = {
      '${file}',
      '-sv',
      '--log-cli-level=INFO',
      '--log-file=test_out.log',
    },
    console = 'integratedTerminal',
  })
  table.insert(require('dap').configurations.python, {
    name = 'Profile python: Current File',
    type = 'python',
    request = 'launch',
    module = 'cProfile',
    args = {
      '-o',
      '/tmp/profile.dat',
      '${file}',
    },
    console = 'integratedTerminal',
  })
end

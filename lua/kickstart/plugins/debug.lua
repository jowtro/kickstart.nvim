-- debug.lua
--
-- Shows how to use the DAP plugin to debug your code.
--
-- Primarily focused on configuring the debugger for Go, but can
-- be extended to other languages as well. That's why it's called
-- kickstart.nvim and not kitchen-sink.nvim ;)
-- debug.lua
--
-- Shows how to use the DAP plugin to debug your code.
--
-- Primarily focused on configuring the debugger for Go, but can
-- be extended to other languages as well. That's why it's called
-- kickstart.nvim and not kitchen-sink.nvim ;)

return {
  -- NOTE: Yes, you can install new plugins here!
  'mfussenegger/nvim-dap',

  -- NOTE: And you can specify dependencies as well
  dependencies = {
    -- Creates a beautiful debugger UI
    'rcarriga/nvim-dap-ui',
    -- Required dependency for nvim-dap-ui
    'nvim-neotest/nvim-nio',
    -- Installs the debug adapters for you
    'williamboman/mason.nvim',
    'jay-babu/mason-nvim-dap.nvim',

    -- Add your own debuggers here
    'leoluz/nvim-dap-go',
    'mfussenegger/nvim-dap-python',
  },

  config = function()
    local dap = require 'dap'
    local dapui = require 'dapui'
    -- Function to get the pipenv Python path
      local function get_pipenv_python()
        local handle = io.popen('pipenv --venv 2>/dev/null')
        if handle == nil then
          return nil
        end
        local result = handle:read("*a")
        handle:close()
        local venv_path = vim.fn.trim(result)
        if venv_path == '' then
          return nil
        else
          return venv_path .. '/bin/python'
        end
      end

      -- Set up DAP adapter for Python using pipenv
      dap.adapters.python = {
        type = 'executable',
        command = get_pipenv_python() or '/usr/bin/python3',  -- Use pipenv Python if available, otherwise global
        args = { '-m', 'debugpy.adapter' },
      }

      dap.configurations.python = {
        {
          type = 'python',
          request = 'launch',
          name = 'Launch file',
          program = '${file}',
          pythonPath = get_pipenv_python() or '/usr/bin/python3',  -- Use pipenv Python if available, otherwise global
        },
      }
    require('mason-nvim-dap').setup {
      -- Makes a best effort to setup the various debuggers with
      -- reasonable debug configurations
      automatic_setup = true,

      -- You can provide additional configuration to the handlers,
      -- see mason-nvim-dap README for more information
      -- In below way also we can setup debugger for python
      -- Need to install pip3 install debugpy. In dockerfile it is already there. If you are using configuation alone
      -- without dockerfile then install debugpy or mention the python path where debugpy is installed.

      handlers = {
        -- python debug configuration is moved to this file
        python = require 'kickstart.plugins.dap.handler.python',
      },

      -- You'll need to check that you have the required things installed
      -- online, please don't ask me how to install them :)
      ensure_installed = {
        -- Update this to ensure that you have the debuggers for the langs you want
        'python',
      },
    }

    -- You can provide additional configuration to the handlers,
    -- see mason-nvim-dap README for more information
    -- require('mason-nvim-dap').setup_handlers()

    -- Basic debugging keymaps, feel free to change to your liking!

    vim.keymap.set('n', '<F5>', function()
      dap.continue()
      --vim.cmd.Neotree 'toggle' -- this will toggle the Neo tree during debugging
    end)
    vim.keymap.set('n', '<F11>', dap.step_into, { desc = 'DEBUG: Step into' })
    vim.keymap.set('n', '<F10>', dap.step_over, { desc = 'DEBUG: Step over' })
    vim.keymap.set('n', '<F4>', dap.step_out, { desc = 'DEBUG: Step out' })
    vim.keymap.set('n', '<F9>', dap.toggle_breakpoint, { desc = 'DEBUG: Toggle breakpoint' })
    vim.keymap.set('n', '<leader>B', function()
      dap.set_breakpoint(vim.fn.input 'Breakpoint condition: ')
    end, { desc = 'DEBUG: Set breakpoint condition' })

    -- toggle to see last session result. Without this ,you can't see session output in case of unhandled exception.
    vim.keymap.set('n', '<F7>', dapui.toggle)

    -- Debug breakpoint will be in color
    vim.api.nvim_set_hl(0, 'blue', { fg = '#3d59a1', bg = '#FFFF00' })
    vim.api.nvim_set_hl(0, 'green', { fg = '#9ece6a', bg = '#FFFF00' })
    vim.api.nvim_set_hl(0, 'yellow', { fg = '#FAFA33', bg = '#FFFa05' })
    vim.api.nvim_set_hl(0, 'black', { fg = '#000000', bg = '#FFFF00' })
    --vim.fn.sign_define('DapBreakpoint', { text = '🐞', texthl = 'blue', linehl = 'black', numhl = 'yellow' })
    --vim.fn.sign_define('DapStopped', { text = '', texthl = 'green', linehl = 'black',numhl = 'yellow'  })
    vim.fn.sign_define('DapBreakpoint', { text = '🐞', texthl = 'blue', linehl = '', numhl = '' })
    vim.fn.sign_define('DapStopped', { text = '', texthl = 'green', linehl = '', numhl = '' })

    -- Dap UI setup
    -- For more information, see |:help nvim-dap-ui|
    dapui.setup {
      -- Set icons to characters that are more likely to work in every terminal.
      --    Feel free to remove or use ones that you like more! :)
      --    Don't feel like these are good choices.
      icons = { expanded = '▾', collapsed = '▸', current_frame = '*' },
      controls = {
        icons = {
          pause = '',
          play = '',
          step_into = '',
          step_over = '',
          step_out = '',
          step_back = '',
          run_last = '↻',
          terminate = '□',
          disconnect = '⏏',
        },
      },
    }

    dap.listeners.after.event_initialized['dapui_config'] = dapui.open
    dap.listeners.before.event_terminated['dapui_config'] = dapui.close
    dap.listeners.before.event_exited['dapui_config'] = dapui.close
    -- Install python specific config can be done below way as well instead of handler
    --[[
    require('dap-python').setup() -- Debug with default settings.
    -- We can set additional custom config by below mechanism as well
    table.insert(require('dap').configurations.python, {
      type = 'python',
      request = 'launch',
      name = 'My custom launch configuration',
      program = '${file}',
      cwd = vim.fn.getcwd(),
      console= "integratedTerminal",       
    })
    --]]
  end,
}

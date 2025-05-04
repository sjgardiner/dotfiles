return {
  { "rcarriga/nvim-dap-ui",
    dependencies = {
      { "mfussenegger/nvim-dap",
        dependencies = {
          {
            "jay-babu/mason-nvim-dap.nvim",
            dependencies = "williamboman/mason.nvim",
            cmd = { "DapInstall", "DapUninstall" },
          }
        },
        keys = {
          { "<leader>d", "", desc = "+debug", mode = {"n", "v"} },
          { "<leader>dB", function() require("dap").set_breakpoint(vim.fn.input('Breakpoint condition: ')) end, desc = "Breakpoint Condition" },
          { "<leader>db", function() require("dap").toggle_breakpoint() end, desc = "Toggle Breakpoint" },
          { "<leader>dc", function() require("dap").continue() end, desc = "Continue" },
          --{ "<leader>da", function() require("dap").continue({ before = get_args }) end, desc = "Run with Args" },
          { "<leader>dC", function() require("dap").run_to_cursor() end, desc = "Run to Cursor" },
          { "<leader>dg", function() require("dap").goto_() end, desc = "Go to Line (No Execute)" },
          { "<leader>di", function() require("dap").step_into() end, desc = "Step into" },
          { "<leader>dj", function() require("dap").down() end, desc = "Down" },
          { "<leader>dk", function() require("dap").up() end, desc = "Up" },
          { "<leader>dl", function() require("dap").run_last() end, desc = "Run Last" },
          { "<leader>do", function() require("dap").step_out() end, desc = "Step Out" },
          { "<leader>dO", function() require("dap").step_over() end, desc = "Step Over" },
          { "<leader>dp", function() require("dap").pause() end, desc = "Pause" },
          { "<leader>dr", function() require("dap").repl.toggle() end, desc = "Toggle REPL" },
          { "<leader>ds", function() require("dap").session() end, desc = "Session" },
          { "<leader>ds", function() require("dap").terminate() end, desc = "Terminate" },
          { "<leader>ds", function() require("dap.ui.widgets").hover() end, desc = "Widgets" },
        },
        config = function()
          require('mason').setup()
          require('mason-nvim-dap').setup({
            automatic_installation = true,
            automatic_setup = true,
            handlers = {},
            ensure_installed = { 'codelldb' },
          })

          local dap = require("dap")
          dap.configurations.cpp = {
            {
              name = "Launch file",
              type = "codelldb",
              request = "launch",
              program = function()
                return vim.fn.input('Path to executable: ',
                  vim.fn.getcwd() .. '/', 'file')
              end,
              cwd = '${workspaceFolder}',
              stopAtEntry = true,
            },
          }
          dap.configurations.c = dap.configurations.cpp
        end,
      },
      "nvim-neotest/nvim-nio",
    }
  }
}

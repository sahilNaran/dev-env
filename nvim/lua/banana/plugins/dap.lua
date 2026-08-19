return {
  "mfussenegger/nvim-dap",
  dependencies = {
    "rcarriga/nvim-dap-ui",
    "nvim-neotest/nvim-nio",
    "theHamsta/nvim-dap-virtual-text",
    "williamboman/mason.nvim",
    "jay-babu/mason-nvim-dap.nvim",
  },
  config = function()
    local dap = require("dap")
    local dapui = require("dapui")

    require("mason-nvim-dap").setup({
      ensure_installed = { "codelldb" },
      automatic_installation = true,
      handlers = {},
    })

    dapui.setup()
    require("nvim-dap-virtual-text").setup({})

    -- Open/close DAP UI automatically
    dap.listeners.before.attach.dapui_config = function() dapui.open() end
    dap.listeners.before.launch.dapui_config = function() dapui.open() end
    dap.listeners.before.event_terminated.dapui_config = function() dapui.close() end
    dap.listeners.before.event_exited.dapui_config = function() dapui.close() end

    -- codelldb adapter (installed via mason)
    local mason_path = vim.fn.stdpath("data") .. "/mason"
    local codelldb_path = mason_path .. "/packages/codelldb/extension/adapter/codelldb"
    dap.adapters.codelldb = {
      type = "server",
      port = "${port}",
      executable = {
        command = codelldb_path,
        args = { "--port", "${port}" },
      },
    }

    dap.configurations.cpp = {
      {
        name = "Launch (codelldb)",
        type = "codelldb",
        request = "launch",
        program = function()
          return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
        end,
        cwd = "${workspaceFolder}",
        stopOnEntry = false,
        args = function()
          local input = vim.fn.input("Args: ")
          return vim.split(input, " ", { trimempty = true })
        end,
      },
    }
    dap.configurations.c = dap.configurations.cpp

    local sign = vim.fn.sign_define
    sign("DapBreakpoint", { text = "●", texthl = "DiagnosticError", linehl = "", numhl = "" })
    sign("DapBreakpointCondition", { text = "◆", texthl = "DiagnosticWarn", linehl = "", numhl = "" })
    sign("DapStopped", { text = "▶", texthl = "DiagnosticInfo", linehl = "Visual", numhl = "" })

    local map = function(lhs, rhs, desc)
      vim.keymap.set("n", lhs, rhs, { desc = desc })
    end
    map("<leader>db", dap.toggle_breakpoint, "Toggle breakpoint")
    map("<leader>dB", function() dap.set_breakpoint(vim.fn.input("Condition: ")) end, "Conditional breakpoint")
    map("<leader>dc", dap.continue, "Continue / Start")
    map("<leader>dC", dap.run_to_cursor, "Run to cursor")
    map("<leader>do", dap.step_over, "Step over")
    map("<leader>di", dap.step_into, "Step into")
    map("<leader>dO", dap.step_out, "Step out")
    map("<leader>dr", dap.repl.toggle, "Toggle REPL")
    map("<leader>dl", dap.run_last, "Run last")
    map("<leader>dq", dap.terminate, "Terminate")
    map("<leader>du", dapui.toggle, "Toggle DAP UI")
    map("<leader>de", function() dapui.eval(nil, { enter = true }) end, "Eval expression")
  end,
}

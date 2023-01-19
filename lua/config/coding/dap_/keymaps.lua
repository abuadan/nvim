local M = {}
local wk = require "which-key"

function M.setup()
  local keymap = {
    d = {
      name = "Debug",
      ------ toggle breakpoints
      C = { "<cmd>lua require'dap'.set_breakpoint(vim.fn.input '[Condition] > ')<cr>", "Conditional Breakpoint" },
      t = { "<cmd>lua require'dap'.toggle_breakpoint()<cr>", "Toggle Breakpoint" },
      ------ Whilst running
      s = { "<cmd>lua require'dap'.continue()<cr>", "Start" },
      c = { "<cmd>lua require'dap'.continue()<cr>", "Continue" },
      i = { "<cmd>lua require'dap'.step_into()<cr>", "Step Into" },
      o = { "<cmd>lua require'dap'.step_over()<cr>", "Step Over" },
      b = { "<cmd>lua require'dap'.step_back()<cr>", "Step Back" },
      u = { "<cmd>lua require'dap'.step_out()<cr>", "Step Out" },
      R = { "<cmd>lua require'dap'.run_to_cursor()<cr>", "Run to Cursor" },
      ------ Stop/Disconnect
      p = { "<cmd>lua require'dap'.pause.toggle()<cr>", "Pause" },
      q = { "<cmd>lua require'dap'.close()<cr>", "Quit" },
      d = { "<cmd>lua require'dap'.disconnect()<cr>", "Disconnect" },
      x = { "<cmd>lua require'dap'.terminate()<cr>", "Terminate" },
      ------
      E = { "<cmd>lua require'dapui'.eval(vim.fn.input '[Expression] > ')<cr>", "Evaluate Input" },
      U = { "<cmd>lua require'dapui'.toggle()<cr>", "Toggle UI" },
      e = { "<cmd>lua require'dapui'.eval()<cr>", "Evaluate" },
      g = { "<cmd>lua require'dap'.session()<cr>", "Get Session" },
      h = { "<cmd>lua require'dap.ui.widgets'.hover()<cr>", "Hover Variables" },
      S = { "<cmd>lua require'dap.ui.widgets'.scopes()<cr>", "Scopes" },
      ------
      r = { "<cmd>lua require'dap'.repl.toggle()<cr>", "Toggle Repl" },
    },
  }

  wk.register(keymap, {
    mode = "n",
    prefix = "<leader>",
    buffer = nil,
    silent = true,
    noremap = true,
    nowait = false,
  })

  local keymap_v = {
    name = "Debug",
    e = { "<cmd>lua require'dapui'.eval()<cr>", "Evaluate" },
  }
  wk.register(keymap_v, {
    mode = "v",
    prefix = "<leader>",
    buffer = nil,
    silent = true,
    noremap = true,
    nowait = false,
  })
end

return M

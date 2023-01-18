local M = {}
local dap = require "dap"

-- extensions
local dapui = require "dapui"
local dapui_config = require("config.coding.dap_.ui").config()
local nvim_dap_virtual_text = require "nvim-dap-virtual-text"

-- Debuggers
local dap_python = require "config.coding.dap_.debuggers.python"
local node_dap = require "config.coding.dap_.debuggers.node"
local go_dap = require "config.coding.dap_.debuggers.go"
local typescript_dap = require "config.coding.dap_.debuggers.typescript"
local rust_dap = require "config.coding.dap_.debuggers.rust"

local highlight_groups = function()
  vim.api.nvim_set_hl(0, "DapBreakpoint", { default = true, bg = "#31353f" })
  vim.api.nvim_set_hl(0, "DapLogPoint", { default = true, fg = "#61afef", bg = "#31353f" })
  vim.api.nvim_set_hl(0, "DapStopped", { default = true, fg = "#98c379", bg = "#31353f" })

  vim.fn.sign_define("DapBreakpoint", { text = "🔴", texthl = "", linehl = "DapBreakpoint", numhl = "" })
  vim.fn.sign_define("DapBreakpointCondition", { text = "ﳁ", texthl = "", linehl = "DapBreakpoint", numhl = "" })
  vim.fn.sign_define("DapLogPoint", { text = "", texthl = "", linehl = "DapLogPoint", numhl = "DapLogPoint" })
  vim.fn.sign_define("DapStopped", { text = "🟥", texthl = "", linehl = "DapBreakpoint", numhl = "" })
  vim.fn.sign_define("DapBreakpointRejected", { text = "❌", texthl = "", linehl = "DapBreakpoint", numhl = "" })
end

local dap_extensions = function()
  nvim_dap_virtual_text.setup()
  dapui.setup(dapui_config)
  -- Open and close dapui automatically
  dap.listeners.after.event_initialized["dapui_config"] = function()
    dapui.open()
  end
  dap.listeners.before.event_terminated["dapui_config"] = function()
    dapui.close()
  end
  dap.listeners.before.event_exited["dapui_config"] = function()
    dapui.close()
  end
end

local configurations = function()
  dap_python.setup()
  node_dap.setup()
  go_dap.setup()
  typescript_dap.setup()
end

function M.setup()
  configurations()
  dap_extensions()
  highlight_groups()
end
return M

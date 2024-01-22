local M = {}
local dap = require "dap"

local adapters = {
  go = {
    type = "executable",
    command = "node",
    args = { os.getenv "XDG_DATA_HOME" .. "/debuggers/vscode-go/dist/debugAdapter.js" },
  },
  delve = {
    type = "server",
    port = "${port}",
    executable = {
      command = "dlv",
      args = { "dap", "-l", "127.0.0.1:${port}" },
    },
  },
}
local configurations = {
  {
    type = "go",
    name = "Debug",
    request = "launch",
    showLog = true,
    program = "${file}",
    -- console = "externalTerminal",
    dlvToolPath = vim.fn.exepath "dlv",
  },
  {
    name = "Test Current File",
    type = "go",
    request = "launch",
    showLog = true,
    mode = "test",
    program = ".",
    dlvToolPath = vim.fn.exepath "dlv",
  },
}

function M.setup()
  dap.adapters.go = adapters.go
  dap.adapters.delve = adapters.delve

  dap.configurations.go = configurations
end
return M

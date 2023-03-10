local M = {}
local dap = require "dap"
local dap_utils = require "dap.utils"

local adapters = {
  type = "executable",
  command = "node",
  args = { os.getenv "XDG_DATA_HOME" .. "/debuggers/microsoft/vscode-node-debug2/out/src/nodeDebug.js" },
}

local configurations = {
  {
    name = "Launch",
    type = "node2",
    request = "launch",
    program = "${file}",
    cwd = vim.fn.getcwd(),
    sourceMaps = true,
    protocol = "inspector",
    console = "integratedTerminal",
  },
  {
    -- For this to work you need to make sure the node process is started with the `--inspect` flag.
    name = "Attach to process",
    type = "node2",
    request = "attach",
    processId = dap_utils.pick_process,
  },
}

function M.setup()
  dap.adapters.node = adapters
  dap.adapters.node2 = adapters
  dap.configurations.javascript = configurations
end
return M

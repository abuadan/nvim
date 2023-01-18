local M = {}
local dap = require "dap"

local adapters = {
  {
    type = "executable",
    command = "node",
    args = { os.getenv "XDG_DATA_HOME" .. "/debuggers/vscode-chrome-debug/out/src/chromeDebug.js" },
  },
}

local configuration = {
  {
    type = "chrome",
    request = "attach",
    program = "${file}",
    cwd = vim.fn.getcwd(),
    sourceMaps = true,
    protocol = "inspector",
    port = 9222,
    webRoot = "${workspaceFolder}",
  },
}

function M.setup()
  dap.adapters.javascript = adapters
  dap.configurations.typescript = configuration
end
return M

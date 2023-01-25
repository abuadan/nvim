local M = {}
local dap = require "dap"

local chrome = {
  type = "executable",
  command = "node",
  args = { os.getenv "XDG_DATA_HOME" .. "/debuggers/vscode-chrome-debug/out/src/chromeDebug.js" },
}

local firefox = {
  type = "executable",
  command = "node",
  args = { os.getenv "XDG_DATA_HOME" .. "/debuggers/vscode-firefox-debug/dist/adapter.bundle.js" },
}

function M.setup()
  dap.adapters.chrome = chrome
  dap.adapters.firefox = firefox
  dap.configurations.typescriptreact = {
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
  dap.configurations.javascriptreact = {
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
  dap.configurations.typescript = {
    {
      name = "Debug with Firefox",
      type = "firefox",
      request = "launch",
      reAttach = true,
      url = "http://localhost:3000",
      webRoot = "${workspaceFolder}",
      firefoxExecutable = "/usr/bin/firefox",
    },
  }
end
return M

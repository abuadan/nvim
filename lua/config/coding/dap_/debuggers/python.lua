local M = {}
local dap_python = require "dap-python"

function M.setup()
  dap_python.setup(vim.fn.executable "pyenv prefix" .. "envs/neovim/bin/python")
end
return M

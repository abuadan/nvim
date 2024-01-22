local M = {}
local dap_python = require "dap-python"

function M.setup()
  dap_python.setup(os.getenv "PYENV_ROOT" .. "/versions/neovim/bin/python")
  dap_python.test_runner = "pytest"
end
return M

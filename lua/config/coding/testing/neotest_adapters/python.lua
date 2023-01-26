local M = {}
local utils = require "utils.functions"
local test = require "neotest-python"

function M.adapter()
  return test {
    dap = { justMyCode = false },
    runner = "pytest",
    args = { "--log-level", "DEBUG" },
    python = function()
      return utils.find_python()
    end,
  }
end
return M

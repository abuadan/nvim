local M = {}
local neotest = require "neotest"
local python = require "config.coding.testing.neotest_adapters.python"

function M.setup()
  neotest.setup {
    adapters = {
      python.adapter(),
      require "neotest-jest",
      require "neotest-go",
      require "neotest-plenary",
      require "neotest-vim-test" {
        ignore_file_types = { "python", "vim", "lua" },
      },
    },
  }
end

return M

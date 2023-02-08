local M = {}
local neotest = require "neotest"
local overseer = require "neotest.consumers.overseer"

local utils = require "utils.functions"

function M.setup()
  neotest.setup {
    adapters = {
      require "neotest-python" {
        dap = { justMyCode = false },
        runner = "pytest",
        args = { "--log-level", "DEBUG", "-vvv" },
        python = function()
          return utils.find_python()
        end,
      },
      require "neotest-jest",
      require "neotest-go",
      require "neotest-plenary",
      require "neotest-rust",
      require "neotest-vim-test" {
        ignore_file_types = { "python", "vim", "lua", "rust" },
      },
    },
    consumers = {
      overseer = overseer,
    },
    overseer = {
      enabled = true,
      -- When this is true (the default), it will replace all neotest.run.* commands
      force_default = false,
    },
    log_level = vim.log.levels.DEBUG,
  }
end

return M

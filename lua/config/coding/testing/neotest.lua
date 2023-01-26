local M = {}
local neotest = require "neotest"
local overseer = require "neotest.consumers.overseer"

local python = require "config.coding.testing.neotest_adapters.python"
local javascript = require "config.coding.testing.neotest_adapters.javascript"
local go = require "config.coding.testing.neotest_adapters.go"

function M.setup()
  neotest.setup {
    adapters = {
      python.adapter(),
      javascript.setup(),
      go.setup(),
      require "neotest-plenary",
      require "neotest-vim-test" {
        ignore_file_types = { "python", "vim", "lua" },
      },
    },
    -- consumers = {
    --   overseer = overseer,
    -- },
    -- overseer = {
    --   enabled = true,
    --   -- When this is true (the default), it will replace all neotest.run.* commands
    --   force_default = false,
    -- },
  }
  local not_okay, _ = pcall(require, "neotest.run")
  if not_okay then
    print "neotest run not avaliable "
  end
end

function M.print_this()
  for i, d in ipairs(neotest) do
    print(d.run)
    print(i.run)
  end
end

return M

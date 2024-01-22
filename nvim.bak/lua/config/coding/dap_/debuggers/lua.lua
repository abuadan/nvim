local M = {}

local dap = require "dap"

local configurations = {
  {
    type = "nlua",
    request = "attach",
    name = "Attach to running Neovim instance",
  },
}

function M.setup()
  dap.configurations.lua = configurations
  dap.adapters.nlua = function(callback, config)
    callback { type = "server", host = config.host or "127.0.0.1", port = config.port or 8086 }
  end
end

return M

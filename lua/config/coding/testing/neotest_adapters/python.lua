local M = {}
local test = require "neotest-python"

function M.adapter()
  return test {
    dap = { justMyCode = false },
    runner = "pytest",
    args = { "--log-level", "DEBUG" },
    python = function()
      local cwd = vim.fn.getcwd()

      if os.getenv "VIRTUAL_ENV" then
        return os.getenv "VIRTUAL_ENV" .. "/bin/python"
      elseif vim.fn.executable(cwd .. "/venv/bin/python") == 1 then
        return cwd .. "/venv/bin/python"
      elseif vim.fn.executable(cwd .. "/.venv/bin/python") == 1 then
        return cwd .. "/.venv/bin/python"
      else
        return os.getenv "PYENV_ROOT" .. "versions/neovim/bin/python"
      end
    end,
  }
end
return M

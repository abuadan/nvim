local M = {}
local rt = require "rust-tools"
-- debugger

local extension_path = vim.env.HOME .. "~/.vscode/extensions/vadimcn.vscode-lldb-1.8.1"
local codelldb_path = extension_path .. "adapter/codelldb"
local liblldb_path = extension_path .. "lldb/lib/liblldb.dylib" -- MacOS: This may be .dylib or .so for linux

local on_attach = function(_, bufnr)
  local bufopts = { noremap = true, silent = true, buffer = bufnr }

  vim.keymap.set("n", "gi", vim.lsp.buf.implementation, bufopts)
  vim.keymap.set("n", "gD", vim.lsp.buf.declaration, bufopts)
  vim.keymap.set("n", "gy", vim.lsp.buf.type_definition, bufopts)
  vim.keymap.set("n", "gd", vim.lsp.buf.definition, bufopts)
  -- Hover actions
  vim.keymap.set("n", "<Leader>ca", rt.hover_actions.hover_actions, bufopts)
  -- Code action groups
  vim.keymap.set("n", "<Leader>a", rt.code_action_group.code_action_group, bufopts)
end

local inlay_hints = {
  -- automatically set inlay hints (type hints)
  -- default: true
  auto = true,

  -- Only show inlay hints for the current line
  only_current_line = false,

  -- whether to show parameter hints with the inlay hints or not
  -- default: true
  show_parameter_hints = true,

  -- prefix for parameter hints
  -- default: "<-"
  parameter_hints_prefix = "<- ",

  -- prefix for all the other hints (type, chaining)
  -- default: "=>"
  other_hints_prefix = "=> ",

  -- whether to align to the length of the longest line in the file
  max_len_align = false,

  -- padding from the left if max_len_align is true
  max_len_align_padding = 1,

  -- whether to align to the extreme right or not
  right_align = false,

  -- padding from the right if right_align is true
  right_align_padding = 7,

  -- The color of the hints
  highlight = "Comment",
}

local opts = {
  -- automatically call RustReloadWorkspace when writing to a Cargo.toml file.
  reload_workspace_from_cargo_toml = true,
  inlay_hints = inlay_hints,
  -- These apply to the default RustSetInlayHints command
  -- options same as lsp hover / vim.lsp.util.open_floating_preview()
  hover_actions = {

    -- Maximal width of the hover window. Nil means no max.
    max_width = nil,

    -- Maximal height of the hover window. Nil means no max.
    max_height = nil,

    -- whether the hover action window gets automatically focused
    -- default: false
    auto_focus = false,
  },
  -- all the opts to send to nvim-lspconfig
  -- these override the defaults set by rust-tools.nvim
  -- see https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md#rust_analyzer
  server = {
    on_atach = on_attach,
    -- standalone file support
    -- setting it to false may improve startup time
    standalone = true,
  }, -- rust-analyzer options

  -- debugging stuff
  dap = {
    adapter = require("rust-tools.dap").get_codelldb_adapter(codelldb_path, liblldb_path),
  },
}

function M.setup()
  rt.setup(opts)
end
return M

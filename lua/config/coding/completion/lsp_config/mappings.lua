local M = {}
local noice_lsp = require "noice.lsp"

function M.mappings(client, bufnr)
  -- Enable completion triggered by <c-x><c-o>
  vim.api.nvim_buf_set_option(bufnr, "omnifunc", "v:lua.vim.lsp.omnifunc")

  -- Mappings.
  --   -- See `:help vim.lsp.*` for documentation on any of the below functions
  local bufopts = { noremap = true, silent = true, buffer = bufnr }

  -- Go to Definition
  vim.keymap.set("n", "gd", "<cmd>Lspsaga goto_definition<CR>", bufopts)
  vim.keymap.set("n", "gr", "<cmd>Lspsaga lsp_finder<CR>", bufopts)
  -- vim.keymap.set("n", "gr", "<cmd>Telescope lsp_references<CR>", bufopts)

  vim.keymap.set("n", "gp", "<cmd>Lspsaga peek_definition<CR>", bufopts)

  vim.keymap.set("n", "gy", vim.lsp.buf.type_definition, bufopts)
  -- vim.keymap.set("n", "gd", vim.lsp.buf.definition, bufopts)
  -- vim.keymap.set("n", "gr", vim.lsp.buf.references, bufopts)

  -- Declaration and implementation seems to be broken for some servres
  -- vim.keymap.set("n", "gi", vim.lsp.buf.implementation, bufopts)
  vim.keymap.set("n", "gD", vim.lsp.buf.declaration, bufopts)

  -- Signature help
  -- TODO: need to find a better ui for this
  vim.keymap.set("n", "<C-k>", vim.lsp.buf.signature_help, bufopts)

  -- Hover
  -- vim.keymap.set("n", "K", "<CMD>Lspsaga hover_doc<CR>", bufopts)
  vim.keymap.set("n", "K", vim.lsp.buf.hover, bufopts)

  vim.keymap.set("n", "<c-f>", function()
    if not noice_lsp.scroll(4) then
      return "<c-f>"
    end
  end, { silent = true, expr = true })

  vim.keymap.set("n", "<c-b>", function()
    if not noice_lsp.scroll(-4) then
      return "<c-b>"
    end
  end, { silent = true, expr = true })
  -- Rename
  vim.keymap.set("n", "<leader>rn", function()
    return ":IncRename " .. vim.fn.expand "<cword>"
  end, { expr = true })

  -- Workspaces
  vim.keymap.set("n", "<space>wa", vim.lsp.buf.add_workspace_folder, bufopts)
  vim.keymap.set("n", "<space>wr", vim.lsp.buf.remove_workspace_folder, bufopts)

  -- Toggle Outline
  vim.keymap.set("n", "<leader>o", "<cmd>Lspsaga outline<CR>", bufopts)

  -- Callhierarchy
  vim.keymap.set("n", "<Leader>ci", "<cmd>Lspsaga incoming_calls<CR>", bufopts)
  vim.keymap.set("n", "<Leader>co", "<cmd>Lspsaga outgoing_calls<CR>", bufopts)

  -- Code Action
  if client.supports_method "textDocument/codeAction" then
    vim.keymap.set("n", "<space>ca", "<CMD>CodeActionMenu<CR>", bufopts)

    vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
      callback = function()
        require("nvim-lightbulb").update_lightbulb()
      end,
      buffer = bufopts.buffer,
      desc = "Update the LightBulb",
    })
  end

  vim.keymap.set("n", "<leader>o", "<cmd>Lspsaga outline<CR>", bufopts)
  -- Telescope lsp mappings
  vim.keymap.set("n", "<Leader>fr", "<CMD>Telescope lsp_definitions<CR>", bufopts)
  vim.keymap.set("n", "<Leader>fo", "<CMD>Telescope lsp_references<CR>", bufopts)
  vim.keymap.set("n", "<Leader>ft", "<CMD>Telescope lsp_type_definitions<CR>", bufopts)

  -- Trouble
  vim.keymap.set("n", "<leader>tr", "<CMD> Trouble lsp_references <CR>", bufopts)
end

return M

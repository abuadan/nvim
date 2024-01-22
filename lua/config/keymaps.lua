-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
vim.keymap.set("n", "-", "<CMD>Oil<CR>", { desc = "Launch Oil" })
vim.keymap.set("n", "<Tab>", function()
  vim.cmd((vim.bo.filetype == "oil") and "bd" or "Oil")
end)

local keymap = vim.keymap.set
local opts = { noremap = true, silent = true }

-- cellular atomoton
vim.keymap.set("n", "<leader>fml", "<cmd>CellularAutomaton make_it_rain<CR>")

-- Window Picker
vim.keymap.set("n", "<leader>w", function()
  local picker = require "window-picker"
  local picked_window_id = picker.pick_window() or vim.api.nvim_get_current_win()
  vim.api.nvim_set_current_win(picked_window_id)
end, { desc = "Pick a window" })

-- Better copy/delete
-- next greatest remap ever : asbjornHaland
keymap({ "n", "v" }, "<leader>y", [["+y]], opts)
keymap("n", "<leader>Y", [["+Y]])

keymap({ "n", "v" }, "<leader>d", [["_d]], opts)

-- Better Motion
keymap("n", "J", "mzJ`z", opts)
keymap("n", "<C-d>", "<C-d>zz", opts)
keymap("n", "<C-s>", "<C-s>zz", opts)
keymap("n", "<C-u>", "<C-u>zz", opts)
keymap("n", "n", "nzzzv", opts)
keymap("n", "N", "Nzzzv", opts)

-- save in insert mode
keymap("i", "<C-s>", "<cmd>:w<cr><esc>")
-- replace current word
keymap("n", "<C-c>", "<cmd>normal ciw<cr>a")

-- better indenting
keymap("v", "<", "<gv")
keymap("v", ">", ">gv")

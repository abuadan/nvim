-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here
local opt = vim.opt

opt.number = true
opt.relativenumber = true -- Relative line numbers
opt.cursorline = true

opt.undofile = true

-- Don't have `o` add a comment
opt.formatoptions:remove("o")

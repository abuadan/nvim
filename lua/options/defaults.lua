---@diagnostic disable: assign-type-mismatch
-- local api = vim.api
local g = vim.g
local opt = vim.opt
-- local cmd = vim.cmd

-- disable netrw at the very start of your init.lua (strongly advised)
g.loaded_netrw = 1
g.loaded_netrwPlugin = 1

-- set termguicolors to enable highlight groups
-- For dark theme (neovim's default)
vim.o.background = "dark"
opt.termguicolors = true
g.mapleader = " "
g.maplocalleader = ","
g.vimsyn_embed = "lPr" -- Syntax embedding for Lua, Python and Ruby

opt.hlsearch = false --highlight on search
opt.incsearch = true
opt.number = true --Make line numbers default
opt.relativenumber = true --Make relative number default
opt.mouse = "a" --Enable mouse mode
g.is_mouse_enabled = 1
--[[ opt.mouse:append 'nicer' ]]
opt.breakindent = true --Enable break indent
opt.undofile = true --Save undo history
opt.ignorecase = true --Case insensitive searching unless /C or capital in search
opt.smartcase = true -- Smart case
opt.cursorline = true
opt.signcolumn = "yes" -- Always show sign column
opt.wildignorecase = true
opt.clipboard = "unnamedplus"
opt.splitbelow = true
opt.splitright = true

opt.list = true
opt.listchars:append "eol:↴"
-- opt.listchars:append "trail:"

--[[ opt.noshowmode = true ]]
opt.wildmode = "longest"
opt.wildmode:append "full"
opt.wildmenu = true
--[[ opt.shortmess = 'c' ]]

opt.updatetime = 300 --Decrease update time
opt.encoding = "utf-8"
opt.hidden = true
opt.cmdheight = 2 -- 0
vim.o.timeout = true
vim.o.timeoutlen = 300

opt.wildignorecase = true
opt.wildignore:append "**/node_modules/*"
opt.wildignore:append "**/.git/*"

-- langugae paths
g.python3_host_prog = os.getenv "PYENV_ROOT" .. "/versions/neovim/bin/python"

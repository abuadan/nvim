local packer = require "packer"
local use = packer.use
local g = vim.g
local cmd = vim.cmd

-- Themes
use {
  "rebelot/kanagawa.nvim",
  config = function()
    require("config.themes.kanagawa").setup()
  end,
  disable = true,
}
use {
  "Mofiqul/vscode.nvim",
  config = function()
    require("config.themes.vscode").setup()
  end,
  disable = false,
}

use {
  "folke/tokyonight.nvim",
  -- after = cmd "colorscheme tokyonight-storm",
  config = function()
    require("config.themes.tokyonight").setup()
  end,
  disable = true,
}

use {
  "martinsione/darkplus.nvim",
  -- config = function()
  --   cmd [[colorscheme darkplus]]
  -- end,
  disable = true,
}
use {
  "sainnhe/everforest",
  -- after = cmd "colorscheme everforest",
  config = function()
    g.everforest_better_performance = 1
  end,
  disable = true,
}
use {
  "projekt0n/github-nvim-theme",
  disable = true,
}
use {
  "sainnhe/gruvbox-material",
  -- after = cmd "colorscheme gruvbox-material",
  config = function() end,
  disable = true,
}
use {
  "arcticicestudio/nord-vim",
  -- after = cmd "colorscheme nord",
  config = function() end,
  disable = true,
}

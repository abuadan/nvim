local M = {}
local saga = require "lspsaga"
local icons = require("config.ide.icons").ui

function M.setup()
  saga.setup {
    ui = {
      theme = "round",
      border = "solid",
      winblend = 0,
      expand = icons.ChevronShortRight,
      collapse = icons.ChevronShortDown,
      preview = " ",
      code_action = "💡",
      diagnostic = "🐞",
      incoming = " ",
      outgoing = " ",
      colors = {
        --float window normal bakcground color
        normal_bg = "#1d1536",
        --title background color
        title_bg = "#afd700",
      },
      kind = {},
    },
    preview = {
      lines_above = 5,
      lines_below = 15,
    },
    scroll_preview = {
      scroll_down = "<C-f>",
      scroll_up = "<C-b>",
    },
    diagnostic = {
      show_code_action = false,
    },
    bulb = {
      enable = false,
    },
    symbol_in_winbar = {
      enable = false,
    },
  }
end
return M

local M = {}
local saga = require "lspsaga"
local icons = require("config.ide.icons").ui

function M.setup()
  saga.setup {
    ui = {
      -- currently only round theme
      theme = "round",
      title = true,
      -- border type can be single,double,rounded,solid,shadow.
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
        --float window normal background color
        normal_bg = "#1d1536",
        --title background color
        title_bg = "#afd700",
        red = "#e95678",
        magenta = "#b33076",
        orange = "#FF8700",
        yellow = "#f7bb3b",
        green = "#afd700",
        cyan = "#36d0e0",
        blue = "#61afef",
        purple = "#CBA6F7",
        white = "#d1d4cf",
        black = "#1c1c19",
      },
      kind = {},
    },
    preview = {
      lines_above = 25,
      lines_below = 25,
    },
    scroll_preview = {
      scroll_down = "<C-f>",
      scroll_up = "<C-b>",
    },
    finder = {
      edit = { "o", "<CR>" },
      vsplit = "s",
      split = "i",
      tabe = "t",
      quit = { "q", "<ESC>" },
    },
    request_timeout = 5000,
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

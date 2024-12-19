local icons = require("custom.icons")
return {
  "nvim-lualine/lualine.nvim",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  opts = {
    options = {
      theme = "vscode",
      icons_enabled = true,
      component_separators = { left = "|", right = "|" },
      section_separators = { left = icons.ui.BoldDividerRight, right = icons.ui.BoldDividerLeft },
      disabled_filetypes = {},
      globalstatus = true,
      refresh = {
        statusline = 100,
      },
    },
    extension = { "oil", "neo-tree", "fzf" },
  },
}

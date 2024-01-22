return {
  "nvim-lualine/lualine.nvim",
  -- optional = true,
  dependencies = { "nvim-tree/nvim-web-devicons" },
  opts = {
    options = {
      -- theme = "visual_studio_code",
      theme = "vscode",
      icons_enabled = true,
      component_separators = { left = "", right = "" },
      section_separators = { left = "", right = "" },
      disabled_filetypes = {},
      globalstatus = true,
      refresh = {
        statusline = 100,
      },
    },
    -- sections = require("visual_studio_code").get_lualine_sections(),
  },
  -- opts = function(_, opts)
  --   if not vim.g.trouble_lualine then
  --     table.insert(opts.sections.lualine_c, { "navic", color_correction = "dynamic" })
  --   end
  -- end,
  -- theme = "vscode",
}

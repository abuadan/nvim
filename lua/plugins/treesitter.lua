return {
  {
    "nvim-treesitter/nvim-treesitter",
    opts = function(_, opts)
      -- add tsx and treesitter
      vim.list_extend(opts.ensure_installed, {
        "tsx",
        "typescript",
        "python",
        "rust",
        "go",
        "kotlin",
        "ninja",
        "rst",
        "sql",
        "dockerfile",
        "yaml",
        "java",
        "kotlin",
        "terraform",
      })
    end,
  },
}

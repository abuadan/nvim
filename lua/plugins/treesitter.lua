return {
  {
    "nvim-treesitter/nvim-treesitter",
    opts = function(_, opts)
      -- add tsx and treesitter
      vim.list_extend(opts.ensure_installed, {
        "bash",
        "c",
        "dockerfile",
        "gitcommit",
        "go",
        "gomod",
        "java",
        "kotlin",
        "lua",
        "ninja",
        "python",
        "query",
        "rst",
        "rust",
        "sql",
        "terraform",
        "toml",
        "tsx",
        "typescript",
        "yaml",
      })
    end,
  },
}

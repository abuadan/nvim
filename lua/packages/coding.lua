local packer = require "packer"
local use = packer.use

-- Completion
use {
  "hrsh7th/nvim-cmp",
  -- event = "InsertEnter",
  -- opt = true,
  config = function()
    require("config.coding.completion.cmp_").setup()
  end,
  requires = {
    "hrsh7th/cmp-buffer",
    "hrsh7th/cmp-path",
    "hrsh7th/cmp-nvim-lua",
    "ray-x/cmp-treesitter",
    "hrsh7th/cmp-cmdline",
    "saadparwaiz1/cmp_luasnip",
    "hrsh7th/cmp-nvim-lsp-signature-help",
    "lukas-reineke/cmp-rg",
    "davidsierradz/cmp-conventionalcommits",
    "onsails/lspkind-nvim",
    "hrsh7th/cmp-calc",
    "f3fora/cmp-spell",
    "hrsh7th/cmp-emoji",
    "hrsh7th/cmp-nvim-lsp",
    {
      "L3MON4D3/LuaSnip",
      config = function()
        require("config.coding.snippets.luasnip_").setup()
      end,
      module = { "luasnip" },
    },
    "rafamadriz/friendly-snippets",
    "honza/vim-snippets",
    disable = false,
  },
}

use {
  "m-demare/hlargs.nvim",
  requires = { "nvim-treesitter/nvim-treesitter" },
  config = function()
    require("hlargs").setup()
  end,
}

use {
  "SmiteshP/nvim-navic",
  config = function()
    require("config.coding.nvim-navic_").setup()
  end,
  requires = "neovim/nvim-lspconfig",
}

-- LSP
use {
  "neovim/nvim-lspconfig",
  config = function()
    require("config.coding.completion.lspconfig").setup()
  end,
  after = "nvim-treesitter",
  requires = {
    "williamboman/mason.nvim",
    "williamboman/mason-lspconfig.nvim",
    "WhoIsSethDaniel/mason-tool-installer.nvim",
    "jayp0521/mason-null-ls.nvim",
    "folke/neodev.nvim",

    {
      "RRethy/vim-illuminate",
      config = function()
        require("config.coding.illuminate").config()
      end,
    },
    {
      "jose-elias-alvarez/null-ls.nvim", -- after = "nvim-lspconfig",
      config = function()
        require("config.coding.completion.null-ls_").setup()
      end,
    },
    {
      "b0o/schemastore.nvim",
      module = { "schemastore" },
    },
    {
      "jose-elias-alvarez/typescript.nvim",
      module = { "typescript" },
    },
    {
      "simrat39/inlay-hints.nvim",
      config = function()
        require("inlay-hints").setup()
      end,
    },
    {
      "theHamsta/nvim-semantic-tokens",
      config = function()
        require("config.coding.completion.semantictokens").setup()
      end,
      disable = false,
    },
  },
}
use {
  "glepnir/lspsaga.nvim",
  branch = "main",
  config = function()
    require("config.coding.completion.lspsaga").setup()
  end,
  opt = false,
  disable = false,
}

use {
  "simrat39/rust-tools.nvim",
  requires = "neovim/nvim-lspconfig",
  after = "nvim-lspconfig",
  config = function()
    require("config.coding.completion.rust_tools").setup()
  end,
}

use {
  "weilbith/nvim-code-action-menu",
  cmd = "CodeActionMenu",
}

-- debugger
use {
  "mfussenegger/nvim-dap",
  opt = true,
  event = "BufReadPre",
  module = { "dap" },
  wants = { "nvim-dap-virtual-text", "nvim-dap-ui", "nvim-dap-python", "which-key.nvim" },
  requires = {
    "theHamsta/nvim-dap-virtual-text",
    "rcarriga/nvim-dap-ui",
    "mfussenegger/nvim-dap-python",
    "nvim-telescope/telescope-dap.nvim",
    { "leoluz/nvim-dap-go", module = "dap-go" },
    { "jbyuki/one-small-step-for-vimkind", module = "osv" },
  },
  config = function()
    require("config.coding.dap_").setup()
  end,
}
-- Refactor
use {
  "smjonas/inc-rename.nvim",
  config = function()
    require("config.coding.inc_rename").setup()
  end,
}
use {
  "ThePrimeagen/refactoring.nvim",
  requires = {
    { "nvim-lua/plenary.nvim" },
    { "nvim-treesitter/nvim-treesitter" },
  },
}

-- Diagnostics
use {
  "folke/trouble.nvim",
  requires = "kyazdani42/nvim-web-devicons",
  config = function()
    require("config.coding.trouble").setup()
  end,
}

-- Git
use {
  "lewis6991/gitsigns.nvim",
  config = function()
    require("config.coding.git.gitsigns_").setup()
  end,
}

use {
  "tpope/vim-fugitive",
  opt = true,
  cmd = { "Git", "GBrowse", "Gdiffsplit", "Gvdiffsplit" },
  requires = {
    "idanarye/vim-merginal", -- "tpope/vim-rhubarb",
    -- "rhysd/committia.vim",
  },
}

-- Better surround
use {
  "tpope/vim-surround",
  event = "BufReadPre",
}
-- Better Comment
use {
  "numToStr/Comment.nvim",
  requires = "JoosepAlviste/nvim-ts-context-commentstring",
  keys = { "gc", "gcc", "gbc" },
  config = function()
    require("config.coding.comment").setup()
  end,
  disable = false,
}
use {
  "folke/todo-comments.nvim",
  requires = "nvim-lua/plenary.nvim",
  config = function()
    require("config.coding.todocomments").setup()
  end,
}

-- Strip Whitespace
use "ntpeters/vim-better-whitespace"

-- Test
use {
  "vim-test/vim-test",
  requires = "tpope/vim-dispatch",
  event = { "BufReadPre" },
  config = function()
    require("config.coding.testing.vim_test").setup()
  end,
}

use {
  "nvim-neotest/neotest",
  requires = {
    "nvim-lua/plenary.nvim",
    "nvim-treesitter/nvim-treesitter",
    "antoinemadec/FixCursorHold.nvim",
    "nvim-neotest/neotest-vim-test",
    "nvim-neotest/neotest-python",
    "nvim-neotest/neotest-plenary",
    "nvim-neotest/neotest-go",
    "haydenmeade/neotest-jest",
    "rouge8/neotest-rust",
    {
      "stevearc/overseer.nvim",
      config = function()
        require("overseer").setup()
      end,
    },
    config = function()
      require("config.coding.testing.neotest").setup()
    end,
    disable = false,
  },
}

use {
  "m-demare/attempt.nvim",
  requires = {
    "nvim-lua/plenary.nvim",
    "nvim-telescope/telescope.nvim",
    "nvim-telescope/telescope-ui-select.nvim",
  },
  config = function()
    require("config.coding.attempt").setup()
  end,
}

-- Markdown
use {
  "iamcco/markdown-preview.nvim",
  run = function()
    vim.fn["mkdp#util#install"]()
  end,
}

-- Colors
use {
  "norcalli/nvim-colorizer.lua",
  config = function()
    require("colorizer").setup()
  end,
}

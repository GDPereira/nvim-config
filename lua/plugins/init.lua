return {
  {
    "stevearc/conform.nvim",
    event = "BufWritePre", -- uncomment for format on save
    opts = require "configs.conform",
  },

  -- These are some examples, uncomment them if you want to see them work!
  {
    "neovim/nvim-lspconfig",
    lazy = false,
    config = function()
      require "configs.lspconfig"
    end,
  },

  -- test new blink
  -- { import = "nvchad.blink.lazyspec" },

  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    opts = {
      ensure_installed = {
        "tsx",
        "typescript",
        "javascript",
        "html",
        "css",
        "json",
        "lua",
        "rust",
        "prisma",
      },
    },
  },

  {
    "rmagatti/auto-session",
    config = function()
      require("auto-session").setup {
        auto_save_enabled = true,
        auto_restore_enabled = true,
        -- other options
      }
    end,
  },
}

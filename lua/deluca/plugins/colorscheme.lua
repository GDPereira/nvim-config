return {
  {
    "catppuccin/nvim",
    -- "folke/tokyonight.nvim",
    priority = 1000, -- make sure to load this before all the other start plugins
    config = function()
      -- load the colorscheme here
      -- vim.cmd([[colorscheme catppuccin-frappe]])
      vim.cmd([[colorscheme catppuccin-macchiato]])
      -- vim.cmd([[colorscheme catppuccin-mocha]])
      -- vim.cmd([[colorscheme tokyonight-moon]])
      -- vim.cmd([[colorscheme catppuccin-latte]])
    end,
  },
}

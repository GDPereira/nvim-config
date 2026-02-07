return {
  {
    "ThePrimeagen/harpoon",
    dependencies = { "nvim-lua/plenary.nvim" },
    keys = {
      { "<leader>hm", desc = "Mark file with harpoon" },
      { "<leader>hn", desc = "Go to next harpoon mark" },
      { "<leader>ho", desc = "Open harpoon quick menu" },
      { "<leader>hp", desc = "Go to previous harpoon mark" },
    },

    config = function()
      local mark = require "harpoon.mark"
      local ui = require "harpoon.ui"

      local keymap = vim.keymap.set

      keymap("n", "<leader>hm", function()
        mark.add_file()
      end, { desc = "Mark file with harpoon" })

      keymap("n", "<leader>hn", function()
        ui.nav_next()
      end, { desc = "Go to next harpoon mark" })

      keymap("n", "<leader>hp", function()
        ui.nav_prev()
      end, { desc = "Go to previous harpoon mark" })

      keymap("n", "<leader>ho", function()
        ui.toggle_quick_menu()
      end, { desc = "Open harpoon quick menu" })
    end,
  },
}

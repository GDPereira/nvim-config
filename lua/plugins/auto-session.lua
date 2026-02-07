return {
  {
    "rmagatti/auto-session",
    lazy = false,
    config = function()
      require("auto-session").setup {
        log_level = "error",
        auto_session_enabled = true,
        auto_restore_enabled = true,
        auto_save_enabled = true,

        pre_save_cmds = {
          function()
            pcall(function()
              require("nvim-tree.api").tree.close()
            end)
          end,
        },

        -- Abre o tree depois de restaurar
        post_restore_cmds = {
          function()
            pcall(function()
              require("nvim-tree.api").tree.open()
            end)
          end,
        },
      }
    end,
  },
}

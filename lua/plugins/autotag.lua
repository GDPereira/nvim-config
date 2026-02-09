return {
  "andymass/vim-matchup",
  ft = { "javascript", "javascriptreact", "typescript", "typescriptreact", "html" },
  init = function()
    vim.g.matchup_treesitter_stopline = 500
  end,
  opts = {
    treesitter = {
      stopline = 500,
    },
  },
  config = function()
    vim.g.matchup_matchparen_offscreen = { method = "popup" }

    local group = vim.api.nvim_create_augroup("MatchupHighlight", { clear = true })

    vim.api.nvim_create_autocmd("ColorScheme", {
      group = group,
      callback = function()
        vim.api.nvim_set_hl(0, "MatchParenCur", { underline = true })
        vim.api.nvim_set_hl(0, "MatchWordCur", { underline = true })
        vim.api.nvim_set_hl(0, "MatchWord", { underline = true })
      end,
    })

    vim.api.nvim_set_hl(0, "MatchParenCur", { underline = true })
    vim.api.nvim_set_hl(0, "MatchWordCur", { underline = true })
    vim.api.nvim_set_hl(0, "MatchWord", { underline = true })
  end,
}

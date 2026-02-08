return {
  "nvim-telescope/telescope.nvim",
  opts = function(_, opts)
    local actions = require "telescope.actions"

    opts.defaults = opts.defaults or {}
    opts.defaults.mappings = opts.defaults.mappings or {}
    opts.defaults.mappings.i = opts.defaults.mappings.i or {}
    opts.defaults.mappings.n = opts.defaults.mappings.n or {}

    -- Insert mode
    opts.defaults.mappings.i["<C-j>"] = actions.move_selection_next
    opts.defaults.mappings.i["<C-k>"] = actions.move_selection_previous

    -- Normal mode (opcional, mas recomendado)
    opts.defaults.mappings.n["<C-j>"] = actions.move_selection_next
    opts.defaults.mappings.n["<C-k>"] = actions.move_selection_previous

    return opts
  end,
}

require("nvchad.configs.lspconfig").defaults()

local servers = {
  "html",
  "cssls",
  "tailwindcss",
  "eslint",
  "rust_analyzer",
}

vim.lsp.enable(servers)

-- TypeScript via tstools (typescript-tools.nvim)
require("typescript-tools").setup {
  settings = {
    tsserver_plugins = {
      -- Exemplo: se usar styled-components ou algo similar
      -- { name = "@styled/typescript-styled-plugin" },
    },
    tsserver_file_preferences = {
      includeInlayParameterNameHints = "all",
      includeInlayParameterNameHintsWhenArgumentMatchesName = false,
      includeInlayFunctionParameterTypeHints = true,
      includeInlayVariableTypeHints = true,
      includeInlayPropertyDeclarationTypeHints = true,
      includeInlayFunctionLikeReturnTypeHints = true,
      includeInlayEnumMemberValueHints = true,
    },
  },
}

-- read :h vim.lsp.config for changing options o-- LSPs padrão

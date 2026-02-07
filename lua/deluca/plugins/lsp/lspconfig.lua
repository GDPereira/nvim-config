return {
  "neovim/nvim-lspconfig",
  event = { "BufReadPre", "BufNewFile" },
  dependencies = {
    "hrsh7th/cmp-nvim-lsp",
    { "antosha417/nvim-lsp-file-operations", config = true },
  },
  config = function()
    local cmp_nvim_lsp = require("cmp_nvim_lsp")

    -- Capabilities for autocompletion
    local capabilities = cmp_nvim_lsp.default_capabilities()

    -- Configure diagnostics
    vim.diagnostic.config({
      virtual_text = {
        prefix = "●",
        spacing = 4,
      },
      signs = {
        text = {
          [vim.diagnostic.severity.ERROR] = " ",
          [vim.diagnostic.severity.WARN] = " ",
          [vim.diagnostic.severity.HINT] = "󰠠 ",
          [vim.diagnostic.severity.INFO] = " ",
        },
      },
      underline = true,
      update_in_insert = false,
      severity_sort = true,
      float = {
        border = "rounded",
        source = true,
      },
    })

    -- Set up keymaps on LspAttach
    vim.api.nvim_create_autocmd("LspAttach", {
      group = vim.api.nvim_create_augroup("UserLspConfig", { clear = true }),
      callback = function(ev)
        local opts = { buffer = ev.buf, noremap = true, silent = true }

        opts.desc = "Show LSP references"
        vim.keymap.set("n", "gR", "<cmd>Telescope lsp_references<CR>", opts)

        opts.desc = "Go to declaration"
        vim.keymap.set("n", "gD", vim.lsp.buf.declaration, opts)

        opts.desc = "Show LSP definitions"
        vim.keymap.set("n", "gd", "<cmd>Telescope lsp_definitions<CR>", opts)

        opts.desc = "Show LSP implementations"
        vim.keymap.set("n", "gi", "<cmd>Telescope lsp_implementations<CR>", opts)

        opts.desc = "Show LSP type definitions"
        vim.keymap.set("n", "gt", "<cmd>Telescope lsp_type_definitions<CR>", opts)

        opts.desc = "See available code actions"
        vim.keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, opts)

        opts.desc = "Smart rename"
        vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)

        opts.desc = "Show buffer diagnostics"
        vim.keymap.set("n", "<leader>D", "<cmd>Telescope diagnostics bufnr=0<CR>", opts)

        opts.desc = "Show line diagnostics"
        vim.keymap.set("n", "<leader>d", vim.diagnostic.open_float, opts)

        opts.desc = "Show documentation for what is under cursor"
        vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)

        opts.desc = "Restart LSP"
        vim.keymap.set("n", "<leader>rs", ":LspRestart<CR>", opts)

        opts.desc = "Organize Imports"
        vim.keymap.set("n", "<leader>ttp", ":TSToolsOrganizeImports <CR>", opts)

        opts.desc = "Removed Unused"
        vim.keymap.set("n", "<leader>ttru", ":TSToolsRemoveUnused <CR>", opts)

        -- Svelte-specific autocmd
        local client = vim.lsp.get_client_by_id(ev.data.client_id)
        if client and client.name == "svelte" then
          vim.api.nvim_create_autocmd("BufWritePost", {
            pattern = { "*.js", "*.ts" },
            callback = function(ctx)
              client.notify("$/onDidChangeTsOrJsFile", { uri = ctx.file })
            end,
          })
        end
      end,
    })

    -- Configure LSP servers using vim.lsp.config
    vim.lsp.config("html", {
      capabilities = capabilities,
    })

    vim.lsp.config("cssls", {
      capabilities = capabilities,
    })

    vim.lsp.config("tailwindcss", {
      capabilities = capabilities,
    })

    vim.lsp.config("svelte", {
      capabilities = capabilities,
    })

    vim.lsp.config("prismals", {
      capabilities = capabilities,
    })

    vim.lsp.config("graphql", {
      capabilities = capabilities,
      filetypes = { "graphql", "gql", "svelte", "typescriptreact", "javascriptreact" },
    })

    vim.lsp.config("emmet_ls", {
      capabilities = capabilities,
      filetypes = { "html", "typescriptreact", "javascriptreact", "css", "sass", "scss", "less", "svelte" },
    })

    vim.lsp.config("pyright", {
      capabilities = capabilities,
    })

    vim.lsp.config("gopls", {
      capabilities = capabilities,
      filetypes = { "go", "gomod", "gowork", "gotmpl" },
    })

    vim.lsp.config("clangd", {
      capabilities = capabilities,
    })

    vim.lsp.config("rust_analyzer", {
      capabilities = capabilities,
    })

    vim.lsp.config("bacon-ls", {
      capabilities = capabilities,
    })

    vim.lsp.config("lua_ls", {
      capabilities = capabilities,
      settings = {
        Lua = {
          diagnostics = {
            globals = { "vim" },
          },
          workspace = {
            library = {
              [vim.fn.expand("$VIMRUNTIME/lua")] = true,
              [vim.fn.stdpath("config") .. "/lua"] = true,
            },
          },
        },
      },
    })

    vim.lsp.config("jdtls", {
      capabilities = capabilities,
      filetypes = { "java" },
    })

    -- Enable all configured LSP servers
    vim.lsp.enable({
      "html",
      "cssls",
      "tailwindcss",
      "svelte",
      "prismals",
      "graphql",
      "emmet_ls",
      "pyright",
      "gopls",
      "clangd",
      "rust_analyzer",
      "lua_ls",
      "jdtls",
      "bacon-ls",
    })

    -- Configure typescript-tools separately (it has its own setup)
    require("typescript-tools").setup({
      capabilities = capabilities,
    })
  end,
}

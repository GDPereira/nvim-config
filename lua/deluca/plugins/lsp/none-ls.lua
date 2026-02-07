return {
  "nvimtools/none-ls.nvim",
  lazy = true,
  -- event = { "BufReadPre", "BufNewFile" }, -- to enable uncomment this
  dependencies = {
    "jay-babu/mason-null-ls.nvim",
  },
  config = function()
    local mason_null_ls = require("mason-null-ls")

    local null_ls = require("null-ls")

    local null_ls_utils = require("null-ls.utils")

    mason_null_ls.setup({
      ensure_installed = {
        "prettier", -- prettier formatter
        "stylua", -- lua formatter
        "black", -- python formatter
        "pylint", -- python linter
        "eslint_d", -- js linter
      },
    })

    -- for conciseness
    local formatting = null_ls.builtins.formatting -- to setup formatters
    local diagnostics = null_ls.builtins.diagnostics -- to setup linters

    -- to setup format on save
    local augroup = vim.api.nvim_create_augroup("LspFormatting", {})

    ----------------------------------------------------------------------
    -- FORMAT ONLY GIT-CHANGED LINES
    ----------------------------------------------------------------------
    local function get_git_changed_ranges(bufnr)
      local file = vim.api.nvim_buf_get_name(bufnr)
      if file == "" then
        return {}
      end

      local output = vim.fn.systemlist({
        "git",
        "diff",
        "--unified=0",
        file,
      })

      local ranges = {}

      for _, line in ipairs(output) do
        -- @@ -a,b +c,d @@
        local start, count = line:match("%+([0-9]+),?([0-9]*)")
        if start then
          start = tonumber(start)
          count = tonumber(count) or 1

          table.insert(ranges, {
            start = start - 1, -- LSP uses 0-based lines
            ["end"] = start + count - 1,
          })
        end
      end

      return ranges
    end

    local function format_changed_lines(bufnr)
      local ranges = get_git_changed_ranges(bufnr)
      if vim.tbl_isempty(ranges) then
        return
      end

      local clients = vim.lsp.get_active_clients({ bufnr = bufnr })

      for _, client in ipairs(clients) do
        if client.name == "null-ls" and client.supports_method("textDocument/rangeFormatting") then
          for _, range in ipairs(ranges) do
            vim.lsp.buf.range_formatting({
              ["start"] = { range.start, 0 },
              ["end"] = { range["end"], 0 },
            }, bufnr, client.id)
          end
        end
      end
    end

    null_ls.setup({
      -- add package.json as identifier for root (for typescript monorepos)
      root_dir = null_ls_utils.root_pattern(".null-ls-root", "Makefile", ".git", "package.json"),

      sources = {
        --  to disable file types use
        --  "formatting.prettier.with({disabled_filetypes: {}})" (see null-ls docs)
        formatting.prettier.with({
          extra_filetypes = { "svelte" },
        }), -- js/ts formatter
        formatting.stylua, -- lua formatter
        formatting.isort,
        formatting.black,
        diagnostics.pylint,
        diagnostics.eslint_d.with({ -- js/ts linter
          condition = function(utils)
            return utils.root_has_file({ ".eslintrc.js", ".eslintrc.cjs" }) -- only enable if root has .eslintrc.js or .eslintrc.cjs
          end,
        }),
      },
      -- configure format on save
      on_attach = function(current_client, bufnr)
        if current_client.supports_method("textDocument/formatting") then
          vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
          vim.api.nvim_create_autocmd("BufWritePre", {
            group = augroup,
            buffer = bufnr,
            callback = function()
              format_changed_lines(bufnr)
            end,
          })
        end
      end,
    })
  end,
}

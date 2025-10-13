return {
  "p00f/clangd_extensions.nvim",
  ft = { "c", "cpp", "cc", "h" },
  dependencies = { "neovim/nvim-lspconfig" },
  config = function()
    local clangd_flags = {
      "--background-index",
      "--suggest-missing-includes",
      "--clang-tidy",
      "--header-insertion=iwyu",
      "--completion-style=detailed",
      "--function-arg-placeholders",
      "--fallback-style=llvm",
    }

    require("clangd_extensions").setup {
      server = {
        cmd = { "clangd", unpack(clangd_flags) },
        capabilities = require("cmp_nvim_lsp").default_capabilities(),
        on_attach = function(client, bufnr)
          -- Improve inlay hints
          if vim.fn.has("nvim-0.10") == 1 then
            vim.lsp.inlay_hint.enable(true, { bufnr = bufnr })
          end

          -- Add keymap for implementing methods
          vim.keymap.set("n", "<leader>ci", function()
            vim.cmd("ClangdImplementMissing")
          end, { buffer = bufnr, desc = "Implement missing methods" })
        end,
      },
      extensions = {
        -- Enable inlay hints
        inlay_hints = {
          inline = true,
        },
        -- Enable AST viewer
        ast = {
          role_icons = {
            type = "🄣",
            declaration = "🄓",
            expression = "🄔",
            statement = ";",
            specifier = "🄢",
            ["template argument"] = "🆃",
          },
          kind_icons = {
            Compound = "🄲",
            Recovery = "🅁",
            TranslationUnit = "🅄",
            PackExpansion = "🄿",
            TemplateTypeParm = "🅃",
            TemplateTemplateParm = "🅃",
            TemplateParamObject = "🅃",
          },
        },
      },
    }

    -- Setup commands
    vim.api.nvim_create_user_command("ClangdImplementMissing", function()
      vim.lsp.buf.code_action({
        context = {
          only = {
            "source.addMissingDef",
            "source.addMissingImpl",
            "source.addDefinition"
          },
          diagnostics = {},
        },
      })
    end, { desc = "Implement missing C++ methods" })
  end
}

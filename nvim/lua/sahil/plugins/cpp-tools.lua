return {
  "p00f/clangd_extensions.nvim",
  ft = { "c", "cpp", "cc", "h" },
  dependencies = { "neovim/nvim-lspconfig" },
  config = function()
    local clangd_flags = {
      "--background-index",
      "--clang-tidy",
      "--header-insertion=iwyu",
      "--completion-style=detailed",
      "--fallback-style=llvm",
      "--all-scopes-completion",
      "--pch-storage=memory",
      "--query-driver=/usr/bin/clang++,/usr/bin/g++",
      "--enable-config",
    }

    -- Setup capabilities with proper offsetEncoding for clangd
    local capabilities = require("cmp_nvim_lsp").default_capabilities()
    capabilities.offsetEncoding = { "utf-16" }

    -- Configure clangd via vim.lsp.config
    vim.lsp.config.clangd = {
      cmd = { "clangd", unpack(clangd_flags) },
      capabilities = capabilities,
      filetypes = { "c", "cpp", "cc", "h", "hpp", "objc", "objcpp" },
      root_markers = { ".clangd", ".clang-tidy", ".clang-format", "compile_commands.json", "compile_flags.txt", ".git" },
    }

    -- Setup clangd_extensions for additional features
    require("clangd_extensions").setup {
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

    -- Add on_attach callback for C/C++ files
    vim.api.nvim_create_autocmd("LspAttach", {
      callback = function(args)
        local client = vim.lsp.get_client_by_id(args.data.client_id)
        if client and client.name == "clangd" then
          local bufnr = args.buf

          -- Improve inlay hints
          if vim.fn.has("nvim-0.10") == 1 then
            vim.lsp.inlay_hint.enable(true, { bufnr = bufnr })
          end

          -- Add keymap for implementing methods
          vim.keymap.set("n", "<leader>ci", function()
            vim.cmd("ClangdImplementMissing")
          end, { buffer = bufnr, desc = "Implement missing methods" })
        end
      end,
    })

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

    -- Enable clangd for C/C++ filetypes
    vim.lsp.enable("clangd")
  end
}

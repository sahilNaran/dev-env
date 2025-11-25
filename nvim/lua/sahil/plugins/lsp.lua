return {
  "neovim/nvim-lspconfig",
  dependencies = {
    "stevearc/conform.nvim",
    "williamboman/mason.nvim",
    "williamboman/mason-lspconfig.nvim",
    "hrsh7th/cmp-nvim-lsp",
    "hrsh7th/cmp-buffer",
    "hrsh7th/cmp-path",
    "hrsh7th/cmp-cmdline",
    "hrsh7th/nvim-cmp",
    "L3MON4D3/LuaSnip",
    "saadparwaiz1/cmp_luasnip",
    "j-hui/fidget.nvim",
  },

  config = function()
    local cmp = require('cmp')
    local cmp_lsp = require("cmp_nvim_lsp")
    local capabilities = vim.tbl_deep_extend(
      "force",
      {},
      vim.lsp.protocol.make_client_capabilities(),
      cmp_lsp.default_capabilities())


    local ts_toggle = require("sahil.lsp_toggle")

    -- LSP Keybindings
    vim.api.nvim_create_autocmd("LspAttach", {
      group = vim.api.nvim_create_augroup("UserLspConfig", {}),
      callback = function(ev)
        vim.keymap.set("n", "gR", "<cmd>Telescope lsp_references<CR>", { buffer = ev.buf, desc = "Show LSP references" })
        vim.keymap.set("n", "gD", vim.lsp.buf.declaration, { buffer = ev.buf, desc = "Go to declaration" })
        vim.keymap.set("n", "gd", "<cmd>Telescope lsp_definitions<CR>",
          { buffer = ev.buf, desc = "Show LSP definitions" })
        vim.keymap.set("n", "gi", "<cmd>Telescope lsp_implementations<CR>",
          { buffer = ev.buf, desc = "Show LSP implementations" })
        vim.keymap.set("n", "gt", "<cmd>Telescope lsp_type_definitions<CR>",
          { buffer = ev.buf, desc = "Show LSP type definitions" })
        vim.keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action,
          { buffer = ev.buf, desc = "See available code actions" })
        vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, { buffer = ev.buf, desc = "Smart rename" })
        vim.keymap.set("n", "<leader>D", "<cmd>Telescope diagnostics bufnr=0<CR>",
          { buffer = ev.buf, desc = "Show buffer diagnostics" })
        vim.keymap.set("n", "<leader>d", vim.diagnostic.open_float, { buffer = ev.buf, desc = "Show line diagnostics" })
        vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, { buffer = ev.buf, desc = "Go to previous diagnostic" })
        vim.keymap.set("n", "]d", vim.diagnostic.goto_next, { buffer = ev.buf, desc = "Go to next diagnostic" })
        vim.keymap.set("n", "K", vim.lsp.buf.hover,
          { buffer = ev.buf, desc = "Show documentation for what is under cursor" })
        vim.keymap.set("n", "<leader>rs", ":LspRestart<CR>", { buffer = ev.buf, desc = "Restart LSP" })
      end,
    })

    require("fidget").setup({})
    require("mason").setup()
    require("mason-lspconfig").setup({
      ensure_installed = {
        "lua_ls",
        "ts_ls",
        "elixirls",
        "clangd",
        "tailwindcss",
        "jsonls",
        "gopls",
        'templ',
        "pyright",
      },
    })

    -- Configure LSP servers using new vim.lsp.config API
    local servers = {
      lua_ls = {
        capabilities = capabilities,
        settings = {
          Lua = {
            runtime = { version = "Lua 5.1" },
            diagnostics = {
              globals = { "bit", "vim", "it", "describe", "before_each", "after_each" },
            }
          }
        }
      },
      sourcekit = {
        capabilities = capabilities,
        cmd = { "sourcekit-lsp" },
        filetypes = { "swift", "objective-c", "objective-cpp" },
      },
      ts_ls = {
        capabilities = capabilities,
      },
      elixirls = {
        capabilities = capabilities,
      },
      -- clangd configured via clangd_extensions in cpp-tools.lua
      tailwindcss = {
        capabilities = capabilities,
      },
      jsonls = {
        capabilities = capabilities,
      },
      gopls = {
        capabilities = capabilities,
      },
      templ = {
        capabilities = capabilities,
      },
      pyright = {
        capabilities = capabilities,
        settings = {
          python = {
            analysis = {
              autoSearchPaths = true,
              diagnosticMode = "workspace",
              useLibraryCodeForTypes = true,
            },
          },
        },
      },
    }

    -- Setup servers with new API
    for server_name, config in pairs(servers) do
      -- Skip ts_ls if using tsgo
      if not (server_name == "ts_ls" and ts_toggle.use_tsgo()) then
        vim.lsp.config(server_name, config)
      end
    end

    local dartExcludedFolders = {
      vim.fn.expand("$HOME/AppData/Local/Pub/Cache"),
      vim.fn.expand("$HOME/.pub-cache"),
      vim.fn.expand("/opt/homebrew/"),
      vim.fn.expand("$HOME/developement/flutter/"),
    }

    -- Configure Dart LSP
    vim.lsp.config.dartls = {
      capabilities = capabilities,
      cmd = {
        "dart",
        "language-server",
        "--protocol=lsp",
      },
      filetypes = { "dart" },
      init_options = {
        onlyAnalyzeProjectsWithOpenFiles = false,
        suggestFromUnimportedLibraries = true,
        closingLabels = true,
        outline = false,
        flutterOutline = false,
      },
      settings = {
        dart = {
          analysisExcludedFolders = dartExcludedFolders,
          updateImportsOnRename = true,
          completeFunctionCalls = true,
          showTodos = true,
        },
      }
    }

    -- Configure DCM LSP for Dart
    vim.lsp.config.dcmls = {
      capabilities = capabilities,
      cmd = {
        "dcm",
        "start-server",
      },
      filetypes = { "dart", "yaml" },
      settings = {
        dart = {
          analysisExcludedFolders = dartExcludedFolders,
        },
      },
    }


    -- Configure TypeScript-Go if enabled
    if ts_toggle.use_tsgo() then
      vim.lsp.config.tsserver = {
        cmd = { ts_toggle.tsgo_path, "lsp" },
        capabilities = capabilities,
        root_markers = { "tsconfig.json", "jsconfig.json", "package.json" },
        init_options = {
          preferences = {
            disableSuggestions = false,
          },
        },
      }
    end

    -- Add a command to toggle between TS LSP servers
    vim.api.nvim_create_user_command("ToggleTSServer", function()
      ts_toggle.toggle_ts_server()
    end, { desc = "Toggle between TypeScript LSP servers" })



    local cmp_select = { behavior = cmp.SelectBehavior.Select }

    cmp.setup({
      snippet = {
        expand = function(args)
          require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
        end,
      },
      mapping = cmp.mapping.preset.insert({
        ['<C-p>'] = cmp.mapping.select_prev_item(cmp_select),
        ['<C-n>'] = cmp.mapping.select_next_item(cmp_select),
        ['<C-y>'] = cmp.mapping.confirm({ select = true }),
        ["<C-Space>"] = cmp.mapping.complete(),
      }),
      sources = cmp.config.sources({
        { name = 'nvim_lsp' },
        { name = 'luasnip' }, -- For luasnip users.
      }, {
        { name = 'buffer' },
      })
    })

    -- Diagnostic configuration (signs + float)
    vim.diagnostic.config({
      signs = {
        text = {
          [vim.diagnostic.severity.ERROR] = " ",
          [vim.diagnostic.severity.WARN] = " ",
          [vim.diagnostic.severity.HINT] = "󰠠 ",
          [vim.diagnostic.severity.INFO] = " ",
        },
      },
      float = {
        focusable = false,
        style = "minimal",
        border = "rounded",
        source = "always",
        header = "",
        prefix = "",
      },
    })
  end
}

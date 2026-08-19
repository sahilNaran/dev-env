return {
  "neovim/nvim-lspconfig",
  dependencies = {
    "williamboman/mason.nvim",
    "williamboman/mason-lspconfig.nvim",
    "hrsh7th/nvim-cmp",
    "hrsh7th/cmp-nvim-lsp",
  },
  config = function()
    local cmp = require("cmp")
    local cmp_lsp = require("cmp_nvim_lsp")
    local capabilities = cmp_lsp.default_capabilities()

    require("mason").setup()
    require("mason-lspconfig").setup({
      ensure_installed = { "lua_ls", "ts_ls", "pyright", "clangd" },
    })

    local servers = { "lua_ls", "ts_ls", "clangd" }
    for _, server in ipairs(servers) do
      vim.lsp.config(server, { capabilities = capabilities })
    end

    -- Configure pyright with virtual environment support
    vim.lsp.config("pyright", {
      capabilities = capabilities,
      before_init = function(_, config)
        local venv_path = vim.fn.getcwd() .. "/.venv/bin/python"
        if vim.fn.filereadable(venv_path) == 1 then
          config.settings = vim.tbl_deep_extend("force", config.settings or {}, {
            python = {
              pythonPath = venv_path,
            },
          })
        end
      end,
    })

    vim.api.nvim_create_autocmd("LspAttach", {
      callback = function(ev)
        local opts = function(desc) return { buffer = ev.buf, desc = desc } end
        vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts("Go to definition"))
        vim.keymap.set("n", "gD", vim.lsp.buf.declaration, opts("Go to declaration"))
        vim.keymap.set("n", "gi", vim.lsp.buf.implementation, opts("Go to implementation"))
        vim.keymap.set("n", "gr", "<cmd>Telescope lsp_references<cr>", opts("Find references"))
        vim.keymap.set("n", "gt", vim.lsp.buf.type_definition, opts("Go to type definition"))
        vim.keymap.set("n", "K", vim.lsp.buf.hover, opts("Hover docs"))
        vim.keymap.set({ "n", "i" }, "<C-k>", vim.lsp.buf.signature_help, opts("Signature help"))
        vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts("Rename symbol"))
        vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, opts("Code action"))
        vim.keymap.set("n", "<leader>cf", function() vim.lsp.buf.format({ async = true }) end, opts("Format buffer"))
        vim.keymap.set("n", "<leader>cd", vim.diagnostic.open_float, opts("Show diagnostic"))
        vim.keymap.set("n", "[d", function() vim.diagnostic.jump({ count = -1, float = true }) end, opts("Prev diagnostic"))
        vim.keymap.set("n", "]d", function() vim.diagnostic.jump({ count = 1, float = true }) end, opts("Next diagnostic"))
        vim.keymap.set("n", "<leader>cs", "<cmd>Telescope lsp_document_symbols<cr>", opts("Document symbols"))
        vim.keymap.set("n", "<leader>cS", "<cmd>Telescope lsp_workspace_symbols<cr>", opts("Workspace symbols"))
      end,
    })

    cmp.setup({
      mapping = cmp.mapping.preset.insert({
        ["<C-n>"] = cmp.mapping.select_next_item(),
        ["<C-p>"] = cmp.mapping.select_prev_item(),
        ["<C-y>"] = cmp.mapping.confirm({ select = true }),
      }),
      sources = {
        { name = "nvim_lsp" },
      },
    })
  end,
}

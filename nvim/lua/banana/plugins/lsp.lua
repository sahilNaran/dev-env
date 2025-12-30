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
        vim.keymap.set("n", "gd", vim.lsp.buf.definition, { buffer = ev.buf })
        vim.keymap.set("n", "K", vim.lsp.buf.hover, { buffer = ev.buf })
        vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, { buffer = ev.buf })
        vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, { buffer = ev.buf })
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

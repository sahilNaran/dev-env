return {
  "WhoIsSethDaniel/mason-tool-installer.nvim",
  dependencies = { "williamboman/mason.nvim" },
  config = function()
    require("mason-tool-installer").setup({
      ensure_installed = {
        -- Linters
        "eslint_d",      -- JS/TS linter
        "luacheck",      -- Lua linter
        "pylint",        -- Python linter (if you use Python)
        "golangci-lint", -- Go linter (if you use Go)
        -- Note: clang-tidy is typically system-installed, not via Mason

        -- Formatters (you already have these via conform, but ensuring they're installed)
        "stylua",        -- Lua formatter
        "prettier",      -- JS/TS/JSON/etc formatter
        "clang-format",  -- C++ formatter
      },
      auto_update = false,
      run_on_start = true,
    })
  end,
}

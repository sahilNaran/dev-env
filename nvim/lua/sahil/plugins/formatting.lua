return {
  "stevearc/conform.nvim",
  config = function()
    require("conform").setup({
      formatters_by_ft = {
        lua = { "stylua" },
        javascript = { "prettier" },
        typescript = { "prettier" },
        javascriptreact = { "prettier" },
        typescriptreact = { "prettier" },
        css = { "prettier" },
        html = { "prettier" },
        json = { "prettier" },
        markdown = { "prettier" },
        heex = { "mix" },
        elixir = { "mix" },
        cpp = { "clang_format" },
        dart = { "dart_format" },
        swift = { "swift_format" },
      },
      format_on_save = {
        timeout_ms = 500,
        lsp_fallback = true,
      },
      format_after_save = {
        lsp_fallback = true,
      },
    })

    -- Format keybinding
    vim.keymap.set({ "n", "v" }, "<leader>mp", function()
      require("conform").format({
        lsp_fallback = true,
        async = false,
        timeout_ms = 500,
      })
    end, { desc = "Format file or range (in visual mode)" })
  end
}

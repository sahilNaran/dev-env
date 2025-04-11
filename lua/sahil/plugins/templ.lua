return {
  "tjdevries/templ.nvim",
  ft = "templ",
  config = function()
    vim.filetype.add({
      extension = {
        templ = "templ",
      },
    })

    local conform_ok, conform = pcall(require, "conform")
    if conform_ok then
      conform.formatters_by_ft["templ"] = { "templ" }
    end

    vim.api.nvim_create_autocmd("FileType", {
      pattern = "templ",
      callback = function()
        vim.bo.expandtab = true
        vim.bo.shiftwidth = 2
        vim.bo.tabstop = 2

        vim.bo.commentstring = "{{/* %s */}}"
      end
    })
  end,
  dependencies = {
    "nvim-treesitter/nvim-treesitter",
  },
}

return {
  "MeanderingProgrammer/render-markdown.nvim",
  dependencies = {
    "nvim-treesitter/nvim-treesitter",
    "nvim-tree/nvim-web-devicons",
  },
  ft = { "markdown" },
  opts = {
    heading = {
      sign = false,
      icons = { "# ", "## ", "### ", "#### ", "##### ", "###### " },
    },
    code = {
      sign = false,
      width = "block",
      right_pad = 1,
    },
    checkbox = {
      unchecked = { icon = "󰄱 " },
      checked = { icon = "󰱒 " },
    },
  },
  config = function(_, opts)
    require("render-markdown").setup(opts)
    vim.keymap.set("n", "<leader>mr", "<cmd>RenderMarkdown toggle<cr>", { desc = "Toggle markdown render" })
  end,
}

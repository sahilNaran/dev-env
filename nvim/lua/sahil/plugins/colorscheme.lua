return {
  "sahilNaran/bo-banana-bread.nvim",
  priority = 1000,
  config = function()
    require("bo-banana-bread").setup()
    vim.api.nvim_set_hl(0, "RainbowDelimiterRed", { fg = "#FF5555" })    -- error color
    vim.api.nvim_set_hl(0, "RainbowDelimiterGreen", { fg = "#1DB954" })  -- green color
    vim.api.nvim_set_hl(0, "RainbowDelimiterViolet", { fg = "#BD93F9" }) -- purple color
    vim.api.nvim_set_hl(0, "RainbowDelimiterCyan", { fg = "#8BE9FD" })   -- cyan color
    vim.api.nvim_set_hl(0, "RainbowDelimiterPink", { fg = "#FF79C6" })   -- pink color
    vim.api.nvim_set_hl(0, "RainbowDelimiterYellow", { fg = "#F1FA8C" }) -- yellow color
    vim.api.nvim_set_hl(0, "RainbowDelimiterOrange", { fg = "#FFB86C" }) -- orange color
  end,
}

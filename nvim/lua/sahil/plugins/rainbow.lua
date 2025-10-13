return {
  "HiPhish/rainbow-delimiters.nvim",
  config = function()
    require("rainbow-delimiters.setup").setup {
      highlight = {
        "RainbowDelimiterViolet",
        "RainbowDelimiterGreen",
        "RainbowDelimiterCyan",
        "RainbowDelimiterPink",
        "RainbowDelimiterYellow",
        "RainbowDelimiterOrange",
        "RainbowDelimiterRed",
      },
      query = {
        [''] = 'rainbow-delimiters',
        lua = 'rainbow-blocks',
      },
      strategy = {
        [''] = require('rainbow-delimiters').strategy['global'],
      },
    }
  end
}

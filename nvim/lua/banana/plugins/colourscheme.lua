  return {
    "catppuccin/nvim",
    priority = 1000,
    config = function()
      require("catppuccin").setup({
        color_overrides = {
          mocha = {
            base = "#121212",
            mantle = "#121212",
            crust = "#121212",
          },
        },
        custom_highlights = function(colors)
          return {
            EndOfBuffer = { fg = colors.surface1 },
          }
        end,
      })
      vim.cmd.colorscheme("catppuccin")
    end,
  }

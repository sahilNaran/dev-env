return {
  'nvim-lualine/lualine.nvim',
  dependencies = { 'nvim-tree/nvim-web-devicons' },
  config = function()
    local function ts_server_indicator()
      -- Only show for TypeScript/JavaScript files
      local ft = vim.bo.filetype
      if ft ~= "typescript" and ft ~= "javascript" and ft ~= "typescriptreact" and ft ~= "javascriptreact" then
        return ""
      end

      -- Get the server type from global variable
      local server_type = vim.g.ts_server_type or "TypeScript"

      -- Return indicator with icon
      if server_type == "TypeScript-Go" then
        return "TS-Go 🚀"
      else
        return "TS 📝"
      end
    end

    require('lualine').setup {
      sections = {
        lualine_x = {
          ts_server_indicator,
          'encoding',
          'fileformat',
          'filetype'
        }
      }
    }
  end
}

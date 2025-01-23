return {
	-- Define our main colorscheme plugin
	{
		"Mofiqul/dracula.nvim",
		-- Set priority to ensure it loads before other plugins
		priority = 1000,
		config = function()
			-- Define our custom Spotify-inspired colors
			-- These colors create a dark, modern theme similar to Spotify's interface
			local colors = {
				-- Main background and foreground colors
				bg = "#212121", -- Dark background like Spotify's UI
				fg = "#B3B3B3", -- Light gray text that's easy on the eyes
				-- Accent and semantic colors
				accent = "#1DB954", -- Spotify's signature green
				error = "#EE6666", -- Soft red for errors
				warning = "#FFB86C", -- Orange for warnings
				info = "#97E1F1", -- Light blue for information
				hint = "#BF9EEE", -- Purple for hints
				-- UI element colors
				selection = "#44475A", -- Slightly lighter than background for selections
				comment = "#5D6A7F", -- Muted blue-gray for comments
				-- Syntax highlighting colors
				string = "#E7EE98", -- Light yellow-green for strings
				keyword = "#F286C4", -- Pink for keywords
				function_name = "#50FA7B", -- Bright green for functions
				type = "#97E1F1", -- Light blue for types
				constant = "#BF9EEE", -- Purple for constants
				variable = "#FFFFFF", -- White for variables
			}
			-- Load the base dracula theme first
			vim.cmd.colorscheme("dracula")
			-- Apply our custom highlights on top of the base theme
			-- These overwrites create our custom Spotify-inspired look
			-- Basic editor colors
			vim.api.nvim_set_hl(0, "Normal", { fg = colors.fg, bg = colors.bg })
			vim.api.nvim_set_hl(0, "NormalFloat", { fg = colors.fg, bg = colors.bg })
			vim.api.nvim_set_hl(0, "Comment", { fg = colors.comment, italic = true })
			vim.api.nvim_set_hl(0, "CursorLine", { bg = colors.selection })
			vim.api.nvim_set_hl(0, "Visual", { bg = colors.accent, fg = colors.bg })
			-- Syntax highlighting
			vim.api.nvim_set_hl(0, "String", { fg = colors.string })
			vim.api.nvim_set_hl(0, "Keyword", { fg = colors.keyword, bold = true })
			vim.api.nvim_set_hl(0, "Function", { fg = colors.function_name })
			vim.api.nvim_set_hl(0, "Type", { fg = colors.type, italic = true })
			vim.api.nvim_set_hl(0, "Constant", { fg = colors.constant })
			-- Diagnostic colors
			vim.api.nvim_set_hl(0, "DiagnosticError", { fg = colors.error })
			vim.api.nvim_set_hl(0, "DiagnosticWarn", { fg = colors.warning })
			vim.api.nvim_set_hl(0, "DiagnosticInfo", { fg = colors.info })
			vim.api.nvim_set_hl(0, "DiagnosticHint", { fg = colors.hint })
			-- UI element highlights
			vim.api.nvim_set_hl(0, "LineNr", { fg = colors.comment })
			vim.api.nvim_set_hl(0, "CursorLineNr", { fg = colors.accent })
			vim.api.nvim_set_hl(0, "SignColumn", { bg = colors.bg })
			vim.api.nvim_set_hl(0, "VertSplit", { fg = colors.selection })
			-- Popup menu colors
			vim.api.nvim_set_hl(0, "Pmenu", { fg = colors.fg, bg = colors.selection })
			vim.api.nvim_set_hl(0, "PmenuSel", { fg = colors.bg, bg = colors.accent })
			-- Search highlighting
			vim.api.nvim_set_hl(0, "Search", { bg = colors.selection, fg = colors.accent })
			vim.api.nvim_set_hl(0, "IncSearch", { bg = colors.accent, fg = colors.bg })
			-- Status line
			vim.api.nvim_set_hl(0, "StatusLine", { fg = colors.fg, bg = colors.selection })
			vim.api.nvim_set_hl(0, "StatusLineNC", { fg = colors.comment, bg = colors.selection })
		end,
	},
}

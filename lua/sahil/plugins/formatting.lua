return {
	"stevearc/conform.nvim",
	event = { "BufReadPre", "BufNewFile" },
	config = function()
		local conform = require("conform")
		conform.setup({
			formatters_by_ft = {
				-- JavaScript/TypeScript (from tsserver)
				javascript = { "prettier" },
				typescript = { "prettier" },
				javascriptreact = { "prettier" },
				typescriptreact = { "prettier" },

				-- JSON (using Biome)
				json = { "biome" },

				-- Lua (from lua_ls)
				lua = { "stylua" },

				-- CSS/HTML (from tailwindcss)
				css = { "prettier" },
				html = { "prettier" },

				-- Elixir (from erlangls)
				elixir = { "mix_format" },
				eex = { "mix_format" },
				heex = { "mix_format" },
			},
			format_on_save = {
				lsp_fallback = true,
				async = false,
				timeout_ms = 1000,
			},
		})

		vim.keymap.set({ "n", "v" }, "<leader>mp", function()
			conform.format({
				lsp_fallback = true,
				async = false,
				timeout_ms = 1000,
			})
		end, { desc = "Format file or range (in visual mode)" })
	end,
}

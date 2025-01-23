return {
	"WhoIsSethDaniel/mason-tool-installer.nvim",
	lazy = false, -- Make sure this loads immediately
	dependencies = {
		"williamboman/mason.nvim",
	},
	config = function()
		require("mason-tool-installer").setup({
			ensure_installed = {
				"prettier", -- Web formatter
				"biome", -- JSON formatter
				"stylua", -- Lua formatter
				"clang-format", -- C++ formatter
				"eslint_d", -- JavaScript/TypeScript linter
				"cpplint", -- C++ linter
				"elixir-ls", -- Elixir linter
			},
			auto_update = true,
			run_on_start = true,
		})
	end,
}

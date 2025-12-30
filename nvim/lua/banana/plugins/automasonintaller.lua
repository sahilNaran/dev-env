return {
	"WhoIsSethDaniel/mason-tool-installer.nvim",
	dependencies = { "williamboman/mason.nvim" },
	config = function()
		require("mason-tool-installer").setup({
			ensure_installed = {
				"eslint_d",
				"luacheck",
				"pylint",
				"golangci-lint",
				"stylua",
				"prettier",
				"clang-format",
				"ruff",
			},
			auto_update = false,
			run_on_start = true,
		})
	end,
}

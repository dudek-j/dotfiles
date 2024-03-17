return { -- highlight, edit, and navigate code
	"nvim-treesitter/nvim-treesitter",
	build = ":TSUpdate",
	config = function()
		---@diagnostic disable-next-line: missing-fields
		require("nvim-treesitter.configs").setup({
			ensure_installed = {
				"bash",
				"python",
				"swift",
				"json",
				"javascript",
				"typescript",
				"html",
				"vim",
				"vimdoc",
				"lua",
				"markdown",
			},
			auto_install = true,
			highlight = { enable = true },
			indent = { enable = true },
		})
	end,
}

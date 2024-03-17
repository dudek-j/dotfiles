return {
	{ -- dracula
		"mofiqul/dracula.nvim",
		lazy = false, -- make sure we load this during startup if it is your main colorscheme
		priority = 1000, -- make sure to load this before all the other start plugins
		config = function()
			vim.cmd.colorscheme("dracula")
		end,
	},
	{ -- "gc" to comment visual regions/lines
		"numtostr/comment.nvim",
		opts = {
			toggler = {
				line = "gc",
			},
		},
	},
	{
		"windwp/nvim-autopairs",
		event = "InsertEnter",
		config = true,
	},
	"tpope/vim-sleuth", -- detect tabstop and shiftwidth automaticallyp
	{ "lewis6991/gitsigns.nvim", opts = {} }, -- Git related signs in the gutter
	require("configs.treesitter"),
	require("configs.lsp"),
	require("configs.conform"),
	require("configs.telescope"),
	require("configs.cmp"),
	require("configs.mini"),
	require("configs.lualine"),
}

return {
	"stevearc/oil.nvim",
	dependencies = { "nvim-tree/nvim-web-devicons" },
	opts = {},
	config = function()
		require("oil").setup({
			default_file_explorer = false,
			keymaps = {
				["<CR>"] = "actions.select",
				["<C-v>"] = "actions.select_vsplit",
				["<C-x>"] = "actions.select_split",
				["<C-p>"] = "actions.preview",
				["-"] = "actions.parent",
			},
			view_options = {
				show_hidden = true,
			},
			use_default_keymaps = false,
		})
		vim.keymap.set("n", "<leader>o", "<CMD>Oil<CR>", { desc = "Open parent directory" })
	end,
}

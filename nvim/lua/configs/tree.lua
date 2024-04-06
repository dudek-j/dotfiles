return {
	"nvim-tree/nvim-tree.lua",
	opts = {},
	config = function()
		require("nvim-tree").setup({
			update_focused_file = {
				update_root = true,
				enable = true,
			},
			filters = { custom = { "^.git$" } },
		})

		local api = require("nvim-tree.api")
		vim.keymap.set("n", "<leader>t", api.tree.toggle, { silent = true, noremap = true })
	end,
}

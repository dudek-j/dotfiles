return {
	"wojciech-kulik/xcodebuild.nvim",
	dependencies = {
		"MunifTanjim/nui.nvim",
		"stevearc/oil.nvim",
	},
	config = function()
		require("xcodebuild").setup({
			test_explorer = {
				auto_open = false,
			},
			logs = {
				auto_open = false,
			},
		})

		vim.keymap.set("n", "<leader>X", "<cmd>XcodebuildPicker<cr>")
		vim.keymap.set("n", "<leader>xt", "<cmd>XcodebuildTestExplorerToggle<cr>")
		vim.keymap.set("n", "<leader>xl", "<cmd>XcodebuildToggleLogs<cr>")
	end,
}

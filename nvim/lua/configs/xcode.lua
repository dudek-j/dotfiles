return {
	"wojciech-kulik/xcodebuild.nvim",
	dependencies = {
		"MunifTanjim/nui.nvim",
		"stevearc/oil.nvim",
	},
	config = function()
		require("xcodebuild").setup({
			vim.keymap.set("n", "<leader>X", "<cmd>XcodebuildPicker<cr>", { desc = "Show Xcodebuild Actions" }),
		})
	end,
}

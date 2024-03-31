return {
	"wojciech-kulik/xcodebuild.nvim",
	dependencies = {
		"MunifTanjim/nui.nvim",
		"stevearc/oil.nvim",
	},
	config = function()
		vim.env.XBS_FEAT_NEWFILE = 1
		require("xcodebuild").setup({
			vim.keymap.set("n", "<leader>X", "<cmd>XcodebuildPicker<cr>", { desc = "Show Xcodebuild Actions" }),
		})
	end,
}

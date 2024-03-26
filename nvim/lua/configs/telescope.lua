return {
	"nvim-telescope/telescope.nvim",
	event = "VimEnter",
	branch = "0.1.x",
	dependencies = {
		"nvim-lua/plenary.nvim",
		{ "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
		{ "nvim-telescope/telescope-ui-select.nvim" },
		{ "nvim-tree/nvim-web-devicons", enabled = vim.g.have_nerd_font },
	},
	config = function()
		require("telescope").setup({
			defaults = {
				file_ignore_patterns = { ".git/", "node_modules/", "Carthage/", "Parakey.xcodeproj/" },
				layout_strategy = "vertical",
			},
			pickers = {
				current_buffer_fuzzy_find = {
					theme = "ivy",
					previewer = false,
				},
				find_files = {
					hidden = true,
				},
				buffers = {
					sort_mru = true,
					ignore_current_buffer = true,
				},
			},
			extensions = {
				["ui-select"] = { -- Allows nvim UI to hook into telescope
					require("telescope.themes").get_dropdown(),
				},
			},
		})

		-- Enable telescope extensions, if they are installed
		pcall(require("telescope").load_extension, "fzf")
		pcall(require("telescope").load_extension, "ui-select")

		local builtin = require("telescope.builtin")
		vim.keymap.set("n", "<leader>b", builtin.buffers, { desc = "[F]ind [B]uffers" })
		vim.keymap.set("n", "<leader>fw", builtin.grep_string, { desc = "[F]ind [W]ord" })
		vim.keymap.set("n", "<leader>fd", builtin.diagnostics, { desc = "[F]ind [D]iagnostics" })
		vim.keymap.set("n", "<leader>F", builtin.live_grep, { desc = "[F]ind in workspace" })
		vim.keymap.set("n", "<leader>fs", builtin.treesitter, { desc = "[F]ind symbols" })
		vim.keymap.set("n", "<leader>gs", builtin.git_status, { desc = "[G]it [S]tatus" })
		vim.keymap.set("n", "<leader><leader>", builtin.find_files, { desc = "Find Files" })
		vim.keymap.set("n", "<leader>/", builtin.current_buffer_fuzzy_find, { desc = "[/] Search in current buffer" })
	end,
}

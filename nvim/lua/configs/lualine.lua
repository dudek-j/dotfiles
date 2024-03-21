return {
	"nvim-lualine/lualine.nvim",
	dependencies = { "nvim-tree/nvim-web-devicons" },
	config = function()
		local function xcodebuild_device()
			if vim.g.xcodebuild_platform == "macOS" then
				return " macOS"
			end

			if vim.g.xcodebuild_os then
				return " " .. vim.g.xcodebuild_device_name .. " (" .. vim.g.xcodebuild_os .. ")"
			end

			return " " .. vim.g.xcodebuild_device_name
		end

		require("lualine").setup({
			options = {
				theme = "dracula",
				component_separators = "",
				section_separators = "",
			},
			sections = {
				lualine_a = { "mode" },
				lualine_b = { "diagnostics", "searchcount" },
				lualine_c = {
					{
						"filename",
						path = 1,
						show_filename_only = false,
						symbols = {
							modified = " ●", -- Text to show when the file is modified.
							readonly = "", -- Text to show when the file is non-modifiable or readonly.
							unnamed = "", -- Text to show for unnamed buffers.
							newfile = "[New]", -- Text to show for newly created file before first write
						},
					},
				},
				lualine_x = {
					{ "' ' .. vim.g.xcodebuild_last_status" },
					{ xcodebuild_device },
					"filetype",
				},
				lualine_y = { "branch", "diff" },
				lualine_z = { "progress", "location" },
			},
		})
	end,
}

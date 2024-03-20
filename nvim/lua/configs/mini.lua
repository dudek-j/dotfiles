return {
	"echasnovski/mini.nvim",
	config = function()
		-- - saiw) - [s]urround [a]dd [i]nner [w]ord [)]paren
		-- - sd'   - [s]urround [d]elete [']quotes
		-- - sr)'  - [s]urround [r]eplace [)] [']
		require("mini.surround").setup()

		-- gS - split arguments on individual lines
		require("mini.splitjoin").setup({ mappings = { toggle = "gs" } })

		-- improved ci(
		require("mini.ai").setup()
	end,
}

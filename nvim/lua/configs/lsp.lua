return { -- LSP Configuration & Plugins
	"neovim/nvim-lspconfig",
	dependencies = {
		"williamboman/mason.nvim",
		"williamboman/mason-lspconfig.nvim",
		"WhoIsSethDaniel/mason-tool-installer.nvim",
		{ "j-hui/fidget.nvim", opts = {} }, -- Useful status updates for LSP.
		{ "folke/neodev.nvim", opts = {} }, -- `neodev` configures Lua LSP for your Neovim config, runtime and plugins
	},
	config = function()
		vim.api.nvim_create_autocmd("LspAttach", { -- Runs when an LSP attaches to a particular buffer.
			group = vim.api.nvim_create_augroup("kickstart-lsp-attach", { clear = true }),
			callback = function(event)
				local map = function(keys, func, desc)
					vim.keymap.set("n", keys, func, { buffer = event.buf, desc = "LSP: " .. desc })
				end

				map("gd", require("telescope.builtin").lsp_definitions, "[G]oto [D]efinition") -- Jump to the definition of the word under your cursor.
				map("gD", vim.lsp.buf.declaration, "[G]oto [D]eclaration") -- This is not Goto Definition, this is Goto Declaration.
				map("gr", require("telescope.builtin").lsp_references, "[G]oto [R]eferences") -- Find references for the word under your cursor.
				map("gi", require("telescope.builtin").lsp_implementations, "[G]oto [I]mplementation") -- When your language can declare types without an actual implementation.

				map("<leader>rn", vim.lsp.buf.rename, "[R]e[n]ame") -- Rename the variable under your cursor
				map("<leader>ca", vim.lsp.buf.code_action, "[C]ode [A]ction") -- Execute a code action
				map("K", vim.lsp.buf.hover, "Hover Documentation") -- Open hover popup

				-- Highlight on hover, clear when moved
				local client = vim.lsp.get_client_by_id(event.data.client_id)
				if client and client.server_capabilities.documentHighlightProvider then
					vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
						buffer = event.buf,
						callback = vim.lsp.buf.document_highlight,
					})

					vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
						buffer = event.buf,
						callback = vim.lsp.buf.clear_references,
					})
				end
			end,
		})

		local capabilities = vim.lsp.protocol.make_client_capabilities()
		capabilities = vim.tbl_deep_extend("force", capabilities, require("cmp_nvim_lsp").default_capabilities())

		local servers = {
			lua_ls = {
				settings = {
					Lua = {
						completion = {
							callSnippet = "Replace",
						},
					},
				},
			},
		}

		require("mason").setup() -- LSP dependency manager

		require("mason-lspconfig").setup({
			handlers = {
				function(server_name)
					local server = servers[server_name] or {}
					server.capabilities = vim.tbl_deep_extend("force", {}, capabilities, server.capabilities or {}) -- This handles overriding only values explicitly with configuration above.
					require("lspconfig")[server_name].setup(server)
				end,
			},
		})

		require("lspconfig")["sourcekit"].setup({ capabilities = capabilities })
		require("lspconfig")["elixirls"].setup({ cmd = { "/opt/homebrew/bin/elixir-ls" }, capabilities = capabilities })
	end,
}

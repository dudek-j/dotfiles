-- Set <space> as leader, must happen before plugins are loaded
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Required for nvim-tree
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

vim.o.tabstop = 4 -- A TAB character looks like 4 spaces
vim.o.expandtab = true -- Pressing the TAB key will insert spaces
vim.o.softtabstop = 4 -- Number of spaces inserted instead of a TAB character
vim.o.shiftwidth = 4 -- Number of spaces inserted when indenting

vim.opt.number = true -- Make line numbers default

vim.opt.showmode = false -- Don't show the mode, since it's already in status line

vim.opt.clipboard = "unnamedplus" -- Sync clipboard between OS and Neovim.

vim.opt.breakindent = true -- Indent wrapped lines when not enough horizontal space

vim.opt.undofile = true -- Save undo history

-- Ignore case if all characters in search are lower
vim.opt.ignorecase = true
vim.opt.smartcase = true

vim.opt.signcolumn = "yes" -- Keep room in the margin for git and debugger symbols

vim.opt.updatetime = 250 -- Time without changes before buffer is flushed to swap

vim.opt.timeoutlen = 300 -- Timeout for mappings before aborting and executing what already has been pressed

-- Configure how new splits should be opened
vim.opt.splitright = true
vim.opt.splitbelow = true

-- Sets how neovim will display certain whitespace in the editor.
vim.opt.list = true
vim.opt.listchars =
	{ tab = "··", trail = "·", nbsp = "␣", extends = "#", precedes = "*", eol = "¬", leadmultispace = "·" }
vim.g.indentline_char = "|"

vim.opt.inccommand = "split" -- Preview substitutions as you type

vim.opt.cursorline = true -- Highlight line your cursor is on

vim.opt.scrolloff = 15 -- Minimal number of screen lines to keep above and below the cursor.

-- NOTE: Keymaps

-- Set highlight on search, but clear on pressing <Esc> in normal mode
vim.opt.hlsearch = true
vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>")

vim.keymap.set("n", "q", "<nop>") -- Disable macro

-- More eaisly exit terminal mode in the builtin terminal
vim.keymap.set("t", "<Esc><Esc>", "<C-\\><C-n>", { desc = "Exit terminal mode" })

--  Use CTRL+<hjkl> to switch between windows
vim.keymap.set("n", "<C-h>", "<C-w><C-h>", { desc = "Move focus to the left window" })
vim.keymap.set("n", "<C-l>", "<C-w><C-l>", { desc = "Move focus to the right window" })
vim.keymap.set("n", "<C-j>", "<C-w><C-j>", { desc = "Move focus to the lower window" })
vim.keymap.set("n", "<C-k>", "<C-w><C-k>", { desc = "Move focus to the upper window" })

-- NOTE: Autocommands

-- Highlight when yanking (copying) text
vim.api.nvim_create_autocmd("TextYankPost", {
	desc = "Highlight when yanking (copying) text",
	group = vim.api.nvim_create_augroup("highlight-yank", { clear = true }),
	callback = function()
		vim.highlight.on_yank()
	end,
})

-- File specific small indentation
vim.api.nvim_create_autocmd("BufEnter", {
	desc = "2 space indentation",
	pattern = { "*.lua", "*.md" },
	callback = function()
		vim.o.tabstop = 2
		vim.o.expandtab = true
		vim.o.softtabstop = 2
		vim.o.shiftwidth = 2
	end,
})
--
-- Force close all
vim.api.nvim_create_user_command("Q", ":qa!", {})
-- Format without saving
vim.api.nvim_create_user_command("W", ":noa w", {})
-- Markdown listing mark done
vim.keymap.set("n", "<leader>d", function()
	local current_line = vim.api.nvim_get_current_line()

	if current_line:find("✔") then
		vim.cmd(":s/- ✔/-")
	elseif current_line:find("") then
		vim.cmd(":s/-/- ✔")
	end

	vim.cmd("nohlsearch")
end)
-- Markdown listing mark done
vim.keymap.set("n", "<leader>x", function()
	local current_line = vim.api.nvim_get_current_line()

	if current_line:find("✗") then
		vim.cmd(":s/- ✗/-")
	elseif current_line:find("") then
		vim.cmd(":s/-/- ✗")
	end

	vim.cmd("nohlsearch")
end)

-- NOTE: Install Lazy
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable", -- latest stable release
		lazypath,
	})
end
vim.opt.rtp:prepend(lazypath)

-- NOTE: Configure and install plugins, check status with :Lazy
require("lazy").setup("plugins")

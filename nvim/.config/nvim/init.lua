vim.g.mapleader = " "
vim.g.localleader = "\\"

vim.wo.number = true
vim.wo.relativenumber = true
vim.opt.shiftwidth = 4
vim.opt.tabstop = 4
vim.opt.swapfile = false
vim.opt.compatible = false
vim.opt.termguicolors = true
vim.opt.clipboard = "unnamedplus"
vim.opt.laststatus = 0
vim.opt.mouse = ""
vim.opt.conceallevel = 1
vim.opt.guifont = { "Hack Nerd Font Mono", ":h11" }
vim.api.nvim_create_autocmd("ExitPre", {
	group = vim.api.nvim_create_augroup("Exit", { clear = true }),
	command = "set guicursor=a:ver90",
	desc = "Reset cursor to beam when leaving nvim",
})
vim.api.nvim_create_autocmd("BufWinEnter", {
	pattern = { "*.md", "*.tex" },
	callback = function()
		-- vim.opt.colorcolumn = '75'
		vim.opt.textwidth = 75
	end,
})
vim.api.nvim_create_user_command("Terminal", function()
	vim.cmd("terminal")
	vim.cmd("setlocal nonumber")
	vim.cmd("setlocal norelativenumber")
	vim.cmd("setlocal signcolumn=no")
	vim.cmd("startinsert")
end, {})

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable", -- latest stable release lazypath,
	})
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
	{
		"folke/neodev.nvim",
		opts = {},
	},
	{
		"vague2k/vague.nvim",
		lazy = false,
		priority = 1000,
		config = function()
			require("vague").setup({
				vim.cmd([[colorscheme vague]]),
			})
		end,
	},
	{
		"nvim-telescope/telescope.nvim",
		tag = "0.1.5",
		lazy = true,
		dependencies = { "nvim-lua/plenary.nvim" },
		cmd = "Telescope",
	},
	{
		"mason-org/mason.nvim",
		"mason-org/mason-lspconfig.nvim",
		"neovim/nvim-lspconfig",
	},
	{
		"nvim-treesitter/nvim-treesitter",
		branch = "main",
	},
	{
		"nvim-tree/nvim-tree.lua",
		cmd = { "NvimTreeToggle", "NvimTreeFocus" },
		version = "*",
		dependencies = {
			"lewis6991/gitsigns.nvim",
			"nvim-tree/nvim-web-devicons",
		},
		config = function()
			require("nvim-tree").setup({
				filters = {
					dotfiles = true,
				},
			})
		end,
	},
	{
		"stevearc/oil.nvim",
		cmd = "Oil",
		opts = {},
		dependencies = { "nvim-tree/nvim-web-devicons" },
	},
	{
		"numToStr/Comment.nvim",
	},
	{
		"iamcco/markdown-preview.nvim",
		cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
		ft = { "markdown" },
		build = function()
			vim.fn["mkdp#util#install"]()
		end,
	},
	{
		"lewis6991/gitsigns.nvim",
		config = function()
			require("gitsigns").setup()
		end,
	},
	{
		"tpope/vim-fugitive",
		cmd = "Git",
	},
	{
		"tpope/vim-sleuth",
		lazy = false,
	},
	{
		"christoomey/vim-tmux-navigator",
		cmd = {
			"TmuxNavigateLeft",
			"TmuxNavigateDown",
			"TmuxNavigateUp",
			"TmuxNavigateRight",
		},
		keys = {
			{ "<c-h>", "<cmd><C-U>TmuxNavigateLeft<cr>" },
			{ "<c-j>", "<cmd><C-U>TmuxNavigateDown<cr>" },
			{ "<c-k>", "<cmd><C-U>TmuxNavigateUp<cr>" },
			{ "<c-l>", "<cmd><C-U>TmuxNavigateRight<cr>" },
		},
	},
	{
		"jiangmiao/auto-pairs",
	},
	{
		"echasnovski/mini.surround",
		version = false,
	},
	{
		"ThePrimeagen/harpoon",
		branch = "harpoon2",
		dependencies = { "nvim-lua/plenary.nvim" },
	},
	{
		"rhysd/conflict-marker.vim",
		lazy = false,
	},
	{
		"epwalsh/obsidian.nvim",
		version = "*",
		lazy = true,
		ft = "markdown",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"nvim-telescope/telescope.nvim",
			"nvim-treesitter/nvim-treesitter",
		},
		opts = {
			workspaces = {
				{
					name = "personal",
					path = "~/vaults/personal",
				},
				{
					name = "work",
					path = "~/vaults/work",
				},
			},
			daily_notes = {
				folder = "daily_notes",
			},
			-- Optional, by default when you use `:ObsidianFollowLink` on a link to an external
			-- URL it will be ignored but you can customize this behavior here.
			---@param url string
			follow_url_func = function(url)
				-- Open the URL in the default web browser.
				-- vim.fn.jobstart({"open", url})  -- Mac OS
				-- vim.fn.jobstart({"xdg-open", url})  -- linux
				-- vim.cmd(':silent exec "!start ' .. url .. '"') -- Windows
				vim.ui.open(url) -- need Neovim 0.10.0+
			end,
		},
	},
	{
		"stevearc/conform.nvim",
		event = "BufWritePre",
		opts = {
			notify_on_error = false,
			formatters_by_ft = {
				verilog = { "verible" },
				systemverilog = { "verible" },
				javascript = { "deno_fmt" },
				javascriptreact = { "deno_fmt" },
				json = { "deno_fmt" },
				jsonc = { "deno_fmt" },
				typescript = { "deno_fmt" },
				html = { "deno_fmt" },
				css = { "deno_fmt" },
				scss = { "deno_fmt" },
				vue = { "prettierd" },
				yaml = { "prettierd" },
				rust = { "rustfmt" },
				c = { "clang_format" },
				cpp = { "clang_format" },
				lua = { "stylua" },
				ocaml = { "ocamlformat" },
				python = { "isort", "black" },
				tex = { "latexindent" },
				-- xml = { "xmlformatter" },
				_ = { "trim_whitespace" },
			},
			format_on_save = function(bufnr)
				if not vim.api.nvim_buf_get_option(bufnr, "modified") then
					return
				end
				return { timeout_ms = 10000, lsp_fallback = true }
			end,
		},
	},
	{
		"folke/trouble.nvim",
		opts = {}, -- for default options, refer to the configuration section for custom setup.
		cmd = "Trouble",
		keys = {
			{
				"<leader>xx",
				"<cmd>Trouble diagnostics toggle<cr>",
				desc = "Diagnostics (Trouble)",
			},
			{
				"<leader>xX",
				"<cmd>Trouble diagnostics toggle filter.buf=0<cr>",
				desc = "Buffer Diagnostics (Trouble)",
			},
			{
				"<leader>cs",
				"<cmd>Trouble symbols toggle focus=false<cr>",
				desc = "Symbols (Trouble)",
			},
			{
				"<leader>cl",
				"<cmd>Trouble lsp toggle focus=false win.position=right<cr>",
				desc = "LSP Definitions / references / ... (Trouble)",
			},
			{
				"<leader>xL",
				"<cmd>Trouble loclist toggle<cr>",
				desc = "Location List (Trouble)",
			},
			{
				"<leader>xQ",
				"<cmd>Trouble qflist toggle<cr>",
				desc = "Quickfix List (Trouble)",
			},
		},
	},
})

require("mason").setup()
require("mason-lspconfig").setup({
	ensure_installed = {
		"rust_analyzer",
		"clangd",
		"verible",
	},
})
vim.lsp.config("verible", {
	cmd = { "verible-verilog-ls", "--rules=always-comb,-no-tabs" },
})
vim.lsp.enable({
	"rust_analyzer",
	"clangd",
	"verible",
})

-- Font size for Neovide, fix this
vim.g.neovide_hide_mouse_when_typing = true
vim.g.neovide_scale_factor = 1.0
local change_scale_factor = function(delta)
	vim.g.neovide_scale_factor = vim.g.neovide_scale_factor * delta
end
vim.keymap.set("n", "<C-=>", function()
	change_scale_factor(1.25)
end)
vim.keymap.set("n", "<C-->", function()
	change_scale_factor(1 / 1.25)
end)

-- -- Toggle diagnositcs
-- local toggle_diagnostics = function()
-- 	local current_state = vim.diagnostic.is_enabled()
-- 	vim.diagnostic.enable(not current_state)
-- end

-- Key Bindings
local opts = { noremap = true, silent = true }
local map = vim.api.nvim_set_keymap
local vmap = vim.keymap.set

-- Utility
vmap("n", "W", ":w<CR>")
-- vmap("n", "<Leader>tt", toggle_diagnostics, opts)
map("n", "<Leader>bh", "<Cmd>bprevious<CR>", opts)
map("n", "<Leader>bl", "<Cmd>bnext<CR>", opts)
map("n", "<Leader>bx", "<Cmd>bd<CR>", opts)

-- Latex
vim.api.nvim_create_user_command("LatexCompile", function()
	local texpath = vim.fn.expand("%")
	vim.cmd("!tectonic -Z continue-on-errors " .. texpath)
end, {})
vim.api.nvim_create_user_command("LatexCompileBackground", function()
	local texpath = vim.fn.expand("%")
	vim.cmd('silent !tmux new -d "tectonic -Z continue-on-errors ' .. texpath .. '"')
end, {})
vim.api.nvim_create_autocmd({ "BufWritePost" }, {
	pattern = { "*.tex" },
	command = "LatexCompileBackground",
})

-- Telescope
vmap("n", "<leader>fd", "<cmd>lua require 'telescope.builtin'.lsp_definitions { jump_type = 'never' }<cr>")
vmap("n", "<leader>jd", "<cmd>Telescope lsp_definitions<cr>")
vmap("n", "<leader>ds", "<cmd>Telescope lsp_document_symbols ignore_symbols=variable<cr>")
vmap("n", "<leader>ff", "<cmd>Telescope find_files<cr>")
vmap("n", "<leader>fb", "<cmd>Telescope buffers<cr>")
vmap("n", "<leader>gp", "<cmd>Telescope live_grep<cr>")

-- NvimTree
vmap("n", "<C-n>", "<cmd>NvimTreeToggle<cr>")
vmap("n", "<leader>e", "<cmd>NvimTreeFocus<cr>")
vmap("n", "<leader>f<cr>", "<cmd>NvimTreeFindFile<cr>")

-- Oil
map("n", "-", "<CMD>Oil<CR>", { desc = "Open parent directory" })

-- Mardown Preview
vmap("n", "<leader>mp", "<cmd>MarkdownPreview<cr>")

-- Obsidian
vmap("n", "<leader>oq", "<cmd>ObsidianQuickSwitch<cr>")
vmap("n", "<leader>ob", "<cmd>ObsidianBacklinks<cr>")
vmap("n", "<leader>ot", "<cmd>ObsidianTags<cr>")
vmap("n", "<leader>od", "<cmd>ObsidianDailies<cr>")

-- Mini Surround
require("mini.surround").setup()

-- Gitsigns
map("n", "[h", "<cmd>Gitsigns prev_hunk<cr>", opts)
map("n", "]h", "<cmd>Gitsigns next_hunk<cr>", opts)
map("n", "gs", "<cmd>Gitsigns preview_hunk_inline<cr>", opts)
map("n", "gR", "<cmd>Gitsigns reset_hunk<cr>", opts)

-- Harpoon
local harpoon = require("harpoon")
harpoon:setup()
vmap("n", "<leader>a", function()
	harpoon:list():add()
end)
vmap("n", "<leader>l", function()
	harpoon.ui:toggle_quick_menu(harpoon:list())
end)
vmap("n", "<leader>h1", function()
	harpoon:list():select(1)
end)
vmap("n", "<leader>h2", function()
	harpoon:list():select(2)
end)
vmap("n", "<leader>h3", function()
	harpoon:list():select(3)
end)
vmap("n", "<leader>h4", function()
	harpoon:list():select(4)
end)
vmap("n", "<leader>h5", function()
	harpoon:list():select(5)
end)
vmap("n", "<leader>h6", function()
	harpoon:list():select(6)
end)

vim.g.mapleader = " "
vim.g.localleader = "\\"

vim.wo.number = true
vim.wo.relativenumber = true
vim.opt.shiftwidth = 4
vim.opt.tabstop = 4
vim.opt.swapfile = false vim.opt.compatible = false
vim.opt.termguicolors = true
vim.opt.clipboard = "unnamedplus"
vim.opt.laststatus = 0
vim.opt.mouse = ""
vim.opt.guifont = { "Hack Nerd Font Mono", ":h11" }
vim.api.nvim_create_autocmd("ExitPre", {
	group = vim.api.nvim_create_augroup("Exit", { clear = true }),
	command = "set guicursor=a:ver90", desc = "Reset cursor to beam when leaving nvim"
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
        "https://github.com/folke/lazy.nvim.git", "--branch=stable", -- latest stable release lazypath,
    })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
	{
		"folke/neodev.nvim",
		opts = {}
	},
    {
        "folke/tokyonight.nvim",
        lazy = true,
        priority = 1000,
        config = function()
            vim.cmd([[colorscheme tokyonight]])
        end,
    },
	{
		"rebelot/kanagawa.nvim",
		lazy = false,
        priority = 1000,
		config = function()
            vim.cmd([[colorscheme kanagawa-wave]])
		end,
	},
    {
		"nvim-telescope/telescope.nvim",
		tag = '0.1.5',
		lazy = true,
		dependencies = { 'nvim-lua/plenary.nvim' },
	 	cmd = "Telescope"
    },
	{
        {
			"nvim-treesitter/nvim-treesitter",
			build = ":TSUpdate",
			config = function () 
				local configs = require("nvim-treesitter.configs")
				configs.setup({
					ensure_installed = { "c", "lua", "vim", "vimdoc", "query", "elixir", "heex", "javascript", "html", "markdown" },
					sync_install = false,
					highlight = { enable = true },
					incremental_selection = {
						enable = true,
						keymaps = {
							init_selection = "<C-m>",
							node_incremental = "<C-m>",
							scope_incremental = "<C-s>",
						}
					},
					indent = { enable = true },
				})
			end
		}
	},
	{
		"williamboman/mason.nvim",
		"williamboman/mason-lspconfig.nvim",
		"neovim/nvim-lspconfig",
	},
    {
		"nvim-tree/nvim-tree.lua",
		cmd = {"NvimTreeToggle", "NvimTreeFocus"},
        version = "*",
        dependencies = {
			"lewis6991/gitsigns.nvim", -- OPTIONAL: for git status
            "nvim-tree/nvim-web-devicons",
        },
        config = function()
        require("nvim-tree").setup {}
        end,
    },
    {
        'stevearc/oil.nvim',
		cmd = "Oil",
        opts = {},
        -- Optional dependencies
        dependencies = { "nvim-tree/nvim-web-devicons" },
    },
    {
        'numToStr/Comment.nvim',
        opts = {
			-- add any options here
        },
    }, 
    {
        "iamcco/markdown-preview.nvim",
        cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
        ft = { "markdown" },
        build = function() vim.fn["mkdp#util#install"]() end,
    },
    {
         "lewis6991/gitsigns.nvim",
         config=function()
		 	require("gitsigns").setup()
         end,
    },
    {
        "tpope/vim-fugitive",
		cmd = "Git"
    },
	{
		'dstein64/vim-startuptime',
		cmd = "StartupTime"
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
		"jiangmiao/auto-pairs"
	},
	{
		'echasnovski/mini.surround',
		version = false
	},
	{
		"ThePrimeagen/harpoon",
		branch = "harpoon2",
		dependencies = { "nvim-lua/plenary.nvim" }
	},
	{
		"OXY2DEV/markview.nvim",
		dependencies = {
			-- You may not need this if you don't lazy load
			-- Or if the parsers are in your $RUNTIMEPATH
			"nvim-treesitter/nvim-treesitter",
			"nvim-tree/nvim-web-devicons"
		}
	},
	{
	  'nvim-java/nvim-java',
	  lazy = true,
	  dependencies = {
		'nvim-java/lua-async-await',
		'nvim-java/nvim-java-refactor',
		'nvim-java/nvim-java-core',
		'nvim-java/nvim-java-test',
		'nvim-java/nvim-java-dap',
		'MunifTanjim/nui.nvim',
		'neovim/nvim-lspconfig',
		'mfussenegger/nvim-dap',
		{
		  'williamboman/mason.nvim',
		  opts = {
			registries = {
			  'github:nvim-java/mason-registry',
			  'github:mason-org/mason-registry',
			},
		  },
		}
	  },
	},
	{
		'elkowar/yuck.vim'
	}
})

require("mason").setup()
require("mason-lspconfig").setup({
	ensure_installed = {}
})

-- Autoload lsp clients on startup
require("mason-lspconfig").setup_handlers {
	function (server_name) -- default handler (optional)
		require("lspconfig")[server_name].setup {}
	end,
}

-- Font size for Neovide, fix this
vim.g.neovide_scale_factor = 1.0
local change_scale_factor = function(delta)
  vim.g.neovide_scale_factor = vim.g.neovide_scale_factor * delta
end
vim.keymap.set("n", "<C-=>", function()
  change_scale_factor(1.25)
end)
vim.keymap.set("n", "<C-->", function()
  change_scale_factor(1/1.25)
end)

-- Toggle lsp diagnostics, disable by default
vim.diagnostic.disable()
virtual_text = {}
virtual_text.show = false
virtual_text.toggle = function()
    virtual_text.show = not virtual_text.show
	if virtual_text.show then vim.diagnostic.enable() else vim.diagnostic.disable() end
end

toggletab = function(size)
	vim.opt.shiftwidth = size
	vim.opt.tabstop = size
end

-- Key Bindings
local opts = { noremap = true, silent = true }
local map = vim.api.nvim_set_keymap
local vmap = vim.keymap.set

-- Utility
vmap("n", "<F1>", ":w<CR>")
vmap("n", "W", ":w<CR>")
map("n", "<Leader>tt", "<Cmd>lua virtual_text.toggle()<CR>", opts)
map("n", "<Leader>bh", "<Cmd>bprevious<CR>", opts)
map("n", "<Leader>bl", "<Cmd>bnext<CR>", opts)
map("n", "<Leader>bx", "<Cmd>bd<CR>", opts)

-- Terminal
vim.keymap.set(
	"n",
	"<c-cr>",
	"<cmd>Terminal<cr>"
)
vim.keymap.set("t", "<c-a>", "<c-\\><c-n>")

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

-- Oil
map("n", "-", "<CMD>Oil<CR>", { desc = "Open parent directory" })

-- Mardown Preview
vmap("n", "<leader>mp", "<cmd>MarkdownPreview<cr>")
vmap("n", "<leader>mc", "<cmd>MarkdownPreviewStop<cr>")

-- Makview
vmap("n", "<leader>mv", "<cmd>Markview<cr>")

-- Mini Surround
require('mini.surround').setup()

-- Gitsigns
map('n', "[h", "<cmd>Gitsigns prev_hunk<cr>", opts)
map('n', "]h", "<cmd>Gitsigns next_hunk<cr>", opts)
map('n', "gs", "<cmd>Gitsigns preview_hunk_inline<cr>", opts)

-- Harpoon
local harpoon = require("harpoon")
harpoon:setup()
vmap("n", "<leader>a", function() harpoon:list():add() end)
vmap("n", "<leader>l", function() harpoon.ui:toggle_quick_menu(harpoon:list()) end)
vmap("n", "<leader>h1", function() harpoon:list():select(1) end)
vmap("n", "<leader>h2", function() harpoon:list():select(2) end)
vmap("n", "<leader>h3", function() harpoon:list():select(3) end)
vmap("n", "<leader>h4", function() harpoon:list():select(4) end)
vmap("n", "<leader>h5", function() harpoon:list():select(5) end)

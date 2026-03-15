local completion = {}

completion["neovim/nvim-lspconfig"] = {
	lazy = true,
	event = { "BufReadPost", "BufAdd", "BufNewFile" },
	config = require("completion.lsp"),
	dependencies = {
		{ "williamboman/mason.nvim" },
		{ "williamboman/mason-lspconfig.nvim" },
		{ "folke/neodev.nvim", opts = {} },
	},
}

completion["nvimtools/none-ls.nvim"] = {
	lazy = true,
	event = { "CursorHold", "CursorHoldI", "BufReadPre", "BufNewFile" },
	config = require("modules.configs.completion.none-ls"),
	dependencies = {
		"nvim-lua/plenary.nvim",
		"williamboman/mason.nvim",
		"jay-babu/mason-null-ls.nvim",
		"nvimtools/none-ls-extras.nvim",
	},
}

completion["hrsh7th/nvim-cmp"] = {
	lazy = true,
	event = "InsertEnter",
	config = require("completion.cmp"),
	dependencies = {
		{
			"L3MON4D3/LuaSnip",
			dependencies = { "rafamadriz/friendly-snippets" },
			config = require("completion.luasnip"),
		},
		{ "lukas-reineke/cmp-under-comparator" },
		{ "saadparwaiz1/cmp_luasnip" },
		{ "hrsh7th/cmp-nvim-lsp" },
		{ "hrsh7th/cmp-nvim-lua" },
		{ "andersevenrud/cmp-tmux" },
		{ "hrsh7th/cmp-path" },
		{ "f3fora/cmp-spell" },
		{ "hrsh7th/cmp-buffer" },
		{ "kdheepak/cmp-latex-symbols" },
		{ "ray-x/cmp-treesitter" },
		{ "hrsh7th/cmp-nvim-lsp-signature-help" },
	},
}

return completion

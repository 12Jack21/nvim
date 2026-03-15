local ui = {}

ui["catppuccin/nvim"] = {
	lazy = false,
	name = "catppuccin",
	config = require("ui.catppuccin"),
}

ui["olimorris/onedarkpro.nvim"] = {
	lazy = false,
	priotity = 1000,
	config = require("ui.onedarkpro"),
}

ui["goolord/alpha-nvim"] = {
	lazy = true,
	event = "VimEnter",
	config = require("ui.alpha"),
}

ui["akinsho/bufferline.nvim"] = {
	lazy = true,
	event = { "BufReadPost", "BufAdd", "BufNewFile" },
	config = require("ui.bufferline"),
}

ui["j-hui/fidget.nvim"] = {
	lazy = true,
	event = "LspAttach",
	config = require("ui.fidget"),
}

ui["lewis6991/gitsigns.nvim"] = {
	lazy = true,
	enabled = true,
	event = { "CursorHold", "CursorHoldI" },
	config = require("ui.gitsigns"),
}

ui["lukas-reineke/indent-blankline.nvim"] = {
	lazy = true,
	-- main = "ibl", -- migrate to version 3
	pin = true, -- revert to version 2 and pinned
	event = "BufReadPost",
	config = require("ui.indent-blankline"),
	-- version = "v2.20.7",
	tag = "v2.20.7",
}

ui["nvim-lualine/lualine.nvim"] = {
	lazy = true,
	event = { "BufReadPost", "BufAdd", "BufNewFile" },
	config = require("ui.lualine"),
}

ui["rcarriga/nvim-notify"] = {
	lazy = true,
	event = "VeryLazy",
	config = require("ui.notify"),
}

return ui

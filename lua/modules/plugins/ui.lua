local ui = {}

ui["goolord/alpha-nvim"] = {
	lazy = true,
	event = "BufWinEnter",
	config = require("ui.alpha"),
}
ui["akinsho/bufferline.nvim"] = {
	lazy = true,
	event = { "BufReadPost", "BufAdd", "BufNewFile" },
	config = require("ui.bufferline"),
}
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

ui["sainnhe/edge"] = {
	lazy = true,
	config = require("ui.edge"),
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

ui["marko-cerovac/material.nvim"] = {
	lazy = true,
	config = require("ui.material"),
}
ui["rcarriga/nvim-notify"] = {
	lazy = true,
	event = "VeryLazy",
	config = require("ui.notify"),
}
ui["folke/paint.nvim"] = {
	lazy = true,
	event = { "CursorHold", "CursorHoldI" },
	config = require("ui.paint"),
}
ui["dstein64/nvim-scrollview"] = {
	lazy = true,
	enabled = false,
	event = "BufReadPost",
	config = require("ui.scrollview"),
}
ui["edluffy/specs.nvim"] = {
	lazy = true,
	enabled = false, -- MY: will cause telescope always insert mode bug !
	event = "CursorMoved",
	config = require("ui.specs"),
}
ui["stevearc/stickybuf.nvim"] = {
	lazy = false, -- TODO: optimize
	enabled = true,
	opt = {},
	config = require("ui.stickybuf"),
}

return ui

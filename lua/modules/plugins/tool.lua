local tool = {}

tool["nvim-tree/nvim-tree.lua"] = {
	lazy = true,
	cmd = {
		"NvimTreeToggle",
		"NvimTreeOpen",
		"NvimTreeFindFile",
		"NvimTreeFindFileToggle",
		"NvimTreeRefresh",
	},
	config = require("tool.nvim-tree"),
}

tool["ibhagwan/smartyank.nvim"] = {
	lazy = true,
	event = "BufReadPost",
	config = require("tool.smartyank"),
}

tool["akinsho/toggleterm.nvim"] = {
	lazy = true,
	cmd = {
		"ToggleTerm",
		"ToggleTermSetName",
		"ToggleTermToggleAll",
		"ToggleTermSendVisualLines",
		"ToggleTermSendCurrentLine",
		"ToggleTermSendVisualSelection",
	},
	config = require("tool.toggleterm"),
}

-- Diagnostic Plugin
tool["folke/trouble.nvim"] = {
	lazy = true,
	cmd = { "Trouble", "TroubleToggle", "TroubleRefresh" },
	config = require("tool.trouble"),
}

tool["folke/which-key.nvim"] = {
	lazy = true,
	event = { "CursorHold", "CursorHoldI" },
	config = require("tool.which-key"),
}

tool["gelguy/wilder.nvim"] = {
	lazy = true,
	event = "CmdlineEnter",
	config = require("tool.wilder"),
	dependencies = { "romgrk/fzy-lua-native" },
}

tool["mrjones2014/legendary.nvim"] = {
	lazy = true,
	cmd = "Legendary",
	config = require("tool.legendary"),
}

----------------------------------------------------------------------
--                        Telescope Plugins                         --
----------------------------------------------------------------------
tool["nvim-telescope/telescope.nvim"] = {
	lazy = true,
	cmd = "Telescope",
	config = require("tool.telescope"),
	dependencies = {
		{ "nvim-tree/nvim-web-devicons" },
		{ "nvim-lua/plenary.nvim" },
		{ "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
	},
}

return tool

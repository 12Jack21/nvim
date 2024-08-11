local tool = {}

tool["tpope/vim-fugitive"] = {
	lazy = true,
	cmd = { "Git", "G" },
}

tool["sindrets/diffview.nvim"] = {
	lazy = true,
	cmd = {
		"DiffviewOpen",
		"DiffviewClose",
		"DiffviewToggleFiles",
		"DiffviewFocusFiles",
		"DiffviewRefresh",
		"DiffviewFileHistory",
	},
	-- config = require("tool.diffview"), --  error
}

-- no need for neovim, just used to switch window
-- tool["christoomey/vim-tmux-navigator"]({
-- 	cmd = {
-- 		"TmuxNavigateLeft",
-- 		"TmuxNavigateDown",
-- 		"TmuxNavigateUp",
-- 		"TmuxNavigateRight",
-- 		"TmuxNavigatePrevious",
-- 	},
-- })

-- only for fcitx5 user who uses non-English language during coding
-- tool["pysan3/fcitx5.nvim"] = {
-- 	lazy = true,
-- 	event = "BufReadPost",
-- 	cond = vim.fn.executable("fcitx5-remote") == 1,
-- 	config = require("tool.fcitx5"),
-- }
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
tool["michaelb/sniprun"] = {
	lazy = true,
	enabled = false,
	-- You need to cd to `~/.local/share/nvim/site/lazy/sniprun/` and execute `bash ./install.sh`,
	-- if you encountered error about no executable sniprun found.
	build = "bash ./install.sh",
	cmd = { "SnipRun", "SnipInfo" },
	config = require("tool.sniprun"),
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
-- support multiple terminals
tool["voldikss/vim-floaterm"] = {
	lazy = true,
	cmd = {
		"FloatermNew",
		"FloatermPrev",
		"FloatermNext",
		"FloatermToggle",
	},
	-- config =
}

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
	-- tag = "0.1.1",
	config = require("tool.telescope"),
	dependencies = {
		{ "nvim-tree/nvim-web-devicons" },
		{ "nvim-lua/plenary.nvim" },
		{ "debugloop/telescope-undo.nvim" },
		{
			"ahmedkhalf/project.nvim",
			event = "BufReadPost",
			config = require("tool.project"),
		},
		{ "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
		{ "nvim-telescope/telescope-frecency.nvim", dependencies = {
			{ "kkharji/sqlite.lua" },
		} },
		{ "jvgrootveld/telescope-zoxide" },
		{ "nvim-telescope/telescope-live-grep-args.nvim" },
		{ "nvim-telescope/telescope-file-browser.nvim" },
		{ "nvim-telescope/telescope-media-files.nvim", dependencies = {
			{ "nvim-lua/popup.nvim" },
		} },
		{ "IllustratedMan-code/telescope-conda.nvim", pin = true },
		-- { "nvim-telescope/telescope-dap.nvim" },
	},
}

-- A task runner and job management plugin
tool["stevearc/overseer.nvim"] = {
	-- enabled = false, -- MY: debug with clever-f find
	lazy = true,
	pin = true, -- MY: to fix if you modify the source code
	cmd = { "OverseerRun", "OverseerToggle" },
	opts = {},
	config = require("tool.overseer"),
}

-- A code runner like in vscode
tool["CRAG666/code_runner.nvim"] = {
	lazy = true,
	cmd = { "RunCode", "RunFile", "RunProject", "RunClose" },
	config = require("tool.code_runner"),
	dependencies = {
		{ "akinsho/toggleterm.nvim", config = require("tool.toggleterm") },
	},
}

return tool

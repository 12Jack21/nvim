local lang = {}

lang["epwalsh/obsidian.nvim"] = {
	lazy = true,
	event = { "BufReadPre /Users/johnson/Documents/OB_Notes/**.md" },
	dependencies = {
		"godlygeek/tabular",
		"preservim/vim-markdown",
	},
	config = require("lang.obsidian"),
}

return lang

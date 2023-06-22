local lang = {}

lang["fatih/vim-go"] = {
	lazy = true,
	ft = "go",
	build = ":GoInstallBinaries",
	config = require("lang.vim-go"),
}
lang["simrat39/rust-tools.nvim"] = {
	lazy = true,
	enabled = false, -- MY
	ft = "rust",
	config = require("lang.rust-tools"),
	dependencies = { "nvim-lua/plenary.nvim" },
}
lang["Saecki/crates.nvim"] = {
	lazy = true,
	event = "BufReadPost Cargo.toml",
	config = require("lang.crates"),
	dependencies = { "nvim-lua/plenary.nvim" },
}
lang["iamcco/markdown-preview.nvim"] = {
	lazy = true,
	ft = "markdown",
	build = ":call mkdp#util#install()",
}

-- for only markdown outline
lang["simrat39/symbols-outline.nvim"] = {
	lazy = true,
	ft = "markdown",
	config = require("lang.symbols-outline"),
}
lang["chrisbra/csv.vim"] = {
	lazy = true,
	ft = "csv",
}
lang["epwalsh/obsidian.nvim"] = {
	lazy = true,
	event = { "BufReadPre /Users/johnson/Documents/OB_Notes/**.md" },
	dependencies = {
		"nvim-lua/plenary.nvim",
		"hrsh7th/nvim-cmp",
		"nvim-telescope/telescope.nvim",
		"godlygeek/tabular",
		"preservim/vim-markdown",
	},
	config = require("lang.obsidian"),
}
return lang

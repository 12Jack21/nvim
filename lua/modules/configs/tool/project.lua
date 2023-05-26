return function()
	require("project_nvim").setup({
		manual_mode = true, -- MY: false by default
		detection_methods = { "lsp", "pattern" },
		patterns = { ".git", "_darcs", ".hg", ".bzr", ".svn", "Makefile", "package.json" },
		ignore_lsp = { "null-ls", "copilot" },
		exclude_dirs = {},
		show_hidden = false,
		silent_chdir = false, -- MY: true by default
		scope_chdir = "global",
		datapath = vim.fn.stdpath("data"),
	})
end

return {
	python = {
		analysis = {
			autoSearchPaths = true,
			diagnosticMode = "openFilesOnly", -- workspace
			useLibraryCodeForTypes = true,
			stubPath = vim.fn.stdpath("data") .. "/site/lazy/python-type-stubs",
		},
	},
}

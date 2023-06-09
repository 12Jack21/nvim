return {
	python = {
		analysis = {
			autoSearchPaths = true,
			diagnosticMode = "openFilesOnly", -- workspace
			useLibraryCodeForTypes = false, -- MY: will cause large memory consumption
			stubPath = vim.fn.stdpath("data") .. "/site/lazy/python-type-stubs",
		},
	},
}

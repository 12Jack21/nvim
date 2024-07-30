return function()
	vim.defer_fn(function()
		require("copilot").setup({
			cmp = {
				enabled = false, -- true by default
				method = "getCompletionsCycling",
			},
			panel = {
				-- if true, it can interfere with completions in copilot-cmp
				enabled = false,
			},
			suggestion = {
				-- if true, it can interfere with completions in copilot-cmp
				enabled = false,
			},
			filetypes = {
				["big_file_disabled_ft"] = false,
			},
		})
	end, 100)
end

return function()
	-- lua, default settings
	require("better_escape").setup({
		timeout = vim.o.timeoutlen,
		default_mappings = true,
		mappings = {
			i = {
				j = {
					-- These can all also be functions
					-- k = "<Esc>",
					-- `k` would be the second key of a mapping
					k = function()
						vim.api.nvim_input("<esc>")
						local current_line = vim.api.nvim_get_current_line()
						if current_line:match("^%s+j$") then
							vim.schedule(function()
								vim.api.nvim_set_current_line("")
							end)
						end
					end,
					l = "<Esc>",
				},
			},
			c = {
				j = {
					k = "<Esc>",
					j = "<Esc>",
				},
			},
			t = {
				j = {
					k = "<C-\\><C-n>",
				},
			},
			v = {
				j = {
					k = "<Esc>",
				},
			},
			s = {
				j = {
					k = "<Esc>",
				},
			},
		},
	})

	-- mapping = { "jk", "jj" }, -- a table with mappings to use
	-- mapping = { "jk","kj" }, --  Deprecated
	-- timeout = vim.o.timeoutlen, -- the time in which the keys must be hit in ms. Use option timeoutlen by default
	-- clear_empty_lines = false, -- clear line after escaping if there is only whitespace
	-- keys = "<Esc>", -- keys used for escaping, if it is a function will use the result everytime
	-- example(recommended)
	-- keys = function()
	--   return vim.api.nvim_win_get_cursor(0)[2] > 1 and '<esc>l' or '<esc>'
	-- end,
end

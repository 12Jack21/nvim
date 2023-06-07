return function()
	-- builtin support for quickfix, help, NERDtree, defx, fern, aerial, neogit, neotest, vim-startuptime, toggleterm, vim-fugitive, nvim-notify, neo-tree, nvim-dap-ui, gkeep.nvim,
	local sb = require("stickybuf")
	sb.setup({
		-- This function is run on BufEnter to determine pinning should be activated
		get_auto_pin = function(bufnr)
			-- You can return "bufnr", "buftype", "filetype", or a custom function to set how the window will be pinned
			-- The function below encompasses the default logic. Inspect the source to see what it does.
			return sb.should_auto_pin(bufnr)
		end,
	})

	-- use autocmd to pin buffers conditionally
	-- vim.api.nvim_create_autocmd("BufEnter", {
	--   desc = "Pin the buffer to any window that is fixed width or height",
	--   callback = function(args)
	--     local stickybuf = require("stickybuf")
	--     if not stickybuf.is_pinned() and (vim.wo.winfixwidth or vim.wo.winfixheight) then
	--       stickybuf.pin()
	--     end
	--   end
	-- })
end

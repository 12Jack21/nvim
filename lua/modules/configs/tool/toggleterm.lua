return function()
	local colors = require("modules.utils").get_palette()
	local floatborder_hl = require("modules.utils").hl_to_rgb("FloatBorder", false, colors.blue)

	require("toggleterm").setup({
		-- size can be a number or function which is passed the current terminal
		size = function(term)
			if term.direction == "horizontal" then
				return 15
			elseif term.direction == "vertical" then
				return math.floor(vim.o.columns * 0.30) -- 0.4 default
			end
		end,
		on_open = function()
			-- Prevent infinite calls from freezing neovim.
			-- Only set these options specific to this terminal buffer.
			vim.api.nvim_set_option_value("foldmethod", "manual", { scope = "local" })
			vim.api.nvim_set_option_value("foldexpr", "0", { scope = "local" })
		end,
		highlights = {
			FloatBorder = {
				guifg = floatborder_hl,
			},
		},
		open_mapping = false, -- [[<c-\>]],
		hide_numbers = true, -- hide the number column in toggleterm buffers
		shade_filetypes = {},
		shade_terminals = false,
		shading_factor = "1", -- the degree by which to darken to terminal colour, default: 1 for dark backgrounds, 3 for light
		start_in_insert = true,
		insert_mappings = true, -- whether or not the open mapping applies in insert mode
		persist_size = true,
		direction = "horizontal",
		close_on_exit = true, -- close the terminal window when the process exits
		shell = vim.o.shell, -- change the default shell

		auto_scroll = true, -- automatically scroll to the bottom on terminal output
		-- MY: This field is only relevant if direction is set to 'float'
		float_opts = {
			border = "rounded",
			-- like `size`, width and height can be a number or function which is passed the current terminal
			width = math.floor(vim.o.columns * 0.6),
			height = math.floor(vim.o.lines * 0.5),
			winblend = 3,
			zindex = 50,
		},
	})
end

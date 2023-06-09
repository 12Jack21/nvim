_G._command_panel = function()
	require("telescope.builtin").keymaps({
		-- MY: telescope.builtin.keymaps only show normal mode commands
		lhs_filter = function(lhs)
			return not string.find(lhs, "Þ")
		end,
		layout_config = { -- MY: configure only for command panel display (keyborad shortcuts)
			width = 0.6,
			height = 0.6,
			prompt_position = "top",
		},
	})
end

local _lazygit = nil
_G._toggle_lazygit = function()
	if vim.fn.executable("lazygit") then
		if not _lazygit then
			_lazygit = require("toggleterm.terminal").Terminal:new({ -- MY: new a toggleterm
				-- MY: default size for big viewpoint
				size = function()
					return vim.o.columns * 0.8
				end,
				cmd = "lazygit",
				direction = "float",
				close_on_exit = true,
				hidden = true,
			})
		end
		_lazygit:toggle()
	else
		vim.notify("Command [lazygit] not found!", vim.log.levels.ERROR, { title = "toggleterm.nvim" })
	end
end

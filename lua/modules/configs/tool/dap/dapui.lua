return function()
	local icons = {
		ui = require("modules.utils.icons").get("ui"),
		dap = require("modules.utils.icons").get("dap"),
	}

	require("dapui").setup({
		icons = { expanded = icons.ui.ArrowOpen, collapsed = icons.ui.ArrowClosed, current_frame = icons.ui.Indicator },
		mappings = {
			-- Use a table to apply multiple mappings
			expand = { "<CR>", "<2-LeftMouse>" },
			open = "o",
			remove = "d",
			edit = "e",
			repl = "r",
		},
		layouts = {
			{
				elements = {
					-- Provide as ID strings or tables with "id" and "size" keys
					{
						id = "scopes",
						size = 0.3, -- Can be float or integer > 1
					},
					{ id = "breakpoints", size = 0.15 },
					{ id = "watches", size = 0.15 },
					{ id = "stacks", size = 0.4 },
				},
				size = 40,
				position = "left",
			},
			-- { elements = { "repl" }, size = 10, position = "bottom" }, -- MY: move repl to right
			{
				elements = {
					{ id = "console", size = 0.3 },
					{ id = "repl", size = 0.7 },
				},
				size = 40,
				position = "right",
			},
		},
		-- Requires Nvim version >= 0.8
		controls = {
			enabled = true,
			-- Display controls in this session (buttons)
			element = "repl",
			icons = {
				pause = icons.dap.Pause,
				play = icons.dap.Play,
				step_into = icons.dap.StepInto,
				step_over = icons.dap.StepOver,
				step_out = icons.dap.StepOut,
				step_back = icons.dap.StepBack,
				run_last = icons.dap.RunLast,
				terminate = icons.dap.Terminate,
			},
		},
		floating = {
			max_height = nil,
			max_width = nil,
			mappings = { close = { "q", "<Esc>" } },
		},
		windows = { indent = 1 },
	})
end

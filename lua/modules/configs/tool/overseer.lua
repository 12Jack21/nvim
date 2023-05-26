return function()
	local overseer = require("overseer")
	overseer.setup({
		strategy = {
			"toggleterm",
			-- load your default shell before starting the task
			use_shell = false,
			-- overwrite the default toggleterm "direction" parameter
			direction = "vertical", -- nil,
			-- overwrite the default toggleterm "highlights" parameter
			highlights = nil,
			-- overwrite the default toggleterm "auto_scroll" parameter
			auto_scroll = nil,
			-- have the toggleterm window close automatically after the task exits
			close_on_exit = true,
			-- open the toggleterm window when a task starts
			open_on_start = false,
			-- mirrors the toggleterm "hidden" parameter, and keeps the task from
			-- being rendered in the toggleable window
			hidden = false,
			-- command to run when the terminal is created. Combine with `use_shell`
			-- to run a terminal command before starting the task
			on_create = nil,
		},
		templates = { "builtin", "user.cpp_build" },
		-- When true, tries to detect a green color from your colorscheme to use for success highlight
		auto_detect_success_color = true,
		-- Patch nvim-dap to support preLaunchTask and postDebugTask
		dap = true,
		task_list = {
			default_detail = 2, -- 1,2,3
			direction = "right",
			bindings = {
				["<C-i>"] = "IncreaseDetail",
				["<C-o>"] = "DecreaseDetail",
			},
		},
	})
end

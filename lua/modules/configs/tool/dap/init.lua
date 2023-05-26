return function()
	local icons = { dap = require("modules.utils.icons").get("dap") }
	local colors = require("modules.utils").get_palette()

	local dap = require("dap")
	local dapui = require("dapui")

	local nvim_tree_api = require("nvim-tree.api")

	-- MY: toggle window automatically
	dap.listeners.after.event_initialized["dapui_config"] = function()
		nvim_tree_api.tree.close()
		dapui.close() -- MY: avoid invalid window id Error
		dapui.open({ reset = true })
	end
	dap.listeners.after.event_terminated["dapui_config"] = function()
		-- MY: close specific windowLayout (except repl)
		dapui.close(1)
	end
	dap.listeners.after.event_exited["dapui_config"] = function()
		-- MY: do not close repl and console window
		dapui.close(1)
		nvim_tree_api.tree.toggle({ focus = false })
	end

	-- We need to override nvim-dap's default highlight groups, AFTER requiring nvim-dap for catppuccin.
	vim.api.nvim_set_hl(0, "DapStopped", { fg = colors.green })

	vim.fn.sign_define(
		"DapBreakpoint",
		{ text = icons.dap.Breakpoint, texthl = "DapBreakpoint", linehl = "", numhl = "" }
	)
	vim.fn.sign_define(
		"DapBreakpointCondition",
		{ text = icons.dap.BreakpointCondition, texthl = "DapBreakpoint", linehl = "", numhl = "" }
	)
	vim.fn.sign_define("DapStopped", { text = icons.dap.Stopped, texthl = "DapStopped", linehl = "", numhl = "" })
	vim.fn.sign_define(
		"DapBreakpointRejected",
		{ text = icons.dap.BreakpointRejected, texthl = "DapBreakpoint", linehl = "", numhl = "" }
	)
	vim.fn.sign_define("DapLogPoint", { text = icons.dap.LogPoint, texthl = "DapLogPoint", linehl = "", numhl = "" })

	-- Config lang adaptors
	require("tool.dap.dap-lldb")
	require("tool.dap.dap-debugpy")
	require("tool.dap.dap-dlv")
end

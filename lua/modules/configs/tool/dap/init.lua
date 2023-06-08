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
		nvim_tree_api.tree.open({ focus = false })
	end
	dap.listeners.after.event_exited["dapui_config"] = function()
		-- MY: do not close repl and console window
		dapui.close(1)
		nvim_tree_api.tree.open({ focus = false }) -- not work on go debug
	end

	-- add support for dap hover evaluation
	-- Map K to hover while session is active
	local api = vim.api
	local keymap_restore = {}
	dap.listeners.after["event_initialized"]["me"] = function()
		for _, buf in pairs(api.nvim_list_bufs()) do
			local keymaps = api.nvim_buf_get_keymap(buf, "n")
			for _, keymap in pairs(keymaps) do
				if keymap.lhs == "K" then
					table.insert(keymap_restore, keymap)
					api.nvim_buf_del_keymap(buf, "n", "K")
				end
			end
		end
		-- MY TODO: make the window can quit with q instead of <Cmd>q
		api.nvim_set_keymap("n", "K", '<Cmd>lua require("dap.ui.widgets").hover()<CR>', { silent = true })
	end
	dap.listeners.after["event_terminated"]["me"] = function()
		for _, keymap in pairs(keymap_restore) do
			api.nvim_buf_set_keymap(keymap.buffer, keymap.mode, keymap.lhs, keymap.rhs, { silent = keymap.silent == 1 })
		end
		keymap_restore = {}
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

	-- install dap for some langs
	require("mason").setup()
	require("mason-nvim-dap").setup({
		ensure_installed = require("core.settings").dap_deps,
	})

	-- Config lang adaptors
	require("tool.dap.dap-lldb")
	require("tool.dap.dap-debugpy")
	require("tool.dap.dap-dlv")
end

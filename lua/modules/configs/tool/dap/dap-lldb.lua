local dap = require("dap")

-- telescope selection
local pickers = require("telescope.pickers")
local finders = require("telescope.finders")
local conf = require("telescope.config").values
local actions = require("telescope.actions")
local action_state = require("telescope.actions.state")

dap.adapters.lldb = {
	-- type = "executable",
	-- command = "codelldb",
	name = "lldb",
	type = "server",
	host = "127.0.0.1",
	port = 13000,
	executable = {
		-- CHANGE THIS to your path!
		-- command = "codelldb",
		-- command = vim.fn.stdpath("data") .. "/mason/bin/codelldb",
		command = "/usr/local/opt/llvm/bin/lldb-vscode",
		args = { "--port", "13000" },
		-- On windows you may have to uncomment this:
		-- detached = false,
	},
}
dap.configurations.cpp = {

	{
		name = "Current File",
		type = "lldb",
		request = "launch",
		program = function()
			-- return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
			return vim.fn.getcwd() .. "/" .. vim.fn.expand("%:r")
		end,
		-- cwd = "${workspaceFolder}",
		cwd = "${fileDirname}",
		stopOnEntry = false,
		args = function()
			-- local input = vim.fn.input("Input args: ")
			-- return vim.fn.split(input, " ", true)
			return ""
		end,
		runInTerminal = true,

		-- preLaunchTask = "clang++17 build",
		preLaunchTask = "clang++17 build",
		postDebugTask = nil,

		-- console = "integratedTerminal",
	},
	{
		name = "Launch an executable",
		type = "lldb", -- cppdbg (cpptools support)
		request = "launch",
		cwd = "${workspaceFolder}",
		program = function()
			return coroutine.create(function(coro)
				local opts = {}
				pickers
					.new(opts, {
						prompt_title = "Path to executable",
						finder = finders.new_oneshot_job({ "fd", "--hidden", "--no-ignore", "--type", "x" }, {}),
						sorter = conf.generic_sorter(opts),
						attach_mappings = function(buffer_number)
							actions.select_default:replace(function()
								actions.close(buffer_number)
								coroutine.resume(coro, action_state.get_selected_entry()[1])
							end)
							return true
						end,
					})
					:find()
			end)
		end,
	},

	-- {
	-- 	name = "Launch Project",
	-- 	type = "lldb",
	-- 	request = "launch",
	-- 	program = function()
	-- 		return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
	-- 	end,
	-- 	cwd = "${workspaceFolder}",
	-- 	stopOnEntry = false,
	-- 	args = function()
	-- 		local input = vim.fn.input("Input args: ")
	-- 		return vim.fn.split(input, " ", true)
	-- 	end,

	-- 	-- if you change `runInTerminal` to true, you might need to change the yama/ptrace_scope setting:
	-- 	--
	-- 	--    echo 0 | sudo tee /proc/sys/kernel/yama/ptrace_scope
	-- 	--
	-- 	-- Otherwise you might get the following error:
	-- 	--
	-- 	--    Error on launch: Failed to attach to the target process
	-- 	--
	-- 	-- But you should be aware of the implications:
	-- 	-- https://www.kernel.org/doc/html/latest/admin-guide/LSM/Yama.html
	-- 	runInTerminal = false, -- false
	-- },
}

-- TODO
dap.configurations.c = dap.configurations.cpp
dap.configurations.rust = dap.configurations.cpp

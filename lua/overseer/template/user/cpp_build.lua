return {
	name = "clang++17 build",
	builder = function()
		-- Full path to current file (see :help expand())
		local file = vim.fn.expand("%:p")
		local filenameWoExt, filenameExt = vim.fn.expand("%:p:r"), vim.fn.expand("%:e")
		local fileDir = vim.fn.expand("%:p:h")
		-- print("overseer fileDir = ", fileDir)
		return {
			name = "clang++17 build",
			cmd = { "clang++" },
			args = { "-std=c++17", "-fdiagnostics-color=always", "-g", file, "-o", filenameWoExt },
			cwd = fileDir,
			-- the list of components or component aliases to add to the task
			components = {
				{
					"on_output_quickfix",
					open = true,
					close = true, -- close if no error occurs
					set_diagnostics = true, -- Add the matching items to vim.diagnostics
					items_only = true, -- Only show lines that match the errorformat
				},
				{
					"on_complete_dispose", -- when task completed, it will disappear in overseer window
					statuses = { "SUCCESS", "CANCELED" }, --  "FAILURE"
					timeout = 300, -- 300 seconds by default
				},

				{ "display_duration", detail_level = 2 },
				"on_output_summarize",
				"on_exit_set_status",
				"on_complete_notify",
				"on_complete_dispose",

				-- "default",
			},
			-- additional environment variables
			env = {
				VAR = "FOO",
			},
			-- arbitrary table of data for your own personal use
			metadata = {
				foo = "bar",
			},
		}
	end,
	-- Optional fields
	desc = "", -- "Optional description of task",
	-- Tags can be used in overseer.run_template()
	tags = { require("overseer").TAG.BUILD },
	params = {
		-- See :help overseer-params
	},
	-- Determines sort order when choosing tasks. Lower comes first.
	priority = 5,
	-- Add requirements for this template. If they are not met, the template will not be visible.
	-- All fields are optional.
	condition = {
		-- A string or list of strings
		-- Only matches when current buffer is one of the listed filetypes
		filetype = { "cpp" },
		-- A string or list of strings
		-- Only matches when cwd is inside one of the listed dirs

		-- dir = "/home/user/my_project",

		-- Arbitrary logic for determining if task is available
		callback = function(search)
			-- print(vim.inspect(search))
			return true
		end,
	},
}

return function()
	local colors = require("modules.utils").get_palette()
	local icons = {
		diagnostics = require("modules.utils.icons").get("diagnostics", true),
		misc = require("modules.utils.icons").get("misc", true),
		ui = require("modules.utils.icons").get("ui", true),
	}

	local function escape_status()
		local ok, m = pcall(require, "better_escape")
		return ok and m.waiting and icons.misc.EscapeST or ""
	end

	local _cache = { context = "", bufnr = -1 }

	local function diff_source()
		local gitsigns = vim.b.gitsigns_status_dict
		if gitsigns then
			return {
				added = gitsigns.added,
				modified = gitsigns.changed,
				removed = gitsigns.removed,
			}
		end
	end

	local function get_cwd()
		local cwd = vim.fn.getcwd()
		local is_windows = require("core.global").is_windows
		if not is_windows then
			local home = require("core.global").home
			if cwd:find(home, 1, true) == 1 then
				cwd = "~" .. cwd:sub(#home + 1)
			end
		end
		return icons.ui.RootFolderOpened .. cwd
	end

	local function get_filepath()
		return vim.fn.expand("%:.")
	end

	local mini_sections = {
		lualine_a = { "filetype" },
		lualine_b = {},
		lualine_c = {},
		lualine_x = {},
		lualine_y = {},
		lualine_z = {},
	}
	local diffview = {
		sections = mini_sections,
		filetypes = { "DiffviewFiles" },
	}

	local function python_venv()
		local function env_cleanup(venv)
			if string.find(venv, "/") then
				local final_venv = venv
				for w in venv:gmatch("([^/]+)") do
					final_venv = w
				end
				venv = final_venv
			end
			return venv
		end

		if vim.bo.filetype == "python" then
			local venv = os.getenv("CONDA_DEFAULT_ENV")
			if venv then
				return string.format("%s", env_cleanup(venv))
			end
			venv = os.getenv("VIRTUAL_ENV")
			if venv then
				return string.format("%s", env_cleanup(venv))
			end
		end
		return ""
	end

	local overseer = require("overseer")

	require("lualine").setup({
		options = {
			icons_enabled = true,
			theme = "catppuccin",
			disabled_filetypes = {},
			component_separators = "|",
			section_separators = { left = "", right = "" },
		},
		sections = {
			-- MY: statusline configure here
			lualine_a = { { "mode" } },
			lualine_b = { { "branch" }, { "diff", source = diff_source } },
			lualine_x = {
				-- task manager
				{
					"overseer", -- task manager
					label = "", -- Prefix for task counts
					colored = true, -- Color the task icons and counts
					symbols = {
						[overseer.STATUS.FAILURE] = "F:",
						[overseer.STATUS.CANCELED] = "C:",
						[overseer.STATUS.SUCCESS] = "S:",
						[overseer.STATUS.RUNNING] = "R:",
					},
					unique = false, -- Unique-ify non-running task count by name
					name = nil, -- List of task names to search for
					name_not = false, -- When true, invert the name search
					status = nil, -- List of task statuses to display
					status_not = false, -- When true, invert the status search
				},
				{ escape_status },
				{
					"diagnostics",
					sources = { "nvim_diagnostic" },
					symbols = {
						error = icons.diagnostics.Error,
						warn = icons.diagnostics.Warning,
						info = icons.diagnostics.Information,
						hint = icons.diagnostics.Hint_alt,
					},
				},
				-- { get_cwd },
				{ get_filepath },
			},
			lualine_y = {
				{ "filetype", colored = true, icon_only = true },
				{ python_venv },
				{ "encoding" },
				{
					"fileformat",
					icons_enabled = true,
					symbols = {
						unix = "LF",
						dos = "CRLF",
						mac = "CR",
					},
				},
			},
			lualine_z = { "progress", "location" },
		},
		-- winbar is just another lualine, but locate in top of window instead
		-- winbar = {
		-- 	lualine_a = {},
		-- 	lualine_b = {},
		-- 	lualine_c = {
		-- 		{
		-- 			"filename",
		-- 			path = 1,
		-- 		},
		-- 	},
		-- 	lualine_x = {},
		-- 	lualine_y = {},
		-- 	lualine_z = {},
		-- },
		-- inactive_winbar = {
		-- 	lualine_a = {},
		-- 	lualine_b = {},
		-- 	lualine_c = {
		-- 		{
		-- 			"filename",
		-- 			path = 1,
		-- 		},
		-- 	},
		-- 	lualine_x = {},
		-- 	lualine_y = {},
		-- 	lualine_z = {},
		-- },
		inactive_sections = {
			lualine_a = {},
			lualine_b = {},
			lualine_c = { "filename" },
			lualine_x = { "location" },
			lualine_y = {},
			lualine_z = {},
		},
		tabline = {
			-- configure this will overwrite bufferline
		},
		extensions = {
			"quickfix",
			"nvim-tree",
			"toggleterm",
			"fugitive",
			diffview,
		},
	})

	local winbar_bg = require("modules.utils").hl_to_rgb("StatusLine", true, colors.mantle)
end

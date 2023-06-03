return function()
	local icons = { ui = require("modules.utils.icons").get("ui", true) }
	local lga_actions = require("telescope-live-grep-args.actions")

	local previewers = require("telescope.previewers")
	local Job = require("plenary.job")
	local new_maker = function(filepath, bufnr, opts)
		filepath = vim.fn.expand(filepath)

		-- ignore files bigger than a threshold
		-- opts = opts or {}
		-- vim.loop.fs_stat(filepath, function(_, stat)
		-- 	if not stat then
		-- 		return
		-- 	end
		-- 	if stat.size > 100000 then
		-- 		return
		-- 	else
		-- 		previewers.buffer_previewer_maker(filepath, bufnr, opts)
		-- 	end
		-- end)

		-- diable binary preview
		Job:new({
			command = "file",
			args = { "--mime-type", "-b", filepath },
			on_exit = function(j)
				local mime_type = vim.split(j:result()[1], "/")[1]
				if mime_type == "text" then
					previewers.buffer_previewer_maker(filepath, bufnr, opts)
				else
					-- maybe we want to write something to the buffer here
					vim.schedule(function()
						vim.api.nvim_buf_set_lines(bufnr, 0, -1, false, { "BINARY" })
					end)
				end
			end,
		}):sync()
	end

	require("telescope").setup({
		defaults = {
			initial_mode = "insert",
			prompt_prefix = " " .. icons.ui.Telescope .. " ",
			selection_caret = icons.ui.ChevronRight,
			scroll_strategy = "limit",
			results_title = false,
			layout_strategy = "horizontal",
			path_display = { "absolute" },
			file_ignore_patterns = { ".git/", ".cache", "%.class", "%.pdf", "%.mkv", "%.mp4", "%.zip", "node_modules/" },
			layout_config = {
				horizontal = {
					preview_width = 0.5,
				},
			},
			buffer_previewer_maker = new_maker, -- custom maker
			file_previewer = previewers.vim_buffer_cat.new,
			-- file_previewer = previewers.cat.new, -- use bat for preview
			grep_previewer = previewers.vim_buffer_vimgrep.new,
			qflist_previewer = previewers.vim_buffer_qflist.new,
			file_sorter = require("telescope.sorters").get_fuzzy_file,
			generic_sorter = require("telescope.sorters").get_generic_fuzzy_sorter,
			-- vimgrep_arguments = {
			-- 	"rg",
			-- 	"--color=auto",
			-- 	"--no-heading",
			-- 	"--with-filename",
			-- 	"--line-number",
			-- 	"--column",
			-- 	"--smart-case",
			-- 	"--trim", -- add this value
			-- },
		},
		pickers = {
			find_files = {
				mappings = {
					-- enter selected file's directory
					n = {
						["cd"] = function(prompt_bufnr)
							local selection = require("telescope.actions.state").get_selected_entry()
							local dir = vim.fn.fnamemodify(selection.path, ":p:h")
							require("telescope.actions").close(prompt_bufnr)
							-- Depending on what you want put `cd`, `lcd`, `tcd`
							-- MY: cd to new directory (lcd: local cd for current window, tcd: local cd for current tab)
							vim.cmd(string.format("silent lcd %s", dir))
						end,
					},
				},
			},
			keymaps = {
				theme = "dropdown",
			},
			-- buffers = {
			-- 	initial_mode = "normal",
			-- },
		},
		extensions = {
			fzf = {
				fuzzy = true, -- false by default
				override_generic_sorter = true,
				override_file_sorter = true,
				case_mode = "smart_case",
			},
			frecency = {
				show_scores = true,
				show_unindexed = true,
				ignore_patterns = { "*.git/*", "*/tmp/*" },
			},
			live_grep_args = {
				auto_quoting = true, -- enable/disable auto-quoting
				-- define mappings, e.g.
				mappings = { -- extend mappings
					i = {
						["<C-k>"] = lga_actions.quote_prompt(),
						["<C-i>"] = lga_actions.quote_prompt({ postfix = " --iglob " }),
					},
				},
			},
			undo = {
				side_by_side = true,
				mappings = { -- this whole table is the default
					i = {
						-- IMPORTANT: Note that telescope-undo must be available when telescope is configured if
						-- you want to use the following actions. This means installing as a dependency of
						-- telescope in it's `requirements` and loading this extension from there instead of
						-- having the separate plugin definition as outlined above. See issue #6.
						["<cr>"] = require("telescope-undo.actions").yank_additions,
						["<S-cr>"] = require("telescope-undo.actions").yank_deletions,
						["<C-cr>"] = require("telescope-undo.actions").restore,
					},
				},
			},
			file_browser = {
				theme = "ivy",
				-- disables netrw and use telescope-file-browser in its place
				hijack_netrw = true,
				mappings = {
					["i"] = {
						-- your custom insert mode mappings
					},
					["n"] = {
						-- your custom normal mode mappings
					},
					["t"] = {
						-- your custom terminal mode mappings
					},
				},
			},
			media_files = {
				-- filetypes whitelist
				-- defaults to {"png", "jpg", "mp4", "webm", "pdf"}
				filetypes = { "png", "webp", "jpg", "jpeg" },
				-- find command (defaults to `fd`)
				find_cmd = "rg",
			},
		},
	})

	require("telescope").load_extension("frecency")
	require("telescope").load_extension("fzf")
	require("telescope").load_extension("live_grep_args")
	require("telescope").load_extension("notify")
	require("telescope").load_extension("projects")
	require("telescope").load_extension("undo")
	require("telescope").load_extension("zoxide")
	require("telescope").load_extension("file_browser")
	require("telescope").load_extension("media_files")

	-- require("telescope").load_extension("dap") -- MY: add dap support (preLaunchTask wrong!)
end

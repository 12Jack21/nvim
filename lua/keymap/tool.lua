local bind = require("keymap.bind")
local map_cr = bind.map_cr
local map_cu = bind.map_cu
local map_cmd = bind.map_cmd
local map_callback = bind.map_callback
require("keymap.helpers")

local plug_map = {
	-- Plugin: nvim-tree
	["n|<C-n>"] = map_cr("NvimTreeToggle"):with_noremap():with_silent():with_desc("filetree: Toggle"),
	["n|<leader>nf"] = map_cr("NvimTreeFindFile"):with_noremap():with_silent():with_desc("filetree: Find file"),
	["n|<leader>nr"] = map_cr("NvimTreeRefresh"):with_noremap():with_silent():with_desc("filetree: Refresh"),

	-- Plugin: toggleterm
	["t|<Esc><Esc>"] = map_cmd([[<C-\><C-n>]]):with_noremap():with_silent(), -- switch to normal mode in terminal.
	["n|<A-h>"] = map_cr([[execute v:count . "ToggleTerm direction=horizontal"]])
		:with_noremap()
		:with_silent()
		:with_desc("terminal: Toggle horizontal"),
	["i|<A-h>"] = map_cmd("<Esc><Cmd>ToggleTerm direction=horizontal<CR>")
		:with_noremap()
		:with_silent()
		:with_desc("terminal: Toggle horizontal"),
	["t|<A-h>"] = map_cmd("<Cmd>ToggleTerm<CR>"):with_noremap():with_silent():with_desc("terminal: Toggle horizontal"),
	["n|<A-v>"] = map_cr([[execute v:count . "ToggleTerm direction=vertical"]])
		:with_noremap()
		:with_silent()
		:with_desc("terminal: Toggle vertical"),
	["i|<A-v>"] = map_cmd("<Esc><Cmd>ToggleTerm direction=vertical<CR>")
		:with_noremap()
		:with_silent()
		:with_desc("terminal: Toggle vertical"),
	["t|<A-v>"] = map_cmd("<Cmd>ToggleTerm<CR>"):with_noremap():with_silent():with_desc("terminal: Toggle vertical"),
	["n|<A-i>"] = map_cr([[execute v:count . "ToggleTerm direction=float"]])
		:with_noremap()
		:with_silent()
		:with_desc("terminal: Toggle float"),
	["i|<A-i>"] = map_cmd("<Esc><Cmd>ToggleTerm direction=float<CR>")
		:with_noremap()
		:with_silent()
		:with_desc("terminal: Toggle float"),
	["t|<A-i>"] = map_cmd("<Cmd>ToggleTerm<CR>"):with_noremap():with_silent():with_desc("terminal: Toggle float"),
	["n|<leader>gg"] = map_callback(function()
			_toggle_lazygit()
		end)
		:with_noremap()
		:with_silent()
		:with_desc("git: Toggle lazygit"),

	-- Plugin: trouble
	["n|<leader>tt"] = map_cr("Trouble diagnostics toggle filter.severity={vim.diagnostic.severity.WARN,vim.diagnostic.severity.ERROR}")
		:with_noremap()
		:with_silent()
		:with_desc("Trouble: Diagnostics toggle"),
	["n|gr"] = map_cr("Trouble lsp_references toggle")
		:with_noremap()
		:with_silent()
		:with_desc("Trouble: Show lsp references"),
	["n|gd"] = map_cr("Trouble lsp toggle focus=true win.position=right")
		:with_noremap()
		:with_silent()
		:with_desc("Trouble: LSP Definitions / references / ... "),
	["n|gw"] = map_cr("Trouble symbols toggle focus=false")
		:with_noremap()
		:with_silent()
		:with_desc("Symbols (Trouble)"),
	["n|gq"] = map_cr("Trouble loclist toggle")
		:with_noremap()
		:with_silent()
		:with_desc("Trouble: Location List toggle"),
	["n|gl"] = map_cr("Trouble qflist toggle")
		:with_noremap()
		:with_silent()
		:with_desc("Trouble: Quickfix List toggle"),

	-- Plugin: telescope
	["n|<C-p>"] = map_callback(function()
			_command_panel()
		end)
		:with_noremap()
		:with_silent()
		:with_desc("tool: Toggle command panel"),
	["n|<leader>fe"] = map_cu("Telescope oldfiles"):with_noremap():with_silent():with_desc("find: File by history"),
	["n|<leader>ff"] = map_cu("Telescope find_files"):with_noremap():with_silent():with_desc("find: File in project"),
	["n|<leader>fc"] = map_cu("Telescope colorscheme")
		:with_noremap()
		:with_silent()
		:with_desc("ui: Change colorscheme for current session"),
	["n|<leader>fn"] = map_cu(":enew"):with_noremap():with_silent():with_desc("buffer: New"),
	["n|<leader>fg"] = map_cu("Telescope git_files")
		:with_noremap()
		:with_silent()
		:with_desc("find: file in git project"),
	["n|<leader>fb"] = map_cu("Telescope buffers"):with_noremap():with_silent():with_desc("find: Buffer opened"),
	["n|<leader>fs"] = map_cu("Telescope grep_string"):with_noremap():with_silent():with_desc("find: Current word"),
}

bind.nvim_load_mapping(plug_map)

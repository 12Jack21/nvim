# Neovim config is all you need

> This configuration is based on [nvimdots](https://github.com/ayamir/nvimdots), and make modification for individual demand.

## Installation

- \*nix

```shell
if command -v curl >/dev/null 2>&1; then
    bash -c "$(curl -fsSL https://raw.githubusercontent.com/12Jack21/nvim/HEAD/scripts/install.sh)"
else
    bash -c "$(wget -O- https://raw.githubusercontent.com/12Jack21/nvim/HEAD/scripts/install.sh)"
fi
```

## Basic

- `<leader>`: " " (\<space\>)
- `<C-p>` will show the **_command palettes_**, to check the keyboard shortcuts

## Core operations

- statusline show file path
- code comment with `<leader>gc`
- `lazy.nvim` disable plugins: neoscroll: animation during cursor movement
- toggle float term `<A-d>` , horizontal `<A-h>`, vertical `<A-v>` in normal mode
- nvim-treesitter will _failed_ at the first setup, then succeed when you coding
- `<A-*>` is unavailable in **_tmux_** environment
- Theme selection: catppucin-frappe, catppucin-macchiato, edge
- tab switch use `<M-j><A-k>`, close current usi¬ng `<M-q>`
- `<C-g>` show the file path
- `<A-l>` out of some pairs like "", '', {}, `<A-o>` go back

- use `<A-o> <A-p>` to move between **_iTerm2_** panes
- use `<C-]>` in nvimtree to enter a directory and show it as root folder
- use `m{letter}` to add bookmark and `'{letter}` or " \`{letter} " to go to that bookmark
- use `project.nvim` to manage your project directories, it will use the folder where you open nvim as the root directory
- use `<z-a><z-A>` or `<S-tab>` to fold/unfold current block, see more in `<z-` leadding key-combination
- `nvim-surround` plugin: `ds[` to delete text inside [], `cs[(` change \[ to \( pair, `ysiw{` add \{ pair to selected word
- use "\`bt" to run _lldb command_ in dap (use lldb-vscode adapter)
- use nvim file modifiers [here](https://neovim.io/doc/user/cmdline.html#filename-modifiers)
- If a keyboard shortcut does not work in neovim, consider the terminal emulator (e.g. iTerm2) do not map specific key to some weird behaviors, like `<S-F5>` key
- The _location list_ is exactly same as _quickfix_, just that it's private to each window, quickfix is global to neovim.
- `clever-f.nvim` extend the function of `f/F` and `t/T`, use `f{char}` find a word match, then hit `f` multiple times to find next match
- use `<leader>dl` to make dap run last debug session again
- use `<leader><backspace>` to show more shortcuts
- use`<Cmd>set wrap/nowrap` to wrap/nowrap the current window
- use `todo-comments.nvim` for TODO stuff
- mason stuff will be stored in `~/.local/share/nvim/mason/bin/`

---

### Issues

- [x] remove `<C-u>` animation
- [x] remove `whichwrap` to disable automatedly jump to next line
- [x] term scroll with mouse (not history)
  - **iTerm2** toggle the entry for _Scroll wheel sends arrow keys when in alternate screen mode_ from **Yes** to **No**.
  - nvim's terminal has normal mode and terminal mode(when edit), we can move in normal mode (use `jk` to switch to it)
- [x] toggleTerm size : `float_opt` for toggleterm.nvim
- [x] mouse disabled
- [x] nvim show different color inside and outside tmux
  - edit `~/.tmux.conf`, add `set -g default-terminal "xterm-256color"` and `set-option -ga terminal-overrides ",xterm-256color:Tc"`; after all, execute `tmux source ~/.tmux.conf` to make configs take effect
- [x] tagbar support
  - use lsp outline instead: `go` shortcut
- [x] completion not working on lua
  - just casual issue
- [x] toggle warning message display

```lua
-- on file lsp.lua, doesn't work now!!!
vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
  vim.lsp.diagnostic.on_publish_diagnostics, {
    signs = {
      severity_limit = "Hint",  -- do not work?
    },
    virtual_text = {
      severity_limit = "Warning",
    },
  }
)

-- MY: diagnostics got moved away from lsp scope so upper code doesn't work, config it using native neovim api
vim.diagnostic.config({
	virtual_text = {
		severity = { min = vim.diagnostic.severity.ERROR },
	},
	signs = true,
	underline=true,
	-- signs = {
	-- 	severity = { min = vim.diagnostic.severity.WARN },
	-- },
})
```

- [x] use flake8 as python linter, pyright as language-server (pylint is too strict)
- [x] pyright do not show ERROR diagnostic in .py file but flake8 can
  - after reset `vim.lsp.handler` (something I think do not work ~aforementioned), it can take effect
- [x] test DAP debug on python(conda)
- [x] nvim-tmux.nvim plugin (https://github.com/alexghergh/nvim-tmux-navigation)
  - tmux packager can solve this (maybe parts of it)
- [x] `tabout.nvim` plugin (quickly jump out of some pairs like "", '', or {})
- [x] tmux install tpm (tmux package manager) !
- [x] nvimtree freeze the nvim when open big project's python file (like ATLOP folder)
  - It's caused by pyright diagnostic the whole big workspace
- [x] lsp doc show on top of funciton which is not a good position
  - configure plugin `lsp_signature.nvim` , set `floating_window_above_cur_line = false`
- [x] toggleterm.nvim cannot use multiple terms easily
  - add `floaterm` to support, edit keymap for it
- [x] `nvim-surround` plugin support
- [x] use `ncdu` to replace `du`, `exa` to replace `ls`, `git cz` to replace `git commit`, try `lazygit`
- [x] terminal file manager: [mc](https://github.com/MidnightCommander/mc), ranger, lf, vifm, nnn(`nnn.nvim`)
- [x] system resouce manager: htop, btop
- [x] brew update Source to inside China (write to `~/.zprofile`)
- [x] ranger cannot run when there's no tmux instance
  - you should not set `export TMUX` when tmux is not running, it will be automatically set when tmux instance is running
  - master `ranger` usage
- [x] more telescope showcases, like in LSP: https://github.com/nvim-telescope/telescope.nvim/wiki/Showcase#keymaps (can only show normal mode keymaps)
- [x] nvimtree change root directory incorrectly _!!!_ `updateRoot=false` when focus on file
  - `project.nvim` plugin
- [x] disable cursor change when scroll the screen (off screen cursor)
  - why neovim don't fix this: https://github.com/neovim/neovim/issues/279
  - use bookmark to do this
- [x] mason.nvim cannot find package "black",etc . null-ls formater not work
  - solution: https://github.com/williamboman/mason.nvim/issues/1020
  - make `mason` at nvim setup time, not defer to the time run `:Mason`
  - **_Solution_**: adjust mason, mason-null-ls, null-ls setup order, correct the syntax error in clang-format params or other formaters (e.g. black)
- [x] make `nvim-treesitter` variable highlight more lighter Or change the _theme_
  - not necessary to do this
- [x] `nvimtree` do not update root folder, use current termial directory as root, and don't change it unless using `cd` like commands
  - set `manual_mode = true` in config of plugin `project.nvim`

```lua configured for nvim-tree
require("nvim-tree").setup({
  sync_root_with_cwd = true,
  respect_buf_cwd = true,
  update_focused_file = {
    enable = true,
    update_root = true
  },
})
```

- [x] function fold and unfold `za`, `zA`
- [x] try `vim-projectroot` like in vscode root, but telescope search area cannot update automatically
  - has bug to open file in project, but can change workspace root directory, so that's okay for me
- [x] file undo history
  - telescope show it `<leader>u`
- [x] add `neodev.nvim` plugin for neovim lua syntax support
- [x] dap cannot run lldb command
  - use `lldb-vscode` adapter instead
- [x] issue: "Do you need to configure your work environment as `luv`"
  - It's a prompt from `neodev.nvim` ,add some lua types for neovim
  - solution: https://github.com/LunarVim/LunarVim/issues/4049
- [x] add keymap for repl+console window toggle `<leader>dt`
- [x] `nvim-dap-ui` cannot handle the situation that user close _repl_ or _console_ window personally (found invalid window id)
  - if `:q` or `:close` one window, you can close another one, and dapui will reset them
  - Or, you can add `dapui.close()` before `dapui.open({reset=true})`
- [x] `nvim-tree` toggle after dap debug session ends, but cursor will focus on nvim-tree instead of the editor
  - use `dapui.open({ reset = true })` and `nvim_tree_api.tree.toggle({ focus = false })` in dap.listeners
- [x] cpp single file dev conv (compile, run and debug)
  - add config to `dap.configurations.dap-repl` ? no need
  - nvimtree do not toggle when dap debug session ends, or do not hide when _REPL_(read, eval, print, loop) ui appears
  - hover var to show eval variables (in `dapui.eval`)
  - `cmp-dap` support (temporarily not visible)
  - add telescope support (for selecting an executable to debug) : run `<Cmd>Telescope dap {commands/configurations/frames/variables/list_breakpoints}`
  - _multiple_ dap config cannot trigger **preLaunchTask** to run !!! Ans: caused by `telescope-dap` extension
- [x] setup `overseer.nvim` with third_party integration
  - move toggle window to right
  - add components for overseer, e.g. show quickfix list (local list)
  - become preLaunchTask for DAP debug
  - add keymap to toggle task window
  - autosession integration to get persistent task session
  - Default task to run, no need to select ??? Ans: yes, dap will run **_preLaunchTask_**
  - issue: Error detected while processing function clever_f#find_with, when `f` find word during overseer window opened Ans: we use `clever-f` instead of original `f/t`, so it's `clever-f` plugin's bug
- [x] `clever-f.nvim` do not work in other windows except editor
  - use `hop.nvim` instead ?
  - when close `overseer.nvim`, the problem doesn'ts exist
  - when disable `display-duration` component of overseer, everything looks fine
  - Solution: add `timer:close()` in `~/.local/share/nvim/site/lazy/overseer.nvim/lua/overseer/component/display_duration.lua:42` (timer has not closed after task completion)
- [x] always in normal mode when dap debug session ends with one quickfix window opened
  - issue [here](https://github.com/neovim/neovim/issues/22924) and [here](https://github.com/akinsho/flutter-tools.nvim/issues/243)
  - change to neovim nightly may fix
- [x] add `sniprun.nvim`, `overseer.nvim` (A task runner and job management plugin for Neovim), `cmp.nvim` plugin to works like vscode debug and code runner
  - [x] cargo may need to clear `sudo dscacheutil -flushcache; sudo killall -HUP mDNSResponder`
    - issue has gone for no reason ......
    - ref: https://blog.csdn.net/qq_37555071/article/details/114260533
    - Inner China cargo: https://github.com/wtklbm/crm
  - `sniprun` has big limitation
- [x] extend `toggleterm` for `code_runner` instead of using weak betterterm.nvim !!!
  - use `2TermExec cmd="git status"`
- [x] try `asynctasks.nvim` [here](https://github.com/skywind3000/asynctasks.vim) instead of `overseer.nvim`
- [x] add hop in multiple-window keybindding
- [x] dap-ui repl wrap the text output !
  - use `<Cmd>set wrap`
- [x] dap configuration for go
  - delve debugger does not support `runInTerminal`, so stdin cannot be used
- [x] `overseer.nvim` plugin set window wrap lines
  - add `<leader>ow` keymap
  - use `vim.opt_local.wrap = true` to control current window wrap
- [x] `display_duration` error
  - add `timer:close()` after table insert (on_complete function)
- [x] _high latency_ when hit \<space\> (the leader key) in toggleterm insert mode (terminal mode).
  - do not set keymap with leader key in terminal mode, cause I set toggle Floaterm in terminal mode
- [x] try `nvim-gdb` or `nvim-lldb` for native lldb command support, not dap command
  - too native to use
- [x] flake8's extra_args not work in null-ls.nvim, only flake8 default args works, cause it spawn two flake8, and use the first one
- [x] setup `todo-comments.nvim`: PERF(fully optimised), HACK, TODO, NOTE, FIX, WARNING
- [x] teledrive for storage: too slow to use, and has single file limitation
- [x] excalidraw (also has obsidian plugin)
- [x] add keymap to toggle virtual text severity (show all warning message): warning message is enough
- [x] recover `gt` to switch tab
  - `gt` function is on, but `bufferline.nvim` do not create new tab for new file opened from nvim-tree
- [x] get filepath: local filename = vim.fn.expand("%:t") local absolute_filepath = vim.fn.expand("%:p") local relative_filepath = vim.fn.expand("%:.")
- [x] disable `copilot.nvim` for completion
- [x] use `ven-selector.nvim` to select virtual python env inside neovim
  - set search path for the plugin
  - see what `conda activate ` do: https://nielscautaerts.xyz/make-active-conda-environment-persist-in-neovim-terminal.html
  - it's just for python _venv_, not conda
  - use `conda` (https://github.com/IllustratedMan-code/telescope-conda.nvim) instead
- [x] `telescope-conda.nvim` select conda env, but pyright failed to start in new env
  - `LspRestart` won't work in keymap setting, but works in command mode: LSP should be restarted on a specific buffer number
  - add `vim.cmd("LspRestart")` to `conda/main.lua:114` of plugin source code
- [x] In lazygit window (make it bigger in toggleterm)

- [ ] Make a **_summary_** of all the useful tools you use !!!
- [ ] try `neorg`
- [ ] try `nvim-lint`, an asynchronous linter plugin (alternative for `null-ls.nvim`)
- [ ] GNU info (a great documentation reader)
- [ ] pyright do not resolve numpy member
  - understand the _stubs_, and try this: https://github.com/typeddjango/awesome-python-typing#stub-packages
  - use this： https://github.com/microsoft/pyright/issues/4878#issuecomment-1553156526 to add stubs for popular lib (`stubPath = vim.fn.stdpath("data") .. "/lazy/python-type-stubs"`)
  - Try `jedi-language-server` in lspconfig (https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md#jedi_language_server): `require'lspconfig'.jedi_language_server.setup{}`
- [ ] neovim freeze
  - `workspace/didChangeWatchedFiles` enable, https://github.com/neovim/neovim/issues/23291tps://github.com/neovim/neovim/issues/23291
- [ ] nnn file manager beautify, start with `nnn -e`
- [ ] iTerm2 themes backup and add new themes
- [ ] tmux integration in iTerm2
  - `tmux -CC attach -t SESSION_NAME` new window in iTerm2 profile
- [ ] know and try to use `fugitive.nvim` plugin
  - lazygit is an alternative, but maybe can be collaborator
- [ ] ranger or nnn (file manager) for neovim, or `telescope-file-browser.nvim` plugin
- [ ] Persistent breakpoints with [this](https://github.com/Weissle/persistent-breakpoints.nvim)
- [ ] `autosession.nvim` sometimes not working (store meta in where?)
- [ ] try `harpoon` (https://github.com/ThePrimeagen/harpoon) (less keystroke)
- [ ] extend telescope, like in https://github.com/nvim-telescope/telescope.nvim/wiki/Configuration-Recipes#previewers
- [ ] issue: [How to resolve 'Invalid window id' error when using Telescope plugin in Neovim?](https://sm-stackoverflow.azurefd.net/questions/76326378/how-to-resolve-invalid-window-id-error-when-using-telescope-plugin-in-neovim) (happen occasionally)
- [ ] `code_runner.nvim` extend functions
- [ ] `telescope file_browser` support many file operations
- [ ] add more keymap to `legendary.nvim`
- [ ] add `close-buffer.nvim` plugin
- [ ] use _dotfiles repo_ instead of just nvim config
- [ ] lspsaga ref about python `open` will not auto-close (annoying)
  - remove pandas in virtual text
- [ ] same variable lighter when hover one variable !
- [ ] LunarVim recommend plugins: https://www.lunarvim.org/docs/configuration/plugins/example-configurations
- [ ] telescope **insert mode** issue: https://github.com/nvim-telescope/telescope.nvim/issues/1595, ref LunarVim config for telescope (_normal mode_)
  - plugin `specs.nvim` cause this bug
- [ ] telescope do not show color for icon when remove `~/.config/nvim` and recover again
- [ ] add code for easy switch plugin on/off
- [ ] some profile tips: https://stackoverflow.com/questions/12213597/how-to-see-which-plugins-are-making-vim-slow
- [ ] `bufferline.nvim` config for more useful functions
- [ ] `bufferline.nvim` underline not taking up whole width of the tab
  - related issues: https://github.com/akinsho/bufferline.nvim/issues/761, https://github.com/akinsho/bufferline.nvim/issues/545
- [ ] _jk escape_ will make it slow in insert mode, e.g. `lazygit` window

# License

MIT

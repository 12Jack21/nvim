# Neovim config is all you need

> This configuration is based on [nvimdots](https://github.com/ayamir/nvimdots), and make modification for individual demand.
> Simplified version

## Installation

- Linux, MacOS, Windows WSL

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
- lazy.nvim use `pin=true` to prevent update for modified plugin
- `tmux -CC attach -t SESSION_NAME` new window in iTerm2 profile

# Lightweight Neovim Configuration

> A streamlined Neovim configuration based on [nvimdots](https://github.com/ayamir/nvimdots)
>
> **Version**: `light_v0.1` | **Plugins**: 37 (lightweight, minimal dependencies)

## Features

- 🎨 **Modern UI**: Catppuccin theme, bufferline, statusline, file tree
- 🚀 **Fast Startup**: Optimized plugin loading with lazy.nvim
- 💡 **Smart Completion**: LSP + nvim-cmp with multiple sources
- 📝 **Syntax Highlighting**: Treesitter with context-aware features
- 🔧 **Essential Tools**: File search (telescope), terminal, git integration
- ⌨️ **Vim-like Experience**: Surround, comment, hop, and more

## Installation

### Requirements

- Neovim >= 0.10.0
- Git
- Bash
- Python 3 (optional, for some LSP servers)

### Quick Install

```bash
if command -v curl >/dev/null 2>&1; then
    bash -c "$(curl -fsSL https://raw.githubusercontent.com/12Jack21/nvim/HEAD/scripts/install.sh)"
else
    bash -c "$(wget -O- https://raw.githubusercontent.com/12Jack21/nvim/HEAD/scripts/install.sh)"
fi
```

## Plugin List

### UI (9 plugins)
- **Theme**: catppuccin, onedarkpro
- **Status Line**: lualine.nvim
- **Tab Line**: bufferline.nvim
- **Icons**: nvim-web-devicons
- **Notifications**: nvim-notify
- **Git Signs**: gitsigns.nvim
- **LSP Progress**: fidget.nvim
- **Startup**: alpha-nvim
- **Indent**: indent-blankline.nvim

### Editor (16 plugins)
- **Syntax**: nvim-treesitter + 10 extensions
- **Editing**: Comment.nvim, nvim-surround, autoclose.nvim
- **Movement**: clever-f.vim, hop.nvim, accelerated-jk.nvim
- **Navigation**: vim-illuminate, clever-f.vim
- **Utility**: better-escape.nvim, suda.vim, nvim-bufdel
- **Folding**: pretty-fold.nvim
- **Highlighting**: nvim-colorizer.lua, todo-comments.nvim

### Tool (8 plugins)
- **File Manager**: nvim-tree.lua
- **Search**: telescope.nvim + fzf-native
- **Terminal**: toggleterm.nvim
- **Key Help**: which-key.nvim
- **Command Palette**: legendary.nvim
- **Command Line**: wilder.nvim
- **Diagnostics**: trouble.nvim
- **Clipboard**: smartyank.nvim

### Completion (3 plugins)
- **LSP Client**: nvim-lspconfig
- **Completion Engine**: nvim-cmp + 12 sources
- **Formatting**: none-ls.nvim

### Lang (1 plugin)
- **Notes**: obsidian.nvim

## Keybindings

### Leader Key
- `<leader>`: `<Space>`

### Basic Navigation
- `<C-p>`: Command palette (legendary.nvim)
- `<leader><space>`: Search files (telescope)
- `<leader>ff`: Find files
- `<leader>fg`: Live grep
- `<leader>fb`: Buffers
- `<leader>fh`: Search history

### File Operations
- `<C-g>`: Show file path
- `<leader>e`: Open file explorer (nvim-tree)
- `<leader>bd`: Close buffer
- `<leader>bn`: Next buffer
- `<leader>bp`: Previous buffer

### Editing
- `<leader>gc`: Toggle comment
- `ysiw{`: Surround word with braces
- `ds[`: Delete surrounding brackets
- `cs[(`: Change surrounding brackets
- `<A-l>`: Jump out of pairs
- `<A-o>`: Jump back into pairs

### Terminal
- `<A-d>`: Toggle floating terminal
- `<A-h>`: Toggle horizontal terminal
- `<A-v>`: Toggle vertical terminal

### Git
- `<leader>gg`: Open lazygit (if installed)
- `<leader>gb`: Git blame
- `<leader>gs`: Git status

### LSP
- `gd`: Go to definition
- `gD`: Go to declaration
- `gr`: Find references
- `gi`: Go to implementation
- `<leader>ca`: Code actions
- `<leader>rn`: Rename symbol
- `K`: Show hover documentation

## Configuration

### Theme
Default theme: `catppuccin-frappe`

Available themes:
- `catppuccin` (default)
- `catppuccin-frappe` (current)
- `catppuccin-macchiato`
- `catppuccin-mocha`
- `catppuccin-latte`
- `onedarkpro`

Change theme in `lua/core/settings.lua`:
```lua
settings["colorscheme"] = "catppuccin-frappe"
```

### LSP Servers
Configured LSP servers (install via Mason):
- bashls
- clangd
- lua_ls
- pyright
- gopls

### Formatters & Linters
Configured via none-ls.nvim:
- Python: black, flake8, ruff
- C/C++: clang_format
- JavaScript/TypeScript: prettier
- Lua: stylua
- Shell: shfmt

## Troubleshooting

### First-time Setup
- Treesitter parsers may fail to install initially
- Run `:TSUpdate` after first startup
- Run `:Mason` to ensure LSP servers are installed

### Common Issues
- **Theme not loading**: Check `lua/core/settings.lua` for colorscheme
- **LSP not working**: Run `:Mason` to install language servers
- **Completion not showing**: Ensure LSP server is installed and running

### Plugin Management
```vim
:Lazy       " Open lazy.nvim UI
:Lazy sync  " Update all plugins
:Lazy clean " Clean unused plugins
```

## Project Structure

```
nvim/
├── lua/
│   ├── core/           " Core configuration
│   ├── keymap/         " Keybindings
│   ├── modules/        " Plugin configurations
│   └── utils/          " Utility functions
├── scripts/            " Installation scripts
└── snips/              " Code snippets
```

## Contributing

This is a personal configuration tailored for specific needs. Feel free to fork and modify for your own use.

## License

This configuration is based on [nvimdots](https://github.com/ayamir/nvimdots), which is licensed under the MIT License.

---

**Note**: This is version `light_v0.1` - a streamlined configuration focusing on essential features and performance.

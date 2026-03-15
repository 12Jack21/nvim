# Neovim 配置项目说明

## 项目概述

这是一个基于 [nvimdots](https://github.com/ayamir/nvimdots) 的简化版 Neovim 配置，专为个人需求定制。该项目使用 Lua 编写，提供了一套完整的现代 Neovim 开发环境配置。

### 核心特性

- **插件管理**: 使用 lazy.nvim 进行高效的插件管理
- **语言支持**: 通过 LSP 提供多语言智能补全和诊断
- **代码补全**: 集成 nvim-cmp + LuaSnip 提供强大的代码补全功能
- **代码格式化**: 使用 none-ls (原 null-ls) 进行代码格式化和 linting
- **文件管理**: 集成 nvim-tree 文件浏览器
- **版本控制**: 内置 Git 集成（gitsigns, diffview）
- **调试支持**: 集成 DAP (Debug Adapter Protocol) 支持多语言调试
- **主题支持**: 支持 catppuccin、edge、onedark 等多种主题
- **跨平台**: 支持 Linux、macOS 和 Windows WSL

### 项目结构

```
.
├── init.lua                      # Neovim 主入口文件
├── lua/
│   ├── core/                     # 核心配置模块
│   │   ├── init.lua             # 核心初始化逻辑
│   │   ├── pack.lua             # 插件管理配置（lazy.nvim）
│   │   ├── options.lua          # 编辑器选项配置
│   │   ├── settings.lua         # 全局设置（主题、LSP 列表等）
│   │   ├── mapping.lua          # 基础按键映射
│   │   ├── event.lua            # 事件处理
│   │   └── global.lua           # 全局变量定义
│   ├── keymap/                   # 按键映射模块
│   │   ├── init.lua             # 按键映射入口
│   │   ├── bind.lua             # 按键绑定工具
│   │   ├── helpers.lua          # 辅助函数
│   │   ├── completion.lua       # 补全相关按键映射
│   │   ├── editor.lua           # 编辑器功能按键映射
│   │   ├── lang.lua             # 语言特定按键映射
│   │   ├── tool.lua             # 工具类按键映射
│   │   └── ui.lua               # UI 相关按键映射
│   └── modules/                  # 功能模块
│       ├── plugins/             # 插件声明文件
│       │   ├── completion.lua   # 补全相关插件
│       │   ├── editor.lua       # 编辑器增强插件
│       │   ├── lang.lua         # 语言特定插件
│       │   ├── tool.lua         # 工具类插件
│       │   └── ui.lua           # UI 相关插件
│       ├── configs/             # 插件具体配置
│       │   ├── completion/      # 补全配置（LSP、cmp、formatter 等）
│       │   ├── editor/          # 编辑器配置
│       │   ├── lang/            # 语言配置
│       │   ├── tool/            # 工具配置
│       │   └── ui/              # UI 配置
│       └── utils/               # 工具函数
│           ├── icons.lua        # 图标定义
│           └── init.lua         # 工具函数入口
├── scripts/
│   └── install.sh               # 自动安装脚本
├── snips/                       # 代码片段
│   ├── package.json
│   └── snippets/
│       ├── c.json
│       ├── cpp.json
│       └── go.json
└── overseer/                    # 任务运行器配置
    └── template/
        └── user/
            └── cpp_build.lua
```

## 安装和使用

### 系统要求

- Neovim >= 0.10.0
- Git
- Bash
- Perl

### 安装步骤

1. **自动安装**（推荐）：

```bash
# 使用 curl
bash -c "$(curl -fsSL https://raw.githubusercontent.com/12Jack21/nvim/HEAD/scripts/install.sh)"

# 使用 wget
bash -c "$(wget -O- https://raw.githubusercontent.com/12Jack21/nvim/HEAD/scripts/install.sh)"
```

2. **手动安装**：

```bash
# 克隆配置文件
git clone https://github.com/12Jack21/nvim.git ~/.config/nvim

# 启动 Neovim，插件会自动安装
nvim

# 如果插件安装失败，手动执行
:Lazy sync
```

### 基本使用

- **Leader 键**: 空格键（Space）
- **命令面板**: `<C-p>` 查看所有键盘快捷键
- **包管理**: `<leader>ph` 显示插件管理界面
- **插件同步**: `<leader>ps` 同步所有插件

### 核心快捷键

#### 插件管理
- `<leader>ph` - 显示插件列表
- `<leader>ps` - 同步插件
- `<leader>pu` - 更新插件
- `<leader>pi` - 安装插件
- `<leader>px` - 清理插件

#### 编辑器功能
- `<leader>gc` - 代码注释
- `<C-g>` - 显示当前文件路径
- `<A-o>` - 跳出配对符号（如 ""、''、{}）
- `<A-l>` - 跳出配对符号

#### 终端
- `<A-d>` - 切换浮动终端
- `<A-h>` - 切换水平终端
- `<A-v>` - 切换垂直终端

#### 文件操作
- `<M-j>` / `<A-k>` - 切换标签页
- `<M-q>` - 关闭当前标签页

#### 书签
- `m{letter}` - 添加书签
- `'{letter}` 或 `` `{letter} `` - 跳转到书签

#### 折叠
- `<z-a>` / `<z-A>` - 折叠/展开当前块
- `<S-tab>` - 折叠/展开当前块

#### nvim-surround（包围操作）
- `ds[` - 删除方括号及其内容
- `cs[(` - 将方括号改为圆括号
- `ysiw{` - 给当前单词添加花括号

#### 调试（DAP）
- `` `bt `` - 使用 lldb-vscode 适配器运行 lldb 命令
- `<leader>dl` - 重复运行上一次调试会话

#### 其他
- `<leader><backspace>` - 显示更多快捷键
- `<Cmd>set wrap/nowrap` - 切换自动换行
- `<C-]>` - 在 nvimtree 中进入目录并显示为根目录

## 配置文件说明

### 核心配置文件

- **lua/core/settings.lua** - 全局设置
  - `use_ssh`: 是否使用 SSH 更新插件（默认 true）
  - `format_on_save`: 是否保存时格式化（默认 false）
  - `diagnostics_virtual_text`: 是否显示诊断虚拟文本（默认 true）
  - `colorscheme`: 主题设置（默认 "onedark"）
  - `background`: 背景颜色（"dark" 或 "light"）
  - `lsp_deps`: 要安装的 LSP 服务器列表
  - `null_ls_deps`: 要安装的格式化和 linting 工具列表
  - `dap_deps`: 要安装的调试适配器列表

- **lua/core/options.lua** - 编辑器选项
  - 包含所有 Neovim 基本选项配置
  - 缩进、行号、剪贴板等设置

- **lua/core/pack.lua** - 插件管理
  - 配置 lazy.nvim
  - 自动加载 lua/modules/plugins/ 中的插件声明

### 按键映射文件

- **lua/keymap/init.lua** - 按键映射入口
- **lua/keymap/bind.lua** - 按键绑定工具函数
- **lua/keymap/*.lua** - 各类功能的按键映射

### 插件配置文件

插件配置采用模块化设计：

1. **lua/modules/plugins/*.lua** - 插件声明文件，定义要安装的插件及其依赖关系
2. **lua/modules/configs/**/*.lua** - 插件具体配置文件

例如：
- `lua/modules/plugins/completion.lua` 声明所有补全相关插件
- `lua/modules/configs/completion/lsp.lua` 配置 LSP
- `lua/modules/configs/completion/cmp.lua` 配置 nvim-cmp

## 支持的语言和工具

### LSP 服务器

- **bashls** - Bash 语言服务器
- **clangd** - C/C++ 语言服务器
- **lua_ls** - Lua 语言服务器
- **pyright** - Python 语言服务器
- **gopls** - Go 语言服务器

### 格式化和 Linting 工具

- **black** - Python 格式化工具
- **clang_format** - C/C++ 格式化工具
- **prettier** - 通用格式化工具
- **flake8** - Python Linter
- **ruff** - Python 快速 Linter
- **shfmt** - Shell 格式化工具
- **stylua** - Lua 格式化工具

### 调试适配器

- **debugpy** - Python 调试器
- **delve** - Go 调试器

### 其他工具

- **nvim-tree** - 文件浏览器
- **telescope** - 模糊查找器
- **gitsigns** - Git 状态显示
- **diffview** - Git 差异查看
- **toggleterm** - 终端管理
- **nvim-treesitter** - 语法高亮
- **todo-comments** - TODO 注释高亮
- **trouble** - 诊断列表
- **overseer** - 任务运行器

## 自定义配置

### 添加新插件

1. 在 `lua/modules/plugins/` 相应文件中添加插件声明：

```lua
completion["author/plugin-name"] = {
    lazy = true,
    event = "VeryLazy",
    config = function()
        -- 插件配置
    end,
    dependencies = {
        -- 依赖插件
    },
}
```

2. 如果配置较复杂，在 `lua/modules/configs/` 创建配置文件：

```lua
return function()
    -- 插件配置逻辑
end
```

然后修改插件声明中的 config：

```lua
config = require("modules.configs.category.plugin-name"),
```

### 添加新的按键映射

在 `lua/keymap/` 相应文件中添加：

```lua
local plug_map = {
    ["n|<leader>kk"] = map_cr("Command"):with_silent():with_desc("description"),
}

bind.nvim_load_mapping(plug_map)
```

### 修改主题

编辑 `lua/core/settings.lua`：

```lua
settings["colorscheme"] = "your-theme-name"
```

支持的主题包括：catppuccin、catppuccin-frappe、catppuccin-macchiato、edge、onedark 等。

### 添加新的 LSP 服务器

1. 在 `lua/core/settings.lua` 的 `lsp_deps` 列表中添加服务器名称：

```lua
settings["lsp_deps"] = {
    -- 现有服务器...
    "your-lsp-server",
}
```

2. 在 `lua/modules/configs/completion/servers/` 创建配置文件：

```lua
return function(opts)
    require("lspconfig").your_lsp_server.setup(opts)
end
```

## 开发约定

### 代码风格

- 使用 Lua 5.1+ 语法（Neovim 内置 Lua 版本）
- 遵循 nvimdots 项目结构
- 使用模块化设计，保持配置分离
- 配置声明在 `plugins/`，配置实现在 `configs/`

### 插件管理

- 使用 lazy.nvim 进行插件管理
- 尽量使用 lazy 加载以提高启动速度
- 使用 `pin = true` 防止修改过的插件被自动更新
- 插件配置文件使用函数返回配置对象

### 按键映射

- 使用 `lua/keymap/bind.lua` 提供的工具函数
- 按键映射格式：`"mode|keybinding"`
- 为每个按键映射添加描述（`:with_desc()`）
- 相关功能的按键映射放在同一文件中

### 文件命名

- 配置文件使用小写字母和下划线
- 插件配置文件名与插件名称保持一致（小写，连字符替换为下划线）
- Lua 文件使用 `.lua` 扩展名

## 故障排除

### 插件安装失败

如果插件安装失败，执行：

```vim
:Lazy sync
```

重复执行直到所有插件都安装成功。

### Treesitter 首次启动失败

nvim-treesitter 在首次设置时可能会失败，这是正常的。在编写代码时会自动成功。

### 按键映射不工作

某些按键可能被终端模拟器（如 iTerm2）映射到其他功能。检查终端设置，确保按键没有被覆盖。

### Mason 工具位置

Mason 安装的工具存储在 `~/.local/share/nvim/mason/bin/` 目录。

### tmux 环境问题

某些按键（如 `<A-*>`）在 tmux 环境中不可用，这是 tmux 的限制。

## 相关资源

- **项目主页**: https://github.com/12Jack21/nvim
- **基于项目**: https://github.com/ayamir/nvimdots
- **前置条件文档**: https://github.com/ayamir/nvimdots/wiki/Prerequisites
- **Neovim 文档**: https://neovim.io/doc/
- **lazy.nvim 文档**: https://github.com/folke/lazy.nvim

## 注意事项

1. 此配置是为 Neovim v0.10.0+ 设计的，旧版本可能不兼容
2. 首次启动需要网络连接以下载插件
3. Mason 工具需要在系统 PATH 中可用
4. 某些功能需要外部依赖（如 Python、Node.js 等）
5. 在 Windows WSL 环境中，剪贴板功能需要额外配置
6. 如果遇到问题，检查 `:checkhealth` 输出以获取诊断信息
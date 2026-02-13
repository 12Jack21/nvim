return function()
  local mason = require("mason")
  local mason_lspconfig = require("mason-lspconfig")

  -- Mason UI
  local icons = {
    ui = require("modules.utils.icons").get("ui", true),
    misc = require("modules.utils.icons").get("misc", true),
  }

  mason.setup({
    ui = {
      border = "rounded",
      icons = {
        package_pending = icons.ui.Modified_alt,
        package_installed = icons.ui.Check,
        package_uninstalled = icons.misc.Ghost,
      },
      keymaps = {
        toggle_server_expand = "<CR>",
        install_server = "i",
        update_server = "u",
        check_server_version = "c",
        update_all_servers = "U",
        check_outdated_servers = "C",
        uninstall_server = "X",
        cancel_installation = "<C-c>",
      },
    },
  })

  -- Diagnostics (native API; avoid deprecated vim.lsp.diagnostic.*)
  vim.diagnostic.config({
    virtual_text = {
      severity = { min = vim.diagnostic.severity.ERROR },
    },
    underline = true,
    update_in_insert = false,
  })

  -- Capabilities
  local capabilities = vim.lsp.protocol.make_client_capabilities()
  capabilities = require("cmp_nvim_lsp").default_capabilities(capabilities)

  -- Shared opts
  local opts = {
    capabilities = capabilities,
    on_attach = function()
      -- If you want lsp_signature, flip this to true.
      if false then
        require("lsp_signature").on_attach({
          bind = true,
          use_lspsaga = false,
          floating_window = true,
          floating_window_above_cur_line = false,
          fix_pos = false,
          floating_window_off_y = -2,
          hint_enable = false,
          hint_prefix = "🐼 ",
          hi_parameter = "Search",
          timer_interval = 50,
          toggle_key = "<M-x>",
          select_signature_key = "<M-n>",
          handler_opts = { border = "rounded" },
        })
      end
    end,
  }

  --- Apply config using Neovim 0.11 LSP API (preferred).
  --- This avoids the deprecated `require("lspconfig")[name].setup()`.
  ---@param name string
  ---@param config table
  local function apply_lsp(name, config)
    vim.lsp.config(name, config)
    vim.lsp.enable(name)
  end

  --- Handler for mason-lspconfig v2: setup servers and allow per-server overrides.
  --- Your per-server modules can return:
  ---   * function(opts) -> should call apply_lsp(name, cfg) itself (recommended)
  ---   * table -> merged into opts
  ---@param lsp_name string
  local function mason_handler(lsp_name)
    local ok, custom = pcall(require, "completion.servers." .. lsp_name)

    -- If you need special per-server side effects, keep them here
    if lsp_name == "lua_ls" then
      -- Example:
      -- require("neodev").setup({ library = { plugins = { "nvim-dap-ui" }, types = true } })
    end

    if not ok then
      -- No custom module: apply shared opts
      apply_lsp(lsp_name, opts)
      return
    end

    if type(custom) == "function" then
      -- Custom module controls its own setup.
      -- IMPORTANT: update your custom modules to use:
      --   vim.lsp.config(lsp_name, cfg); vim.lsp.enable(lsp_name)
      -- or call apply_lsp(lsp_name, cfg) if you require this file’s helper some other way.
      custom(opts)
      return
    end

    if type(custom) == "table" then
      apply_lsp(lsp_name, vim.tbl_deep_extend("force", opts, custom))
      return
    end

    vim.notify(
      string.format(
        "Failed to setup [%s].\n\nServer definition under `completion/servers` must return\neither a function(opts) or a table (got '%s' instead).",
        lsp_name,
        type(custom)
      ),
      vim.log.levels.ERROR,
      { title = "LSP" }
    )
  end

  -- mason-lspconfig v2 setup (no setup_handlers anymore)
  mason_lspconfig.setup({
    ensure_installed = require("core.settings").lsp_deps,
    handlers = {
      function(lsp_name)
        mason_handler(lsp_name)
      end,
    },
  })

  -- Servers not managed by mason but still available:
  if vim.fn.executable("dart") == 1 then
    local dart_opts = require("completion.servers.dartls")
    local final_opts = vim.tbl_deep_extend("force", opts, dart_opts)
    apply_lsp("dartls", final_opts)
  end
end

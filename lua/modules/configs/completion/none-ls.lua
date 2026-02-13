return function()
  local null_ls = require("null-ls")
  local mason_null_ls = require("mason-null-ls")
  local btns = null_ls.builtins

  -- Ruff comes from none-ls-extras (NOT from builtins)
  local ruff = require("none-ls.diagnostics.ruff")

  local sources = {
    -- formatting
    btns.formatting.black.with({
      extra_args = { "--fast" },
    }),

    btns.formatting.clang_format.with({
      filetypes = { "c", "cpp" },
      extra_args = require("completion.formatters.clang_format"),
    }),

    btns.formatting.prettier.with({
      filetypes = { "yaml", "html", "json", "sh", "markdown" },
    }),

    -- diagnostics (ruff)
    ruff.with({
      extra_args = { "--line-length", "120" },
    }),
  }

  -- mason setup (you already have mason elsewhere; this is okay but can be redundant)
  require("mason").setup()
  mason_null_ls.setup({
    ensure_installed = require("core.settings").null_ls_deps, -- include "ruff"
    automatic_installation = false,
    automatic_setup = false,
    handlers = {},
  })

  null_ls.setup({
    border = "rounded",
    debug = false,
    log_level = "warn",
    update_in_insert = false,
    sources = sources,
  })

  require("completion.formatting").configure_format_on_save()
end

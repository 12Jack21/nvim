return function()
	local null_ls = require("null-ls")
	local mason_null_ls = require("mason-null-ls")
	local btns = null_ls.builtins

	-- Please set additional flags for the supported servers here
	-- Don't specify any config here if you are using the default one.
	local sources = {
		-- MY: formatting part (do not work at first)
		btns.formatting.black.with({
			-- filetypes = { "python" },
			extra_args = { "--fast" },
		}),
		btns.formatting.clang_format.with({
			filetypes = { "c", "cpp" },
			extra_args = require("completion.formatters.clang_format"),
		}),
		btns.formatting.prettier.with({
			filetypes = {
				"vue",
				"typescript",
				"javascript",
				"typescriptreact",
				"javascriptreact",
				"yaml",
				"html",
				"css",
				"scss",
				"sh",
				"markdown",
			},
		}),

		btns.formatting.stylua,
		btns.formatting.shfmt,

		-- MY: diagnostics part
		btns.diagnostics.flake8.with({ extra_args = { "--max-line-length", "120" } }), -- MY: flake8 config

		-- MY: null-ls's buildin pylint (not working)
		-- btns.diagnostics.pylint.with({
		-- 	diagnostics_postprocess = function(diagnostic)
		-- 		diagnostic.code = diagnostic.message_id
		-- 	end,
		-- }),
	}

	-- MY: TODO: mason setup first
	require("mason").setup()
	mason_null_ls.setup({
		ensure_installed = require("core.settings").null_ls_deps,
		automatic_installation = false, -- MY: false by default
		automatic_setup = false,
		handlers = {},
	})

	null_ls.setup({
		border = "rounded",
		debug = true, -- MY: for checking why formater cannot work in null-ls (diagnostics can work)
		log_level = "warn",
		update_in_insert = false,
		sources = sources,
	})

	require("completion.formatting").configure_format_on_save()
end

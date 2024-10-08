return function()
	local nvim_lsp = require("lspconfig")
	local mason = require("mason")
	local mason_lspconfig = require("mason-lspconfig")

	-- MY: py_lsp support
	-- require("py_lsp").setup({})

	require("lspconfig.ui.windows").default_options.border = "single"

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
	mason_lspconfig.setup({
		ensure_installed = require("core.settings").lsp_deps,
	})

	local capabilities = vim.lsp.protocol.make_client_capabilities()
	capabilities = require("cmp_nvim_lsp").default_capabilities(capabilities)

	-- TODO: config not working in casual
	vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, {
		signs = true,
		-- signs = {
		-- 	severity_limit = "Hint",
		-- },
		-- virtual_text = require("core.settings").diagnostics_virtual_text,
		virtual_text = {
			severity = { min = vim.diagnostic.severity.ERROR },
		},
		-- virtual_text = false,
		underline = true,

		-- set update_in_insert to false bacause it was enabled by lspsaga
		update_in_insert = false,
	})

	-- MY: diagnostics got moved away from lsp scope so upper code doesn't work, config it using native neovim api
	vim.diagnostic.config({
		virtual_text = {
			severity = { min = vim.diagnostic.severity.ERROR },
		},
		-- signs = true,
		-- signs = {
		-- 	severity = { min = vim.diagnostic.severity.WARN },
		-- },
	})

	local opts = {
		on_attach = function()
            if false then
			require("lsp_signature").on_attach({
				bind = true,
				use_lspsaga = false,
				floating_window = true,
				floating_window_above_cur_line = false, -- below line is better
				fix_pos = false, -- true: will not close automatically when function ends
				-- floating_window_off_x = 5,
				floating_window_off_y = -2, -- move upper 2 lines
				hint_enable = false, -- TODO:false
                hint_prefix = "🐼 ",
				hi_parameter = "Search", -- use `Search` colorschene to highlight param
				-- transparency = 90,
                timer_interval = 50, -- 200 default
                oggle_key = "<M-x>", -- toggle signature on and off in insert mode,  e.g. toggle_key = '<M-x>'
                select_signature_key = "<M-n>", -- cycle to next signature, e.g. '<M-n>' function overloading
				handler_opts = {
					border = "rounded",
				},
			})
        end
		end,
		capabilities = capabilities,
	}

	---A handler to setup all servers defined under `completion/servers/*.lua`
	---@param lsp_name string
	local function mason_handler(lsp_name)
		local ok, custom_handler = pcall(require, "completion.servers." .. lsp_name)

		-- neovim doc support
		if lsp_name == "lua_ls" then
			-- require("neodev").setup({ library = { plugins = { "nvim-dap-ui" }, types = true } })
		end
		if not ok then
			-- Default to use factory config for server(s) that doesn't include a spec
			nvim_lsp[lsp_name].setup(opts)
			-- print("lsp-server:", lsp_name, " has set up via mason by default options") -- MY
			return
		elseif type(custom_handler) == "function" then
			--- Case where language server requires its own setup
			--- Make sure to call require("lspconfig")[lsp_name].setup() in the function
			--- See `clangd.lua` for example.
			custom_handler(opts)
		elseif type(custom_handler) == "table" then
			-- print("lsp-server:", lsp_name, " has set up via mason with custom options") -- MY
			nvim_lsp[lsp_name].setup(vim.tbl_deep_extend("force", opts, custom_handler))
		else
			vim.notify(
				string.format(
					"Failed to setup [%s].\n\nServer definition under `completion/servers` must return\neither a fun(opts) or a table (got '%s' instead)",
					lsp_name,
					type(custom_handler)
				),
				vim.log.levels.ERROR,
				{ title = "nvim-lspconfig" }
			)
		end
	end

	mason_lspconfig.setup_handlers({ mason_handler })

	-- Set lsps that are not supported by `mason.nvim` but supported by `nvim-lspconfig` here.
	if vim.fn.executable("dart") then
		local _opts = require("completion.servers.dartls")
		local final_opts = vim.tbl_deep_extend("keep", _opts, opts)
		nvim_lsp.dartls.setup(final_opts)
	end
end

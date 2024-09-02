return function()
	local icons = { ui = require("modules.utils.icons").get("ui") }
	local bufferline = require("bufferline")
	local opts = {
		options = {
			-- number = nil,
			numbers = function(opts)
				-- return string.format("%s.%s", opts.lower(opts.id), opts.lower(opts.ordinal))
				return string.format("%s", opts.lower(opts.id))
			end,

			mode = "buffers", -- set to "tabs" to only show tabpages instead
			modified_icon = icons.ui.Modified,
			buffer_close_icon = icons.ui.Close,
			left_trunc_marker = icons.ui.Left,
			right_trunc_marker = icons.ui.Right,
			max_name_length = 14,
			max_prefix_length = 13,
			tab_size = 18, -- 20
			color_icons = true,
			show_buffer_icons = true,
			show_buffer_close_icons = true,
			show_close_icon = true,
			show_tab_indicators = true,
			-- style_preset = bufferline.style_preset.default, -- or bufferline.style_preset.minimal,
			themable = false,
			enforce_regular_tabs = true,
			persist_buffer_sort = true,
			always_show_bufferline = true,
			indicator = {
				icon = "▎", -- this should be omitted if indicator style is not 'icon'
				icon = "🏀",
				icon = "🚀",
				-- style = "underline",
				style = "icon",
			},
			separator_style = "thick",
			diagnostics = "nvim_lsp",
			-- The diagnostics indicator can be set to nil to keep the buffer name highlight but delete the highlighting
			diagnostics_indicator = function(count)
				return "(" .. count .. ")"
			end,
			offsets = {
				{
					filetype = "NvimTree",
					-- text = "File Explorer",
					text = "Explorer",
					text_align = "center",
					padding = 1,
				},
			},
			-- should turn on 'mousemoveevent', but has unneeded overhead
			-- hover = {
			-- 	enabled = true,
			-- 	delay = 200,
			-- 	reveal = { "close" },
			-- },
			sort_by = "insert_after_current",
		},
		-- Change bufferline's highlights here! See `:h bufferline-highlights` for detailed explanation.
		-- Note: If you use catppuccin then modify the colors below!
		highlights = {
			indicator_selected = { -- tab selected, underline
				fg = "#f24f72", -- TODO: do not work
				sp = "#f24f72",
				-- bg = "bg",
				bold = true,
			},
			buffer_selected = { -- tab selected, underline
				fg = "#f24f72", -- TODO: do not work
				sp = "#f24f72",
				-- bg = "bg",
				bold = true,
			},
			tab_close = {
				fg = "#ccccee",
				bg = "#ec5f67",
			},
		},
	}

	if vim.g.colors_name:find("catppuccin") then
		local cp = require("modules.utils").get_palette() -- Get the palette.

		local catppuccin_hl_overwrite = {
			highlights = require("catppuccin.groups.integrations.bufferline").get({
				styles = { "italic", "bold" },
				custom = {
					mocha = {
						-- Hint
						hint = { fg = cp.rosewater },
						hint_visible = { fg = cp.rosewater },
						hint_selected = { fg = cp.rosewater },
						hint_diagnostic = { fg = cp.rosewater },
						hint_diagnostic_visible = { fg = cp.rosewater },
						hint_diagnostic_selected = { fg = cp.rosewater },
					},
				},
			}),
		}

		opts = vim.tbl_deep_extend("force", opts, catppuccin_hl_overwrite)
	end

	bufferline.setup(opts)
end

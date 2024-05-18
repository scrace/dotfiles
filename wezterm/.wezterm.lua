local wezterm = require("wezterm")
local keymaps = require("modules.keymaps")
local typography = require("modules.typography")

-- Show which key table is active in the status area
wezterm.on("update-right-status", function(window, pane)
	local name = window:active_key_table()
	if name then
		name = "Table: " .. name
	end
	window:set_right_status(name or "")
end)

return {
  -- Miscellaneous
	default_domain = "WSL:Ubuntu", -- load terminal in wsl
	default_cursor_style = "BlinkingBlock",

  -- Color
	color_scheme = "Poimandres",
	colors = {
		cursor_bg = "#A6ACCD",
		cursor_border = "#A6ACCD",
		cursor_fg = "#1B1E28",
	},

  -- Font
  font_size = typography.font_size,
  cell_width = typography.cell_width,
  line_height = typography.line_height,
  warn_about_missing_glyphs = typography.warn_about_missing_glyphs,
  font = typography.font,
  --font_rules = typography.font_rules,

  -- Window  
	window_background_opacity = 0.98,
	use_fancy_tab_bar = false,
	tab_bar_at_bottom = true,
	--hide_tab_bar_if_only_one_tab = true,
	window_padding = {
		left = 30,
		right = 30,
		top = 20,
		bottom = 20,
	},
	window_decorations = "RESIZE",
	inactive_pane_hsb = {
		brightness = 0.7,
	},
	send_composed_key_when_left_alt_is_pressed = false,
	send_composed_key_when_right_alt_is_pressed = true,

	-- Keymaps
	leader = keymaps.leader,
	keys = keymaps.keys,
	key_tables = keymaps.key_tables,
}

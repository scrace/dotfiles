local wezterm = require("wezterm")
local keymaps = require("modules.keymaps")

wezterm.on("update-right-status", function(window, pane)
	local name = window:active_key_table()
	if name then
		name = "Table: " .. name
	end
	window:set_right_status(name or "")
end)

return {
	-- load terminal in wsl
	default_domain = "WSL:Ubuntu",
	default_cursor_style = "BlinkingBlock",
	--color_scheme = "Andromeda"
	color_scheme = "Poimandres",
	colors = {
		cursor_bg = "#A6ACCD",
		cursor_border = "#A6ACCD",
		cursor_fg = "#1B1E28",
	},
	font = wezterm.font("Sk-Modernist-Regular", { weight = "Medium" }),
	font_size = 14,
	line_height = 1.6,
	window_background_opacity = 0.98,
	use_fancy_tab_bar = false,
	tab_bar_at_bottom = true,
	hide_tab_bar_if_only_one_tab = true,
	tab_max_width = 999999,
	window_padding = {
		left = 30,
		right = 30,
		top = 30,
		bottom = 30,
	},
	window_decorations = "RESIZE",
	inactive_pane_hsb = {
		brightness = 0.7,
	},
	send_composed_key_when_left_alt_is_pressed = false,
	send_composed_key_when_right_alt_is_pressed = true,
	-- key bindings
	leader = keymaps.leader,
	keys = keymaps.keys,
	key_tables = keymaps.key_tables,
}

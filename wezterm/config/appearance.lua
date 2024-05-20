local gpu_adapters = require("utils.gpu_adapter")
local colors = require("colors.custom")

return {
	-- Misc
	animation_fps = 144,
	max_fps = 144,
	front_end = "WebGpu",
	webgpu_power_preference = "HighPerformance",
	webgpu_preferred_adapter = gpu_adapters:pick_best(),

	-- Colorscheme
	colors = colors,
	color_scheme = "Poimandres",

	-- Tab bar
	enable_tab_bar = true,
	hide_tab_bar_if_only_one_tab = false,
	use_fancy_tab_bar = false,
	tab_bar_at_bottom = true,
	tab_max_width = 30,
	show_tab_index_in_tab_bar = false,

	-- Window
	window_padding = {
		left = 30,
		right = 30,
		top = 20,
		bottom = 20,
	},
	window_close_confirmation = "NeverPrompt",
	window_decorations = "RESIZE",
	window_background_opacity = 0.98,
	inactive_pane_hsb = {
		brightness = 0.7,
	},
}

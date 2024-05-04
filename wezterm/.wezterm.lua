local wezterm = require("wezterm")

local config = {}
if wezterm.config_builder then
	config = wezterm.config_builder()
end

-- load terminal in wsl
config.default_domain = "WSL:Ubuntu"

-- custom keybinds
local act = wezterm.action

config.leader = { key = "F13", timeout_milliseconds = 1000 }
config.keys = {
	{
		key = "c",
		mods = "LEADER",
		action = act.CopyTo("ClipboardAndPrimarySelection"),
	},
	{
		key = "v",
		mods = "LEADER",
		action = act.PasteFrom("Clipboard"),
	},
}

-- color scheme
config.color_scheme = "Andromeda"

return config

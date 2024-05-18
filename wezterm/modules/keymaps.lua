local wezterm = require("wezterm")
local act = wezterm.action

return {
	leader = { key = "Space", mods = "SHIFT", timeout_milliseconds = 2000 },

	keys = {
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
		{
			key = "w",
			mods = "LEADER",
			action = act.CloseCurrentPane({ confirm = true }),
		},

		-- Focus panes
		{
			key = "a",
			mods = "LEADER",
			action = act.ActivatePaneDirection("Left"),
		},
		{
			key = "l",
			mods = "LEADER",
			action = act.ActivatePaneDirection("Right"),
		},
		{
			key = "k",
			mods = "LEADER",
			action = act.ActivatePaneDirection("Up"),
		},
		{
			key = "s",
			mods = "LEADER",
			action = act.ActivatePaneDirection("Down"),
		},

		-- Add new panes
		{
			key = "v",
			mods = "LEADER",
			action = act.SplitVertical({ domain = "CurrentPaneDomain" }),
		},
		{
			key = "h",
			mods = "LEADER",
			action = act.SplitHorizontal({ domain = "CurrentPaneDomain" }),
		},

		-- Activate resize mode
		{
			key = "r",
			mods = "LEADER",
			action = act.ActivateKeyTable({
				name = "resize_pane",
				one_shot = false,
			}),
		},
	},

	key_tables = {
		resize_pane = {
			{ key = "a", action = act.AdjustPaneSize({ "Left", 5 }) },
			{ key = "l", action = act.AdjustPaneSize({ "Right", 5 }) },
			{ key = "k", action = act.AdjustPaneSize({ "Up", 2 }) },
			{ key = "s", action = act.AdjustPaneSize({ "Down", 2 }) },

			{ key = "Escape", action = "PopKeyTable" },
			{ key = "F12", action = "PopKeyTable" },
		},
	},
}

local wezterm = require("wezterm")
local config = wezterm.config_builder()

config.default_cursor_style = "SteadyBar"

config.font = wezterm.font("BlexMono Nerd Font")
config.font_size = 14.0

config.color_scheme = "Catppuccin Frappe"

config.window_close_confirmation = "NeverPrompt"
config.window_decorations = "RESIZE"
config.initial_cols = 175
config.initial_rows = 50

config.keys = {
	-- open split pane vertically
	{
		key = "-",
		mods = "SUPER|SHIFT",
		action = wezterm.action.SplitVertical({ domain = "CurrentPaneDomain" }),
	},
	{
		key = "|",
		mods = "SUPER|SHIFT",
		action = wezterm.action.SplitHorizontal({ domain = "CurrentPaneDomain" }),
	},
	{
		key = "w",
		mods = "CMD",
		action = wezterm.action.CloseCurrentPane({ confirm = false }),
	},
}

return config

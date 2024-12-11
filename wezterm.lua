local wezterm = require("wezterm")
local config = wezterm.config_builder()
config.default_cursor_style = "SteadyBar"

config.font = wezterm.font("BlexMono Nerd Font")
config.font_size = 12.0

config.color_scheme = "Catppuccin Mocha"

config.window_close_confirmation = "NeverPrompt"
config.window_decorations = "RESIZE"
config.initial_cols = 175
config.initial_rows = 50

config.keys = {
	{
		key = "t",
		mods = "SUPER",
		action = wezterm.action.SpawnCommandInNewTab({ cwd = wezterm.home_dir }),
	},
	{
		key = "t",
		mods = "SUPER|SHIFT",
		action = wezterm.action.SpawnTab("CurrentPaneDomain"),
	},
	-- open split pane vertically
	{
		key = "-",
		mods = "SUPER|SHIFT",
		action = wezterm.action.SplitVertical({ domain = "CurrentPaneDomain" }),
	},
	-- open split plane horizontally
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

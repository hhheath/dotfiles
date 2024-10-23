local wezterm = require("wezterm")
local config = wezterm.config_builder()

config.font = wezterm.font("BlexMono Nerd Font")
config.font_size = 14.0

config.color_scheme = "Catppuccin Frappe"

config.window_close_confirmation = "NeverPrompt"
config.window_decorations = "RESIZE"
config.initial_cols = 175
config.initial_rows = 50

return config

-- Pull in the wezterm API
local wezterm = require("wezterm")

-- This will hold the configuration.
local config = wezterm.config_builder()

-- This is where you actually apply your config choices

-- For example, changing the color scheme:
-- config.colors = {
-- 	foreground = "#CBE0F0",
-- 	background = "#011423",
-- 	cursor_bg = "#47FF9C",
-- 	cursor_border = "#47FF9C",
-- 	cursor_fg = "#011423",
-- 	selection_bg = "#706b4e",
-- 	selection_fg = "#f3d9c4",
-- 	ansi = { "#214969", "#E52E2E", "#44FFB1", "#FFE073", "#0FC5ED", "#a277ff", "#24EAF7", "#24EAF7" },
-- 	brights = { "#214969", "#E52E2E", "#44FFB1", "#FFE073", "#A277FF", "#a277ff", "#24EAF7", "#24EAF7" },
-- 	tab_bar = {
-- 		background = "#011423",
-- 	},
-- }

-- config scheme
-- config.color_scheme = "Blue Matrix"
-- config.color_scheme = "VisiBlue (terminal.sexy)"
config.color_scheme = "CutiePro"

config.font = wezterm.font("JetbrainsMono Nerd Font")
config.font_size = 19
config.line_height = 1.5

config.enable_tab_bar = false

config.window_decorations = "RESIZE"
config.window_background_opacity = 1
config.macos_window_background_blur = 8

config.window_padding = {
	left = 0,
	right = 0,
	top = 0,
	bottom = 0,
}

-- confitg tab bar
config.use_fancy_tab_bar = false

-- border
config.window_frame = {
	inactive_titlebar_bg = "#353535",
	active_titlebar_bg = "#2b2042",
	inactive_titlebar_fg = "#cccccc",
	active_titlebar_fg = "#ffffff",
	inactive_titlebar_border_bottom = "#2b2042",
	active_titlebar_border_bottom = "#2b2042",
	button_fg = "#cccccc",
	button_bg = "#2b2042",
	button_hover_fg = "#ffffff",
	button_hover_bg = "#3b3052",
	border_left_width = "0.4cell",
	border_right_width = "0.4cell",
	border_bottom_height = "0.12cell",
	border_top_height = "0.12cell",
	border_left_color = "#3DAEE8",
	border_right_color = "#3DAEE8",
	border_bottom_color = "#3DAEE8",
	border_top_color = "#3DAEE8",
}

-- initial_rows
config.initial_rows = 32
config.initial_cols = 130
-- and finally, return the configuration to wezterm
return config

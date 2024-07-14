-- Pull in the wezterm API
local wezterm = require("wezterm")

-- This will hold the configuration.
local config = wezterm.config_builder()

-- This is where you actually apply your config choices

-- For example, changing the color scheme:
-- serenade IC_Green_PPL
config.colors = {
	foreground = "#e0f1dc",
	background = "#31363b",
	cursor_bg = "#47fa6b",
	cursor_border = "#47fa6b",
	cursor_fg = "#292929",
	selection_bg = "#116b41",
	selection_fg = "#e0f1dc",
	-- ansi = { "#214969", "#E52E2E", "#44FFB1", "#FFE073", "#0FC5ED", "#a277ff", "#24EAF7", "#24EAF7" },
	-- brights = { "#214969", "#E52E2E", "#44FFB1", "#FFE073", "#A277FF", "#a277ff", "#24EAF7", "#24EAF7" },
	ansi = { "#014401", "#ff2736", "#41a638", "#76a831", "#2ec3b9", "#50a096", "#3ca078", "#e6fef2" },
	brights = { "#035c03", "#b4fa5c", "#aefb86", "#dafa87", "#2efaeb", "#50fafa", "#3cfac8", "#e0f1dc" },

	tab_bar = {
		background = "#011423",
	},
}

-- config scheme
-- config.color_scheme = "Blue Matrix"
-- config.color_scheme = "VisiBlue (terminal.sexy)"
-- config.color_scheme = "CutiePro"
-- config.color_scheme = "IC_Green_PPL"

config.font = wezterm.font("JetbrainsMono Nerd Font")
config.font_size = 16
config.line_height = 1.5

config.enable_tab_bar = false

config.window_decorations = "RESIZE"

-- set background transparent
config.window_background_opacity = 0.95

-- set background blur
config.macos_window_background_blur = 90

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
	-- border_left_width = "0.4cell",
	-- border_right_width = "0.4cell",
	-- border_bottom_height = "0.12cell",
	-- border_top_height = "0.12cell",
	border_left_color = "#ACB765",
	border_right_color = "#ACB765",
	border_bottom_color = "#ACB765",
	border_top_color = "#ACB765",
}

-- initial_rows
config.initial_rows = 42
config.initial_cols = 160
-- and finally, return the configuration to wezterm
return config

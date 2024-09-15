local wezterm = require("wezterm")
local config = wezterm.config_builder()

-- appearance
config.color_scheme = 'Aci (Gogh)'
config.font = wezterm.font("AnonymicePro Nerd Font Mono", {
    weight = 'Regular'
})
config.font_size = 16.0

-- window
config.initial_rows = 40
config.initial_cols = 130

-- disable all super keybinds because this clashes with system keybinds

-- wezterm.log_error(wezterm.gui.default_keys())
-- wezterm.log_error(wezterm.gui.default_key_tables())

return config

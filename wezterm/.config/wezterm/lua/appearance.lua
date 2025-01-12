local wez = require "wezterm"

local M = {}

M.apply_to_config = function(c)
    c.color_scheme = "ayu"
    local scheme = wez.color.get_builtin_schemes()[c.color_scheme]
    c.window_background_opacity = 0.86
    c.inactive_pane_hsb = { brightness = 0.8 }
    c.window_padding = { left = 0, right = 0, top = 0, bottom = 0 }
    c.enable_tab_bar = false
    c.use_fancy_tab_bar = false
    c.colors = {}
    c.window_background_opacity = 0.8
end

return M

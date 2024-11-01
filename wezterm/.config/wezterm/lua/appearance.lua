local wez = require "wezterm"

local M = {}

M.apply_to_config = function(c)
    c.color_scheme = "ayu"
    local scheme = wez.color.get_builtin_schemes()[c.color_scheme]
    c.window_background_opacity = 0.86
    c.inactive_pane_hsb = { brightness = 0.8 }
    c.window_padding = { left = 0, right = 0, top = 0, bottom = 0 }
    c.window_decorations = "NONE"
    c.show_new_tab_button_in_tab_bar = true
    c.use_fancy_tab_bar = false
    c.colors = {
        tab_bar = {
            background = scheme.background,  -- Set the desired background color for the tab bar
            active_tab = {
                bg_color = scheme.brights[6],  -- Background color for inactive tabs
                fg_color = scheme.background,  -- Foreground color for inactive tab text
            },
            inactive_tab = {
                bg_color = scheme.background,
                fg_color = scheme.foreground,
            },
        },
    }
end
return M

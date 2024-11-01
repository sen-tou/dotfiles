local wez = require "wezterm"

local M = {}

M.apply_to_config = function(c)
  c.color_scheme = "Tokyo Night"
  local scheme = wez.color.get_builtin_schemes()["Tokyo Night"]
  c.colors = {
    split = scheme.ansi[2],
  }
  c.window_background_opacity = 0.86
  c.inactive_pane_hsb = { brightness = 0.9 }
  c.window_padding = { left = 0, right = 0, top = 0, bottom = 0 }
  c.window_decorations = "RESIZE"
  c.show_new_tab_button_in_tab_bar = true
end

return M

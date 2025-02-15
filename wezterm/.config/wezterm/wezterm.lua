local wez = require "wezterm"
local utils = require "lua.utils"

local appearance = require "lua.appearance"
local mappings = require "lua.mappings"

local c = {}

if wez.config_builder then
    c = wez.config_builder()
end

-- General configurations
c.font = wez.font("LiterationMono Nerd Font", {})
c.font_rules = {{
    italic = true,
    intensity = "Half",
    font = wez.font("LiterationMono Nerd Font", {
        italic = true
    })
}}
c.font_size = 16
c.adjust_window_size_when_changing_font_size = false
c.audible_bell = "Disabled"
c.scrollback_lines = 3000
c.default_workspace = "main"
c.status_update_interval = 2000
c.window_close_confirmation = "NeverPrompt"
-- this needs to be because otherwise the confirm screen
-- is not showing up
c.skip_close_confirmation_for_processes_named = {}

-- wezterm is crashing under wayland
c.enable_wayland = false

-- appearance
appearance.apply_to_config(c)

-- keys
mappings.apply_to_config(c)

return c

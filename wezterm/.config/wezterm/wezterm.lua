local hostname = (function()
	local handle, error_message = io.popen("hostnamectl hostname", "r")
	if handle then
	  local hostname = handle:read("*a")
	  handle:close()
	  return hostname:gsub("%s+", "")
	else
	  wezterm.log_error("Error reading hostname:" ..  error_message)
	end
end)()

local wezterm = require("wezterm")
local config = wezterm.config_builder()

config.color_scheme = "AdventureTime"
config.font = wezterm.font("AnonymicePro Nerd Font Mono")
config.font_size = 12.0
if hostname == 'Bobbie' then
	config.font_size = 14.0
end

return config

local wez = require "wezterm"
local act = wez.action
local callback = wez.action_callback
local mod = {
    c = "CTRL",
    s = "SHIFT",
    a = "ALT",
    l = "LEADER"
}
local M = {}
local leader = {
    mods = mod.c,
    key = "a",
    timeout_miliseconds = 1000
}

local keybind = function(mods, key, action)
    return {
        mods = table.concat(mods, "|"),
        key = key,
        action = action
    }
end

local keys = function()
    local keys = { -- pane and tabs
        keybind({mod.a}, "t", act.SpawnTab "CurrentPaneDomain"), 
        keybind({mod.a}, "q", act.CloseCurrentTab {
            confirm = true
        }), 
        keybind({mod.l}, "e", act.PromptInputLine {
            description = wez.format {{
                Attribute = {
                    Intensity = "Bold"
                }
            }, {
                Foreground = {
                    AnsiColor = "Fuchsia"
                }
            }, {
                Text = "Renaming Tab Title...:"
            }},
            action = callback(function(win, _, line)
                if line == "" then
                    return
                end
                win:active_tab():set_title(line)
            end)
        }), -- copy and paste
        keybind({mod.c, mod.s}, "c", act.CopyTo "Clipboard"), 
        keybind({mod.c, mod.s}, "v", act.PasteFrom "Clipboard")
    }

    -- tab navigation
    for i = 1, 9 do
        table.insert(keys, keybind({mod.a}, tostring(i), act.ActivateTab(i - 1)))
    end
    return keys
end

M.apply_to_config = function(c)
    c.treat_left_ctrlalt_as_altgr = true
    c.leader = leader
    c.keys = keys()
end

return M

local wezterm = require('wezterm')
local Config = require('config')

-- Show which key table is active in the status area
wezterm.on("update-right-status", function(window, pane)
    local name = window:active_key_table()
    if name then
        name = "Table: " .. name
    end
    window:set_right_status(name or "")
end)

require('events.tab-title').setup()
require('events.new-tab-button').setup()

return Config:init()
    :append(require('config.appearance'))
    :append(require('config.domains'))
    :append(require('config.general'))
    :append(require('config.keymaps'))
    :append(require('config.typography'))
    :append(require('config.launch')).options
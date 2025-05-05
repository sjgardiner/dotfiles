-- Show a toast notification with the terminal dimensions when resizing
--require("resize_notifications")

-- Show the current dimensions in the title bar when resizing, temporarily
-- un-hiding the title bar if it is currently hidden
require("resize_title")

local wezterm = require 'wezterm'
local config = wezterm.config_builder()

-- Tab configuration
config.use_fancy_tab_bar = false
config.hide_tab_bar_if_only_one_tab = true
config.tab_bar_at_bottom = true

-- Allow resizing but hide the title bar
config.window_decorations = "RESIZE"

-- Use ALT + number to activate the corresponding tab
local mykeys = {}
for i = 1, 8 do
table.insert(mykeys, {
key=tostring(i),
mods="ALT",
action=wezterm.action{ActivateTab=i-1},
})
end

config.keys = mykeys

-- Set the color scheme
--config.color_scheme = "Catppuccin Mocha" -- or Macchiato, Frappe, Latte

return config

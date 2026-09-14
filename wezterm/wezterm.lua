-- Show a toast notification with the terminal dimensions when resizing
--require("resize_notifications")

-- Show the current dimensions in the title bar when resizing, temporarily
-- un-hiding the title bar if it is currently hidden
require("resize_title")

local wezterm = require 'wezterm'
local config = wezterm.config_builder()

-- Set default window size
config.initial_cols = 82
config.initial_rows = 27

-- Tab configuration
config.use_fancy_tab_bar = false
config.hide_tab_bar_if_only_one_tab = true
config.tab_bar_at_bottom = true

-- Allow resizing but hide the title bar
config.window_decorations = "RESIZE"

-- Define some custom key mappings to handle copy/paste in a reasonable
-- way. This configuration is based on
-- https://github.com/wezterm/wezterm/discussions/2426#discussioncomment-4197449
mykeys = {
  {
    key = 'c',
    mods = 'CTRL',
    action = wezterm.action_callback(function(window, pane)
      local sel = window:get_selection_text_for_pane(pane)
      if (not sel or sel == '') then
        window:perform_action(wezterm.action.SendKey{ key='c', mods='CTRL' }, pane)
      else
        window:perform_action(wezterm.action{ CopyTo = 'ClipboardAndPrimarySelection' }, pane)
      end
    end),
  },
  { key = 'v', mods = 'CTRL', action = wezterm.action.PasteFrom 'Clipboard' },
  { key = 'v', mods = 'SHIFT|CTRL', action = wezterm.action_callback(function(window, pane)
    window:perform_action(wezterm.action.SendKey{ key='v', mods='CTRL' }, pane) end),
  },
  { key = 'V', mods = 'SHIFT|CTRL', action = wezterm.action_callback(function(window, pane)
    window:perform_action(wezterm.action.SendKey{ key='v', mods='CTRL' }, pane) end),
  },
  { key = 'c', mods = 'ALT', action = wezterm.action{ CopyTo = 'ClipboardAndPrimarySelection' } },
  { key = 'v', mods = 'ALT', action = wezterm.action.PasteFrom 'Clipboard' },
}

-- Use ALT + number to activate the corresponding tab
for i = 1, 8 do
  table.insert(mykeys, {
    key=tostring(i),
    mods="ALT",
    action=wezterm.action{ActivateTab=i-1},
  })
end

-- Use SUPER + SHIFT + ! to move the current tab to a new window
table.insert(mykeys, {
  key = '!',
  mods = 'SUPER|SHIFT',
  action = wezterm.action_callback(function(win, pane)
    local tab, window = pane:move_to_new_window()
  end),
})

config.keys = mykeys

-- Set the color scheme
--config.color_scheme = "Catppuccin Mocha" -- or Macchiato, Frappe, Latte

return config

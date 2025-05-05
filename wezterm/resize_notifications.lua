local wezterm = require 'wezterm'
local time    = wezterm.time

local is_resizing = false
local clear_timer
local last_dims = { cols = 0, rows = 0 }

wezterm.on("window-resized", function(window, pane)
  is_resizing = true
  local d = pane:get_dimensions()
  last_dims.cols = d.cols
  last_dims.rows = d.viewport_rows

  -- Show a toast notification with the current dimensions
  local size_string = string.format("%dx%d", last_dims.cols, last_dims.rows)
  window:toast_notification("Terminal Size", size_string, nil, 500)

  if clear_timer then
    clear_timer:cancel()
  end
  clear_timer = time.call_after(0.5, function()
    is_resizing = false
    clear_timer = nil
  end)
end)

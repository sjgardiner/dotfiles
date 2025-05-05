local wezterm = require 'wezterm'
local time    = wezterm.time

-- State
local is_resizing = false
local clear_timer
local last_dims = { cols = 0, rows = 0 }

-- 1) On every resize, capture the new dims and flip on "resizing" mode
wezterm.on("window-resized", function(_, pane)
  is_resizing = true
  local d = pane:get_dimensions()  -- pane:get_dimensions() works here :contentReference[oaicite:0]{index=0}
  last_dims.cols = d.cols
  last_dims.rows = d.viewport_rows

  if clear_timer then
    clear_timer:cancel()
  end
  clear_timer = time.call_after(0.5, function()
    is_resizing = false
    clear_timer = nil
  end)
end)

-- 2) When the window title is being formatted, return either the cached dims or the normal title
wezterm.on("format-window-title", function(tab, _pane, _tabs, _panes, _config)
  if is_resizing then
    return string.format("%dx%d", last_dims.cols, last_dims.rows)
  else
    return tab.active_pane.title  -- fall back to your shell’s or default title :contentReference[oaicite:1]{index=1}
  end
end)

return {}

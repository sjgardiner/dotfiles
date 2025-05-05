local wezterm = require 'wezterm'
local time    = wezterm.time

-- State
local is_resizing       = false
local override_applied  = false
local just_cleared      = false
local clear_timer       = nil
local last_dims         = { cols = nil, viewport_rows = nil }

-- How long (in seconds) of idle before we revert
local clear_delay = 3.5

wezterm.on("window-resized", function(window, pane)
  -- ① Noise‐filter: check the real buffer size
  local d = pane:get_dimensions()
  if last_dims.cols
     and d.cols == last_dims.cols
     and d.viewport_rows == last_dims.viewport_rows
  then
    return  -- nothing really changed—ignore this event
  end

  -- ② If we just reverted, swallow any remaining noise
  if just_cleared then
    return
  end

  -- ③ Real resize: cache the new dims and enter “resizing” state
  last_dims = { cols = d.cols, viewport_rows = d.viewport_rows }
  is_resizing = true

  -- ④ Show the title bar once per drag
  if not override_applied then
    override_applied = true
    local o = window:get_config_overrides() or {}
    o.window_decorations = "TITLE|RESIZE"
    window:set_config_overrides(o)
  end

  -- ⑤ Reset our “end of drag” timer
  if clear_timer then clear_timer:cancel() end
  clear_timer = time.call_after(clear_delay, function()
    -- a) hide the title bar again
    local o = window:get_config_overrides() or {}
    o.window_decorations = nil
    window:set_config_overrides(o)

    -- b) reset flags
    is_resizing      = false
    override_applied = false
    just_cleared     = true
    clear_timer      = nil

    -- c) un‐mute any lingering noise after a brief pause
    time.call_after(0.1, function()
      just_cleared = false
    end)
  end)
end)

wezterm.on("format-window-title", function(tab, _pane, _tabs, _panes, _cfg)
  if is_resizing then
    return string.format("%dx%d", last_dims.cols, last_dims.viewport_rows)
  else
    return tab.active_pane.title
  end
end)

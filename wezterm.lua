-- Pull in the wezterm API
local wezterm = require 'wezterm'
local act = wezterm.action

-- This will hold the configuration.
local config = wezterm.config_builder()

-- Design
config.color_scheme = 'AdventureTime'
config.font = wezterm.font '0xProto Nerd Font'

-- Keyboard
config.leader = { key = 'a', mods = 'CTRL', timeout_milliseconds = 1000 }
config.keys = {

  {
    key = '=',
    mods = 'LEADER',
    action = act.SplitHorizontal { domain = 'CurrentPaneDomain' },
  },
  {
    key = '-',
    mods = 'LEADER',
    action = act.SplitVertical { domain = 'CurrentPaneDomain' },
  },
  {
    key = 'LeftArrow',
    mods = 'LEADER',
    action = act.ActivatePaneDirection 'Left',
  },
  {
    key = 'RightArrow',
    mods = 'LEADER',
    action = act.ActivatePaneDirection 'Right',
  },
  {
    key = 'UpArrow',
    mods = 'LEADER',
    action = act.ActivatePaneDirection 'Up',
  },
  {
    key = 'DownArrow',
    mods = 'LEADER',
    action = act.ActivatePaneDirection 'Down',
  },
  {
    key = ',',
    mods = 'LEADER',
    action = act.ActivateTabRelative(-1),
  },
  {
    key = '.',
    mods = 'LEADER',
    action = act.ActivateTabRelative(-1),
  },
  {
    key = 'x',
    mods = 'LEADER',
    action = act.CloseCurrentPane { confirm = false },
  },
  {
    key = 'End',
    mods = 'LEADER',
    action = act.ScrollToBottom,
  },
  {
    key = 'Home',
    mods = 'LEADER',
    action = act.ScrollToTop,
  },
  {
    key = 'PageUp',
    mods = 'LEADER',
    action = act.ScrollByPage(-1),
  },
  {
    key = 'PageDown',
    mods = 'LEADER',
    action = act.ScrollByPage(1),
  },
  {
    key = 'Enter',
    mods = 'LEADER',
    action = act.ShowLauncher,
  },
  -- Send "CTRL-A" to the terminal when pressing CTRL-A, CTRL-A
  {
    key = 'a',
    mods = 'LEADER',
    action = wezterm.action.SendKey { key = 'a', mods = 'CTRL' },
  },
}

-- and finally, return the configuration to wezterm
return config

hs.window.animationDuration = 0

local application = require "hs.application"
require "hs.screen"
require "window_management"

-- -- Apptivate Replacement ---------------------------
-- hs.hotkey.bind({"cmd"}, "1", function()
--   application.launchOrFocus("iTerm")
-- end)
-- 
-- hs.hotkey.bind({"cmd"}, "2", function()
--   application.launchOrFocus("Firefox")
-- end)
-- 
-- hs.hotkey.bind({"cmd"}, "3", function()
--   application.launchOrFocus("Slack")
-- end)
-- 
-- hs.hotkey.bind({"cmd"}, "6", function()
--   application.launchOrFocus("Scapple")
-- end)
-- 
-- hs.hotkey.bind({"cmd"}, "7", function()
--   application.launchOrFocus("Messages")
-- end)
-- ----------------------------------------------------


-- Moom Replacement --------------------------------
-- extra-slim 1/3
-- hs.hotkey.bind({"cmd", "shift"}, "S", function()
--   local win = hs.window.focusedWindow()
--   local f = win:frame()
--   local screen = win:screen()
--   local max = screen:frame()
-- 
--   f.x = max.w / 3           -- 1/3
--   f.y = 0
--   f.w = max.w / 3           -- 1/3
--   f.h = max.h
--   win:setFrame(f)
-- end)

---- right
--hs.hotkey.bind({"cmd", "shift"}, "L", function()
--  local win = hs.window.focusedWindow()
--  local f = win:frame()
--  local screen = win:screen()
--  local max = screen:frame()
--
--  f.x = 1750
--  f.y = max.y
--  f.w = max.w - 1750
--  f.h = max.h
--  win:setFrame(f)
--end)

-- -- top
-- hs.hotkey.bind({"cmd", "shift"}, "K", function()
--   local win = hs.window.focusedWindow()
--   local f = win:frame()
--   local screen = win:screen()
--   local max = screen:frame()
-- 
--   f.x = max.x
--   f.y = max.y
--   f.w = max.w
--   f.h = max.h / 2
--   win:setFrame(f)
-- end)
-- 
-- -- bottom
-- hs.hotkey.bind({"cmd", "shift"}, "J", function()
--   local win = hs.window.focusedWindow()
--   local f = win:frame()
--   local screen = win:screen()
--   local max = screen:frame()
-- 
--   f.x = max.x
--   f.y = max.h / 2
--   f.w = max.w
--   f.h = max.h / 2
--   win:setFrame(f)
-- end)
-- 

-- cmus
hs.task = require("hs.task")
hs.hotkey.bind({}, "F14", function()
  hs.task.new("/Users/jonhiggs/.local/src/dotfiles-macos/bash/bin/cmus-remote-remote", nil, {"--pause"}):start()
end)

hs.hotkey.bind({}, "F15", function()
  hs.task.new("/Users/jonhiggs/.local/src/dotfiles-macos/bash/bin/cmus-remote-remote", nil, {"--next"}):start()
end)

hs.hotkey.bind({}, "F13", function()
  hs.task.new("/Users/jonhiggs/.local/src/dotfiles-macos/bash/bin/cmus-remote-remote", nil, {"--prev"}):start()
end)

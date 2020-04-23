hs.window.animationDuration = 0

local logger = hs.logger.new("init", "info")
local application = require "hs.application"
require "hs.screen"

-- Moom Replacement --------------------------------
function center_window(relative_to)
  local win = hs.window.focusedWindow()
  local f = win:frame()
  local screen = win:screen()
  local max = screen:frame()

  local relative = math.floor(max.w * 0.5)
  if string.match(relative_to, "left") then
    relative = math.floor(max.w * 0.25)
  elseif string.match(relative_to, "right") then
    relative = math.floor(max.w * 0.75)
  end
  logger.i("centering window relative to", relative_to);
  logger.i("in position", relative)

  f.x = relative - (f.w / 2);

  win:setFrame(f);
end

function govern_width(window,limit)
  -- limit is a float < 1. 1==100%
  local screen_w = window:screen():frame().w
  local window_w = window:frame().w
  local max_w = math.floor(screen_w * limit)
  logger.i("width is", window:frame().w)
  if (window_w > max_w) then
    logger.i("window is too wide. Making it narrower")
    window:frame().w = max_w
  end
  logger.i("width is", window:frame().w)
  win:setFrame(f)
  return window
end

function position(window,screen)
  local in_left = false
  local in_right = false
  if (window.x < (screen.w / 2)) then         -- left side
    in_left = true
  elseif ( (window.x + window.w) > (screen.w / 2) ) then
    in_right = true
  end

  if (in_left and in_right) then
    return "middle"
  elseif in_left then
    return "left"
  elseif in_right then
    return "right"
  end
end

function resize_window(window,size)
  local window = hs.window.focusedWindow()
  local f = win:frame()
  local screen = win:screen()
  local max = screen:frame()

  -- logger.i(position(f,screen))

  if string.match(size, "fullscreen") then
    window.x = max.x
    window.y = max.y
    window.w = max.w
    window.h = max.h
  elseif string.match(size, "narrow") then
    margin = 300
    window.x = margin
    window.y = 0
    window.w = max.w - (margin * 2 )
    window.h = max.h
  elseif string.match(size, "half") then
    window.x = math.floor(max.w * 0.25)
    window.y = 0
    window.w = math.floor(max.w * 0.75)
    window.h = max.h
  elseif string.match(size, "slim") then
    window.x = max.w / 3
    window.y = 0
    window.w = max.w / 3
    window.h = max.h
  end
end

hs.hotkey.bind({"cmd", "shift"}, "F", function()
  local win = hs.window.focusedWindow()
  win = resize_window(win,"fullscreen")
  win:setFrame(win:frame())
end)

hs.hotkey.bind({"cmd", "shift"}, "D", function()
  resize_window("narrow")
end)

hs.hotkey.bind({"cmd", "shift"}, "S", function()
  resize_window("slim")
end)

hs.hotkey.bind({"cmd", "shift"}, "H", function()
  local win = hs.window.focusedWindow()
  win = govern_width(win,0.5)
  center_window("left")
  win:setFrame(win:frame())
end)

hs.hotkey.bind({"cmd", "shift"}, "L", function()
  center_window("right")
end)

hs.hotkey.bind({"cmd", "shift"}, "M", function()
  center_window("middle")
end)

-- adjust width
hs.hotkey.bind({"cmd", "shift"}, "left", function()
  local win = hs.window.focusedWindow()
  local f = win:frame()
  local screen = win:screen()
  local max = screen:frame()

  f.x = f.x + 10
  f.w = f.w - 20

  -- logger.i(f.x)
  -- if f.x < max.w then
  --   f.x = max.w - f.w
  -- end

  win:setFrame(f)
end)

hs.hotkey.bind({"cmd", "shift"}, "right", function()
  logger.i("hello")
  local win = hs.window.focusedWindow()
  local f = win:frame()
  f.x = f.x - 10
  f.w = f.w + 20

  logger.i(f.x)
  if f.x < 0 then
    f.x = 0
  end
  win:setFrame(f)
end)

-- cmus
hs.task = require("hs.task")
hs.hotkey.bind({}, "F14", function()
  hs.task.new("/usr/local/bin/cmus-remote", nil, {"--pause"}):start()
end)

hs.hotkey.bind({}, "F15", function()
  hs.task.new("/usr/local/bin/cmus-remote", nil, {"--next"}):start()
end)

hs.hotkey.bind({}, "F13", function()
  hs.task.new("/usr/local/bin/cmus-remote", nil, {"--prev"}):start()
end)

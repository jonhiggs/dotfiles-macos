local logger = hs.logger.new("init", "info")
logger.i("window management is loaded")

require "hs.screen"

logger.i("window management is loaded")

function resize_window(win,w,h)
	local f = win:frame()
	f.w = w * win:screen():frame().w
	f.h = h * win:screen():frame().h
	return f
end

function position_window(win,x,y)
	local f = win:frame()
	f.x = x
	f.y = y
	return f
end

function coord_for(win,position)
	if string.match(position, "left") then
		x = 0
	elseif string.match(position, "right") then
		x = win:screen():frame().w - win:frame().w
	elseif string.match(position, "center") then
		x = (win:screen():frame().w / 2) - (win:frame().w / 2)
	else
		x = win:frame().x
	end

	return x,win:frame().y
end

function is_oversize(win,w,h)
	if (win:frame().w > win:screen():frame().w * w) then
		return true
	end

	if (win:frame().y > win:screen():frame().h * h) then
		return true
	end

	return false
end

-- fullscreen
hs.hotkey.bind({"cmd", "shift"}, "F", function()
  local window = hs.window.focusedWindow()
	window:setFrame(position_window(window,0,0))
	window:setFrame(resize_window(window,1,1))
end)

-- narrow
hs.hotkey.bind({"cmd", "shift"}, "D", function()
  local window = hs.window.focusedWindow()
	window:setFrame(resize_window(window,0.6,1))
	local x,y = coord_for(window,"center")
	window:setFrame(position_window(window,x,y))
end)

-- slim
hs.hotkey.bind({"cmd", "shift"}, "S", function()
  local window = hs.window.focusedWindow()
	window:setFrame(resize_window(window,0.3,1))
	local x,y = coord_for(window,"center")
	window:setFrame(position_window(window,x,y))
end)

-- center
hs.hotkey.bind({"cmd", "shift"}, "M", function()
  local window = hs.window.focusedWindow()
	local x,y = coord_for(window,"center")
	window:setFrame(position_window(window,x,y))
end)

-- left
hs.hotkey.bind({"cmd", "shift"}, "H", function()
  local window = hs.window.focusedWindow()
	if is_oversize(window,0.5,1) then
		window:setFrame(resize_window(window,0.5,1))
	end

	local x,y = coord_for(window,"left")
	window:setFrame(position_window(window,x,y))
end)

-- right
hs.hotkey.bind({"cmd", "shift"}, "L", function()
  local window = hs.window.focusedWindow()

	if is_oversize(window,0.5,1) then
		window:setFrame(resize_window(window,0.5,1))
	end

	local x,y = coord_for(window,"right")
	logger.i("left x:", x)
	logger.i("left y:", y)
	window:setFrame(position_window(window,x,y))
end)


-- function center_window(relative_to)
--   local win = hs.window.focusedWindow()
--   local f = win:frame()
--   local screen = win:screen()
--   local max = screen:frame()
-- 
--   local relative = math.floor(max.w * 0.5)
--   if string.match(relative_to, "left") then
--     relative = math.floor(max.w * 0.25)
--   elseif string.match(relative_to, "right") then
--     relative = math.floor(max.w * 0.75)
--   end
--   logger.i("centering window relative to", relative_to);
--   logger.i("in position", relative)
-- 
--   f.x = relative - (f.w / 2);
-- 
--   win:setFrame(f);
-- end
-- 
-- function govern_width(window,limit)
--   -- limit is a float < 1. 1==100%
--   local screen_w = window:screen():frame().w
--   local window_w = window:frame().w
--   local max_w = math.floor(screen_w * limit)
--   logger.i("width is", window:frame().w)
--   if (window_w > max_w) then
--     logger.i("window is too wide. Making it narrower")
--     window:frame().w = max_w
--   end
--   logger.i("width is", window:frame().w)
--   win:setFrame(f)
--   return window
-- end
-- 
-- function position(window,screen)
--   local in_left = false
--   local in_right = false
--   if (window.x < (screen.w / 2)) then         -- left side
--     in_left = true
--   elseif ( (window.x + window.w) > (screen.w / 2) ) then
--     in_right = true
--   end
-- 
--   if (in_left and in_right) then
--     return "middle"
--   elseif in_left then
--     return "left"
--   elseif in_right then
--     return "right"
--   end
-- end
-- 
-- hs.hotkey.bind({"cmd", "shift"}, "F", function()
--   local win = hs.window.focusedWindow()
--   win = resize_window(win,"fullscreen")
--   win:setFrame(win:frame())
-- end)
-- 
-- hs.hotkey.bind({"cmd", "shift"}, "D", function()
--   resize_window("narrow")
-- end)
-- 
-- hs.hotkey.bind({"cmd", "shift"}, "S", function()
--   resize_window("slim")
-- end)
-- 
-- hs.hotkey.bind({"cmd", "shift"}, "H", function()
--   local win = hs.window.focusedWindow()
--   win = govern_width(win,0.5)
--   center_window("left")
--   win:setFrame(win:frame())
-- end)
-- 
-- hs.hotkey.bind({"cmd", "shift"}, "L", function()
--   center_window("right")
-- end)
-- 
-- hs.hotkey.bind({"cmd", "shift"}, "M", function()
--   center_window("middle")
-- end)
-- 
-- -- adjust width
-- hs.hotkey.bind({"cmd", "shift"}, "left", function()
--   local win = hs.window.focusedWindow()
--   local f = win:frame()
--   local screen = win:screen()
--   local max = screen:frame()
-- 
--   f.x = f.x + 10
--   f.w = f.w - 20
-- 
--   -- logger.i(f.x)
--   -- if f.x < max.w then
--   --   f.x = max.w - f.w
--   -- end
-- 
--   win:setFrame(f)
-- end)
-- 
-- hs.hotkey.bind({"cmd", "shift"}, "right", function()
--   logger.i("hello")
--   local win = hs.window.focusedWindow()
--   local f = win:frame()
--   f.x = f.x - 10
--   f.w = f.w + 20
-- 
--   logger.i(f.x)
--   if f.x < 0 then
--     f.x = 0
--   end
--   win:setFrame(f)
-- end)

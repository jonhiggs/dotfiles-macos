local logger = hs.logger.new("init", "info")
logger.i("window management is loaded")

require "hs.screen"

logger.i("window management is loaded")

function resize_window(win,w,h)
	-- resize to a proportion of the screen
	local f = win:frame()
	f.w = w * win:screen():frame().w
	f.h = h * win:screen():frame().h
	return f
end

function relative_resize_window(win,w,h)
	-- resize by number of pixels
	local f = win:frame()
	f.w = w + win:frame().w
	f.h = h + win:frame().h
	return f
end

function position_window(win,x,y)
	local f = win:frame()
	f.x = x
	f.y = y
	return f
end

function coord_for(win,position)
	local y = (win:screen():frame().h - win:frame().h) / 2
	if string.match(position, "left") then
		x,_ = padding(win,0.5,1)
	elseif string.match(position, "right") then
		x,_ = padding(win,0.5,1)
		x = x + (win:screen():frame().w / 2)
	elseif string.match(position, "center") then
		x = (win:screen():frame().w / 2) - (win:frame().w / 2)
	else
		x = win:frame().x
	end

	return x,y
end

function padding(win,w,h)
	local max_width = win:screen():frame().w * w
	local max_height = win:screen():frame().h * h

	padding_x = (max_width - win:frame().w) / 2
	padding_y = (max_height - win:frame().h) / 2

	return padding_x,padding_y
end

function is_oversize(win,w,h)
	-- w and h are percentage of screen (0.5 == 50%)
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
  hs.window.focusedWindow():maximize(0)
end)

-- center
hs.hotkey.bind({"cmd", "shift"}, "C", function()
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

-- slim
hs.hotkey.bind({"cmd", "shift"}, "S", function()
  local window = hs.window.focusedWindow()
	window:setFrame(resize_window(window,0.65,1))
	local x,y = coord_for(window,"center")
	logger.i("left x:", x)
	logger.i("left y:", y)
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

-- adjust narrower
hs.hotkey.bind({"cmd", "shift"}, "left", function()
	local window = hs.window.focusedWindow()
	window:setFrame(relative_resize_window(window,-20,0))
end)

-- adjust wider
hs.hotkey.bind({"cmd", "shift"}, "right", function()
	local window = hs.window.focusedWindow()
	window:setFrame(relative_resize_window(window,20,0))
end)


hs.hotkey.bind({"cmd", "shift"}, "X", function()
	local window = hs.window.focusedWindow()
	local screen = hs.screen:mainScreen()
	logger.i(hs.screen:currentMode()[1])
	local geo = hs.geometry(-5,100,3000,3000)
	window:move(geo, screen, false, 0)
end)

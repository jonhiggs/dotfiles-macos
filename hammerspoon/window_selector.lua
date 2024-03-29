local logger = hs.logger.new("init", "info")
logger.i("window selector is loaded")
hs.application.enableSpotlightForNameSearches(true)

function hide_focused()
	local app = hs.window.focusedWindow():application()
	logger.i("hiding: " .. app:title())
	app:hide()
end

function focus_window(name)
	local focusedWindow = hs.window.focusedWindow()
	if (focusedWindow == nil) then
		logger.i("no window is currently focused")
	else
		if not (focusedWindow:application():title() == name) then
			hide_focused()
		end
	end

	logger.i("focusing on: " .. name)
	local filter = hs.window.filter.new()
	hs.timer.usleep(500) -- using filter too fast was preventing window from always being found.
	filter:setDefaultFilter(false)
	filter:setAppFilter(name,{currentSpace=true, focused=false})
	local windows = filter:getWindows()

	logger.i("found this many windows: " .. #windows)

	if (#(windows) == 0) then
		return nil
	end

	for i=1, #(windows), 1 do 
		print(i .. " is " .. windows[i]:title()) 
	end

	if windows then
		return windows[1]:focus()
	else
		logger.i("cannot find any iterm windows")
		return nil
	end
end


-- switch to iterm
hs.hotkey.bind({"cmd"}, "1", function()
	focus_window("iTerm2")
end)

-- switch to firefox
hs.hotkey.bind({"cmd"}, "2", function()
	focus_window("Firefox")
end)

-- switch to slack
hs.hotkey.bind({"cmd"}, "3", function()
	focus_window("Slack")
end)

-- switch to scapple
hs.hotkey.bind({"cmd"}, "4", function()
	focus_window("Scapple")
end)

--hs.hotkey.bind({"cmd"}, "L", function()
--	window = hs.window.focusedWindow()
--	window:focusWindowEast()
--end)
--
--hs.hotkey.bind({"cmd"}, "H", function()
--	window = hs.window.focusedWindow()
--	window:focusWindowWest()
--end)

-- overscan
hs.hotkey.bind({"cmd", "shift"}, "X", function()
     local window = hs.window.focusedWindow()
     local screen = hs.screen.mainScreen()
     local mode = screen:currentMode()
     local geo = hs.geometry(-3,0,mode["w"]+6,mode["h"])
     window:move(geo, screen, false, 0)
     window:centerOnScreen(screen, false, 0)
end)

-- underscan
hs.hotkey.bind({"cmd", "shift"}, "Z", function()
     local window = hs.window.focusedWindow()
     local screen = hs.screen.mainScreen()
     local mode = screen:currentMode()
     local geo = hs.geometry(-3,3,mode["w"]-6,mode["h"]-6)
     window:move(geo, screen, false, 0)
     window:centerOnScreen(screen, false, 0)
end)

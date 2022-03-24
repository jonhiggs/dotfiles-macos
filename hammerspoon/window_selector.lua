local logger = hs.logger.new("init", "info")
logger.i("window selector is loaded")
hs.application.enableSpotlightForNameSearches(true)

function focus_window(name)
	-- focus a window by name
	logger.i("focusing on: " .. name)
	local application = hs.application.find(name)
	application:activate()
	application:mainWindow():focus()

	--hs.timer.usleep(1000000)

	--local filter = hs.window.filter.default
	--filter:setDefaultFilter(false)
	--filter:setAppFilter(name,true)
	--local windows = filter:getWindows(hs.window.filter.sortByFocusedLast)
	--logger.i("found this many windows: " .. #windows)

	--for i=1, #(windows), 1 do 
	--	print(i .. " is " .. windows[i]:title()) 
	--end

	--if windows then
	--	--return windows[#windows]:focus()
	--else
	--	logger.i("cannot find any iterm windows")
	--	return nil
	--end
end

-- fullscreen the focused app
hs.hotkey.bind({"cmd", "shift"}, "F", function()
	local window = hs.window.focusedWindow()
	window:setFullScreen(not window:isFullScreen())
end)

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

hs.hotkey.bind({"cmd"}, "L", function()
	window = hs.window.focusedWindow()
	window:focusWindowEast()
end)

hs.hotkey.bind({"cmd"}, "H", function()
	window = hs.window.focusedWindow()
	window:focusWindowWest()
end)

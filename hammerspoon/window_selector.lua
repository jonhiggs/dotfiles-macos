local logger = hs.logger.new("init", "info")
logger.i("window selector is loaded")

function focus_window(name)
	-- focus a window by name
	local application = hs.application.find(name)
	local window = application:mainWindow()
	logger.i("found app: "..application:name())
	return window:focus()
end


-- fullscreen the focused app
hs.hotkey.bind({"cmd", "shift"}, "F", function()
	local window = hs.window.focusedWindow()
	window:setFullScreen(true)
end)

-- switch to iterm
hs.hotkey.bind({"cmd"}, "1", function()
	focus_window("iterm2")
end)

-- switch to firefox
hs.hotkey.bind({"cmd"}, "2", function()
	focus_window("firefox")
end)

-- switch to slack
hs.hotkey.bind({"cmd"}, "3", function()
	focus_window("slack")
end)

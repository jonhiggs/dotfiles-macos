local logger = hs.logger.new("init", "info")
logger.i("app watcher is loaded")

return hs.application.watcher.new(
	function(name, eventType, application)
		logger.i("name: "..name)
		if (name == "iTerm2" or name == "Firefox" or name == "Slack" or name == "Scapple") and eventType == hs.application.watcher.launched then
			hs.timer.usleep(400000)

			local window = application:focusedWindow() or application:mainWindow()

			hs.timer.usleep(200000)

			if window then
				window:maximise(0)
			else
				logger.i("cant find a window to operate on")
			end
		end
	end)

-- vim: ft=lua sw=2 ts=2

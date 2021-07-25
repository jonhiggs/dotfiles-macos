local logger = hs.logger.new("init", "info")
logger.i("desktop mode is loaded")

function is_h0002(data)
	return (data["vendorID"] == 65261) and (data["productID"] == 0)
end

function is_lan(data)
	return (data["vendorID"] == 3034) and (data["productID"] == 33107)
end

usbWatcher = hs.usb.watcher.new(function(data)
	if is_h0002(data) and data["eventType"] == "added" then
		logger.i("found a keyboard")
	end

	if is_lan(data) and data["eventType"] == "added" then
		logger.i("enabling bluetooth")
		hs.task.new("/usr/local/bin/blueutil", nil, {"-p1"}):start()

		logger.i("disabling wifi")
		hs.task.new("/usr/sbin/networksetup", nil, {"-setairportpower", "en0", "off"})
	elseif is_lan(data) and data["eventType"] == "removed" then
		logger.i("disabling bluetooth")
		hs.task.new("/usr/local/bin/blueutil", nil, {"-p0"}):start()

		logger.i("enabling wifi")
		hs.task.new("/usr/sbin/networksetup", nil, {"-setairportpower", "en0", "on"})
	end
end)
usbWatcher:start()

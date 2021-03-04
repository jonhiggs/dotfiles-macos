local logger = hs.logger.new("init", "info")

-- togggle desktop mode
hs.hotkey.bind({"cmd", "shift"}, "return", function()
	logger.i("toggle desktop mode")
	interfaces = hs.network.interfaces()
	logger.i(table.concat(interfaces,","))
	logger.i(table.concat(hs.network.interfaceDetails("en0"),","))
end)

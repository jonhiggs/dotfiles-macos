--require "hs.window.filter"

local logger = hs.logger.new("init", "info")
logger.i("window selector is loaded")
hs.application.enableSpotlightForNameSearches(true)

local window = {}

-- Keeps track of which is the currently active space
activeSpace = 1

-- Keeps track of which is the currently active window within each space
windowCounter = {}

function window.lastCreatedWindows()
   filter = hs.window.filter.default
   filter:setDefaultFilter(false)
   filter:setAppFilter("iTerm2",{allowRoles='*'})
   filter:setAppFilter("Firefox",{allowRoles='*'})
   filter:setAppFilter("Scapple",{allowRoles='*'})
   filter:setAppFilter("Slack",{allowRoles='*'})
   return filter:getWindows(hs.window.filter.sortByCreatedLast)
end

local function switchWindow()
    name = "Firefox"
    -- wf = hs.window.filter.default
    windows = window.lastCreatedWindows() 

    logger.i("number of " .. name .. " windows: " .. #(windows))

    for i=#(windows), 1, -1 do 
            print(i .. " is " .. windows[i]:title()) 
    end

    --if #windows <= 1 then
    --    return
    --end

    --spaceCounter = windowCounter[activeSpace] or 1
    --nextWindow = windows[spaceCounter]
    --if nextWindow then
    --    nextWindow:focus()
    --end

    --if spaceCounter + 1 <= #windowsInSpace then
    --    windowCounter[activeSpace] = spaceCounter + 1
    --else
    --    windowCounter[activeSpace] = 1
    --end
end


function cycle_windows(name)
	wf_app = hs.window.filter.new{name,override={}}
	--wf_app = hs.window.filter.new(false):setAppFilter(name)
	wf_app.sortByFocusedLast = true
	window = wf_app:getWindows()[1]

	if window then
		logger.i("firefox windows: "..window:title())
		logger.i("number of " .. name .. " windows: " .. #(wf_app:getWindows()))
		window:focus()
	else
		logger.i("couldn't find window for " .. name)
	end
end

hs.hotkey.bind({"cmd", "shift"}, "N", function()
	--local name = hs.window.focusedWindow()
	switchWindow()
	--"Firefox")
end)

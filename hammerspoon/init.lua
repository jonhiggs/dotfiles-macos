hs.window.animationDuration = 0

local application = require "hs.application"
require "hs.screen"
require "window_management"

-- cmus
hs.task = require("hs.task")
hs.hotkey.bind({}, "F13", function()
  hs.task.new("/Users/jonhiggs/.local/src/dotfiles-macos/bash/bin/cmus-remote-remote", nil, {"--pause"}):start()
end)

hs.hotkey.bind({}, "F14", function()
  hs.task.new("/Users/jonhiggs/.local/src/dotfiles-macos/bash/bin/cmus-remote-remote", nil, {"--prev"}):start()
end)

hs.hotkey.bind({}, "F15", function()
  hs.task.new("/Users/jonhiggs/.local/src/dotfiles-macos/bash/bin/cmus-remote-remote", nil, {"--next"}):start()
end)

-- sleep
hs.hotkey.bind({}, "F16", function()
  hs.task.new("/usr/bin/pmset", nil, {"displaysleepnow"}):start()
end)

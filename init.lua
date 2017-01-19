-- A global variable for the Hyper Mode
hyper = hs.hotkey.modal.new({}, "F17")

-- Trigger existing hyper key shortcuts

hyper:bind({}, 'm', nil, function() hs.eventtap.keyStroke({"cmd","alt","shift","ctrl"}, 'm') end)

-- OR build your own

launch = function(appname)
  hs.application.launchOrFocus(appname)
  hyper.triggered = true
end

-- Single keybinding for app launch
singleapps = {
  {'l', 'Slack'},
  {'e', 'Emacs'},
  {'t', 'iTerm'},
  {'c', 'Google Chrome'}
}

for i, app in ipairs(singleapps) do
  hyper:bind({}, app[1], function() hs.alert(app[2]); launch(app[2]); hyper:exit(); end)
end

-- Sequential keybindings, e.g. Hyper-a,f for Finder
a = hs.hotkey.modal.new({}, "F16")
apps = {
  {'f', 'Finder'}
}
for i, app in ipairs(apps) do
  a:bind({}, app[1], function() launch(app[2]); a:exit(); end)
end

pressedA = function() hs.alert('F: Finder'); a:enter() end
releasedA = function() end
hyper:bind({}, 'a', nil, pressedA, releasedA)

-- Show grid resizer

g = function()
  hs.grid.setGrid('4x4')
  hs.grid.show()
  hyper.triggered = true
end
hyper:bind({}, 'g', g)

-- Enter Hyper Mode when F18 (Hyper/Capslock) is pressed
pressedF18 = function()
  hyper.triggered = false
  hyper:enter()
end

-- Leave Hyper Mode when F18 (Hyper/Capslock) is pressed,
--   send ESCAPE if no other keys are pressed.
releasedF18 = function()
  hyper:exit()
  if not hyper.triggered then
    hs.eventtap.keyStroke({}, 'ESCAPE')
  end
end

-- Bind the Hyper key
f18 = hs.hotkey.bind({}, 'F18', pressedF18, releasedF18)

require('position')
require('watcher')

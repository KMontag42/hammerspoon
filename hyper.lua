hyper_mods = {"cmd", "alt", "ctrl", "shift"}
meh_mods = {"cmd", "alt", "ctrl"}

launch = function(appname)
  hs.application.launchOrFocus(appname)
end

-- Single keybinding for app launch
singleapps = {
  {'l', 'Slack'},
  {'e', 'Emacs'},
  {'t', 'iTerm'},
  {'c', 'Google Chrome'},
  {'o', 'Finder'}
}

for i, app in ipairs(singleapps) do
  hs.hotkey.bind(hyper_mods, app[1], function() launch(app[2]); end)
end

-- Show grid resizer

g = function()
  hs.grid.setGrid('4x4')
  hs.grid.show()
  hyper.triggered = true
end
hs.hotkey.bind(hyper_mods, 'g', g)


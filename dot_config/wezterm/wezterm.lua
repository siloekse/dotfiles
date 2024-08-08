local wezterm = require 'wezterm'

local config = wezterm.config_builder()

config.font = wezterm.font('JetBrains Mono', { weight = 'Bold' })
config.background = {
  {
    source = {
      File = '/Users/sigl/Pictures/wallpapers/colorful-abstract-ai-art-4k-wallpaper-uhdpaper.com-16@0@i.jpg'
    },
  },
  {
    source = {
      Color = 'black'
    },
    width = '100%',
    height = '100%',
    opacity = 0.8,
  },
}

config.enable_tab_bar = true
config.hide_tab_bar_if_only_one_tab = true
config.window_decorations = 'RESIZE'
config.color_scheme = 'Catppuccin Mocha'
config.default_prog = { '/opt/homebrew/bin/fish' }

return config

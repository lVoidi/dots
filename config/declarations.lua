local awful = require("awful") 
local path = string.format("%s/.config/awesome", os.getenv("HOME"))

return {
  path = path,
  mod = "Mod4",
  terminal = "kitty",
  editor = "nvim",
  telegram_client = "kotatogram-desktop",
  discord_client = "discord",
  screenshot = "flameshot gui",
  office = "wps",
  run = "rofi -show drun",
  audio_control = "pavucontrol",
  browser = "chromium",
  on_init = function() 
    awful.spawn.with_shell(path.."/scripts/init.sh")
  end
}


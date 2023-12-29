local path = string.format("%s/.config/awesome", os.getenv("HOME"))

return {
  path = path,
  mod = "Mod4",
  terminal = "kitty",
  file_manager = "pcmanfm",
  editor = "nvim",
  telegram_client = "telegram-desktop",
  discord_client = "discord",
  screenshot = "flameshot gui",
  office = "wps",
  run = "rofi -show drun",
  audio_control = "pavucontrol",
  browser = "microsoft-edge-dev",
}


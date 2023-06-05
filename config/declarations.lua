local path = string.format("%s/.config/awesome", os.getenv("HOME"))

return {
  path = path,
  mod = "Mod4",
  terminal = "alacritty",
  file_manager = "pcmanfm",
  editor = "nvim",
  telegram_client = "kotatogram-desktop",
  discord_client = "discord",
  screenshot = "flameshot gui",
  office = "wps",
  run = "rofi -show drun",
  audio_control = "pavucontrol-qt",
  browser = "firefox",
}


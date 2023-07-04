pcall(require, "luarocks.loader")
local awful = require("awful")

-- Modules
require("awful.autofocus")
require("beautiful").init("~/.config/awesome/theme.lua")
require("config")
require("ui")

local path = string.format("%s/.config/awesome", os.getenv("HOME"))
awful.spawn.with_shell(path.."/scripts/init.sh")

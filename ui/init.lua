local awful = require("awful")
local beautiful = require("beautiful")
local wibox = require("wibox")

require("ui.bar")
require("ui.titlebar")
require("ui.notifications")

-- Set wallpaper
screen.connect_signal("request::wallpaper", function(s)
    awful.wallpaper {
        screen = s,
        widget = {
                image     = beautiful.wallpaper,
                horizontal_fit_policy = "fit",
                vertical_fit_policy   = "fit",
                widget    = wibox.widget.imagebox,
        }
    }
end)


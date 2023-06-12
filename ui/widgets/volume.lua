local gears = require("gears")
local volume_widget = require('modules.awesome-wm-widgets.volume-widget.volume')
local wibox = require("wibox")
local beautiful = require("beautiful")
local colors = beautiful.colors

local volume_widget_container = {
        { 
          {
            {
                image  = "/home/lvoidi/.config/awesome/images/icons/misc/volume.png",
                forced_width = 100,
                halign = "center",
                valign = "center",
                forced_height = 100,
                widget = wibox.widget.imagebox
            },
            volume_widget{
                main_color=colors.green,
                widget_type = 'arc',
                thickness=7,
                size = 100,
                bg_color=colors.gray.."df"
            },
            layout = wibox.layout.stack
          },
          left = 7,
          right = 7,
          widget = wibox.container.margin
        },
        shape = gears.shape.rounded_bar,
        widget = wibox.container.background
    }
return volume_widget_container

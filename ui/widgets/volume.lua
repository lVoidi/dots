local gears = require("gears")
local volume_widget = require('modules.awesome-wm-widgets.volume-widget.volume')
local add_app = require("utils.helpers").app
local awful = require("awful")
local wibox = require("wibox")
local beautiful = require("beautiful")
local colors = beautiful.colors
local dpi   = require("beautiful.xresources").apply_dpi

local volume_widget_container = {
        {
          {
              spacing = 5,
              layout=wibox.layout.fixed.horizontal,
              {
                  {
                      text="",
                      font="JetBrainsMono Nerd Font 15",
                      widget=wibox.widget.textbox
                  },
                  fg = colors.fg,
                  widget = wibox.container.background,
              },
              {
                volume_widget{
                    main_color=colors.purple,
                    widget_type = 'horizontal_bar',
                    shape = 'rounded_bar',
                    width = 50,
                    height = 10,
                    bg_color=colors.gray.."df"
                },
                top = 3, bottom = 3,
                widget = wibox.container.margin
              },
          },
          left = 7,
          right = 7,
          widget = wibox.container.margin
        },
        shape = gears.shape.rounded_bar,
        widget = wibox.container.background
    }
return volume_widget_container

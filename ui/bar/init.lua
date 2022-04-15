local awful = require("awful")
local wibox = require("wibox")
local dpi = require("beautiful.xresources").apply_dpi
local widgets = require("ui.widgets")
local helpers = require("utils.helpers")
local colors = require("beautiful").colors
local gears = require("gears")

mykeyboardlayout = awful.widget.keyboardlayout()

-- Create a textclock widget
mytextclock = {
  format = '<span foreground="'..colors.green..
           '" font="JetBrainsMono Nerd Font 10">%H:%M</span>',
  widget = wibox.widget.textclock
}

screen.connect_signal("request::desktop_decoration", function(s)
    awful.tag({ "1", "2", "3", "4", "5" }, s, awful.layout.layouts[1])

    s.mypromptbox = awful.widget.prompt()

    s.mylayoutbox = awful.widget.layoutbox {
        screen  = s,
        forced_width = 20,
        buttons = {
            awful.button({ }, 1, function () awful.layout.inc( 1) end),
            awful.button({ }, 3, function () awful.layout.inc(-1) end),
            awful.button({ }, 4, function () awful.layout.inc(-1) end),
            awful.button({ }, 5, function () awful.layout.inc( 1) end),
        }
    }

    s.mylayoutbox = {
      s.mylayoutbox,
      valign = "center",
      widget = wibox.container.place
    }

    s.mytaglist = widgets.tags(s)
    s.mytasklist = widgets.tasks(s)
    s.systray = wibox.container.background(wibox.container.margin(wibox.widget.systray(),
      7, 7, 5, 6), colors.gray, function(cr, width, height)
          gears.shape.partially_rounded_rect(
            cr, width, height, true, false, false, true, 30
          )
        end)

    if s.index > 1 then 
      s.systray = nil 
    end

    local left = {
      {
        {
          helpers.margin(5),
          widgets.menu(s),
          s.mytaglist,
          layout = wibox.layout.fixed.horizontal,
        },
        bg = colors.gray,
        shape = function(cr, width, height)
          gears.shape.partially_rounded_rect(
            cr, width, height, false, true, true, false, 30
          )
        end,
        widget = wibox.container.background
      },
      s.mypromptbox,
      layout = wibox.layout.fixed.horizontal
    }

    local middle = s.mytasklist
    local right = {
      mytextclock,
      helpers.margin(5),
      widgets.volume,
      helpers.margin(5),
      s.mylayoutbox,
      helpers.margin(5),
      s.systray,
      layout = wibox.layout.fixed.horizontal
    }

    -- Create the wibox
    s.mywibox = awful.wibar {
        position = "top",
        screen   = s,
        height = dpi(35),
        widget   = wibox.container.margin({
            layout = wibox.layout.align.horizontal,
            left,
            middle,
            right,
        }, 0, 0, 1, 1)
    }
end)

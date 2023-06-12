local awful = require("awful")
local wibox = require("wibox")
local dpi = require("beautiful.xresources").apply_dpi
local widgets = require("ui.widgets")
local batteryarc_widget = require("modules.awesome-wm-widgets.batteryarc-widget.batteryarc")
local helpers = require("utils.helpers")
local colors = require("beautiful").colors
local gears = require("gears")

local styles = {}
local function rounded_shape(size, partial)
    if partial then
        return function(cr, width, height)
                   gears.shape.partially_rounded_rect(cr, width, height,
                        false, true, false, true, 5)
               end
    else
        return function(cr, width, height)
                   gears.shape.rounded_rect(cr, width, height, size)
               end
    end
end
styles.month   = { padding      = 5,
                   bg_color     = colors.gray,
                   border_width = 2,
                   shape        = rounded_shape(10)
}
styles.normal  = { shape    = rounded_shape(5) }
styles.focus   = { fg_color = "#000000",
                   bg_color = colors.green,
                   markup   = function(t) return '<b><i>' .. t .. '</i></b>' end,
                   shape    = rounded_shape(5, true)
}
styles.header  = { fg_color =colors.purple,
                   markup   = function(t) return '<b><i>' .. t .. '</i></b>' end,
                   shape    = rounded_shape(10)
}
styles.weekday = { fg_color = colors.blue,
                   markup   = function(t) return '<b><i>' .. t .. '</i></b>' end,
                   shape    = rounded_shape(5)
}
local function decorate_cell(widget, flag, date)
    if flag=="monthheader" and not styles.monthheader then
        flag = "header"
    end
    local props = styles[flag] or {}
    if props.markup and widget.get_text and widget.set_markup then
        widget:set_markup(props.markup(widget:get_text()))
    end
    local d = {year=date.year, month=(date.month or 1), day=(date.day or 1)}
    local weekday = tonumber(os.date("%w", os.time(d)))
    local default_bg = (weekday==0 or weekday==6) and colors.darker_gray or colors.darker_gray.."5f"
    local ret = wibox.widget {
        {
            widget,
            margins = (props.padding or 2) + (props.border_width or 0),
            widget  = wibox.container.margin
        },
        shape        = props.shape,
        fg           = props.fg_color or colors.fg,
        bg           = props.bg_color or default_bg,
        widget       = wibox.container.background
    }
    return ret
end
local cal = wibox.widget {
    date     = os.date("*t"),
    fn_embed = decorate_cell,
    flex_height = true,
    font = "Roboto 14",
    widget   = wibox.widget.calendar.month
}

local date_popup = awful.popup {
      widget = {
        {
          {
            cal,
            {
              layout = wibox.layout.fixed.horizontal
            },
            {
              {
                {widget =  wibox.container.margin, top = 10, bottom = 10, widgets.volume},
                bg = colors.gray.."4f",
                shape = function(cr, width, height) 
                      gears.shape.rounded_rect(
                        cr, width, height, 15)
                end,
                widget = wibox.container.background
              },
              {
                {widget =  wibox.container.margin, margins=10,{
                  {
                    image = "/home/lvoidi/.config/awesome/images/icons/misc/battery.png",
                    forced_width = 10,
                    halign = "center",
                    valign = "center",
                    forced_height = 10,
                    widget = wibox.widget.imagebox
                  },
                  batteryarc_widget({
                    arc_thickness=9,
                    size = 100,
                  }),
                  layout = wibox.layout.stack
                }},
                bg = colors.gray.."4f",
                shape = function(cr, width, height) 
                      gears.shape.rounded_rect(
                        cr, width, height, 15)
                end,
                widget = wibox.container.background
              },
              spacing = 15,
              layout = wibox.layout.fixed.horizontal
            },
            layout = wibox.layout.align.vertical,
            },
            -- wibox.widget.textbox("ola"),
            margins = 20,
            widget = wibox.container.margin
        },
        forced_width = 700,
        forced_height = 600,
        bg = colors.bg,
        widget = wibox.container.background
      },
      shape =function(cr, width, height)
        gears.shape.partially_rounded_rect(
          cr, width, height,
          true, false,
          true,  false,
          15
        )
      end,
      ontop           = true,
      visible         = false,
      is_visible      = false,
  }
return date_popup

local gears = require("gears")
local beautiful = require("beautiful")
local colors = beautiful.colors
local awful = require("awful")
local wibox = require("wibox")
--local notif = require('widget.notif-center')
local dpi   = require("beautiful.xresources").apply_dpi

local tasklist_buttons = gears.table.join(
                     awful.button({ }, 1, function (c)
                                              if c == client.focus then
                                                  c.minimized = true
                                              else
                                                  c:emit_signal(
                                                      "request::activate",
                                                      "tasklist",
                                                      {raise = true}
                                                  )
                                              end
                                          end),
                     awful.button({ }, 3, function(c)
                                          	c:kill()
                                          end),
                     awful.button({ }, 4, function ()
                                              awful.client.focus.byidx(1)
                                          end),
                     awful.button({ }, 5, function ()
                                              awful.client.focus.byidx(-1)
                                          end))
                                          
local tasklist = function(s)
  local tasks = awful.widget.tasklist {
        screen   = s,
        filter   = awful.widget.tasklist.filter.currenttags,
        buttons  = tasklist_buttons,
        layout   = {
            spacing = 2,
            layout  = wibox.layout.fixed.horizontal
        },
        spacing  = 5,
        -- Notice that there is *NO* wibox.wibox prefix, it is a template,
        -- not a widget instance.
        widget_template = {
            {
                wibox.widget.base.make_widget(),
                --forced_height = 2,
                id            = 'background_role',
                widget        = wibox.container.background,
            },
            {
              
              {
                  {
                    id     = 'clienticon',
                    widget = awful.widget.clienticon,
                  },
                  margins = 1,
                  widget = wibox.container.margin,
              },
              margins = 3,
              left = 0,
              widget = wibox.container.margin
            },
            nil,
            create_callback = function(self, c, index, objects) --luacheck: no unused args
                self:get_children_by_id('clienticon')[1].client = c
            end,
            layout = wibox.layout.align.vertical,
        },
      }

    return tasks
end

return tasklist

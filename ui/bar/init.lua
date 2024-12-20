local awful = require("awful")
local wibox = require("wibox")
local dpi = require("beautiful.xresources").apply_dpi
local widgets = require("ui.widgets")
local helpers = require("utils.helpers")
local colors = require("beautiful").colors
local gears = require("gears")
local rubato = require("modules.rubato")

-- Create a textclock widget
local function mytextclock(screen) 
  return wibox.widget{
  {
    {
      {

        format = '<span foreground="'..colors.green..
                 '" font="FiraCode Nerd Font 10">%H </span>',
        widget = wibox.widget.textclock
      },
      {
        format = '<span foreground="'..colors.green..
               '" font="FiraCode Nerd Font 10">%M </span>',
        widget = wibox.widget.textclock
      },
      layout = wibox.layout.align.vertical
    },
    left = 15,
    right = 8,
    widget = wibox.container.margin,
  },
  shape = function(cr, width, height)
      gears.shape.partially_rounded_rect(
        cr, width, height, true, false, true, false, 30
      )
  end,
  bg = colors.gray,
  -- buttons = awful.button({}, 1, function()
  --   date_popup.y = -(screen.workarea.y + screen.selected_tag.gap)
  --   date_popup.x = ((screen.geometry.width - (10*screen.selected_tag.gap) )/ 2 ) - date_popup.width/2 + 23
  --   if date_popup.is_visible == false then
  --     date_popup.visible = true
  --     date_popup.is_visible = true
  --     local timed_movement_in = rubato.timed {
  --         duration = 1/2,
  --         intro = 1/4, 
  --         rate = 600,
  --         easing = rubato.quadratic,
  --         subscribed = function(pos)
  --           date_popup.y =screen.workarea.y + date_popup.height*(pos-1)
  --           date_popup.opacity = pos
  --         end
  --     }
  --     timed_movement_in.target = 1
  --
  --    else
  --     local timed_movement_out = rubato.timed {
  --         duration = 1/2, --half a second
  --         intro = 1/6, --one third of duration
  --         rate = 600,
  --         easing = rubato.quadratic,
  --         subscribed = function(pos)
  --           date_popup.y = (-date_popup.height-(screen.workarea.y + screen.selected_tag.gap))*pos
  --           date_popup.opacity = 1-pos
  --         end
  --     }
  --     timed_movement_out.target = 1
  --     date_popup.is_visible = false
  --   end
  -- end),
  widget = wibox.container.background
}
end
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
    s.systray = wibox.container.background({
        wibox.container.margin(
          {
            wibox.widget.systray(),
            layout = wibox.layout.fixed.horizontal
          },
          7, 7, 5, 6
        ),
        helpers.margin(2),
        {
          {
            s.mylayoutbox,
            left = 10,
            right = 5,
            widget = wibox.container.margin
          },
          bg = colors.darker_gray,
          shape = function(cr, width, height)
            gears.shape.partially_rounded_rect(
              cr, width, height, true, false, false, true, 30
            )
          end,
          widget = wibox.container.background
        },
        layout = wibox.layout.fixed.horizontal
      },
      colors.gray, function(cr, width, height)
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
          {
            {
              widgets.menu(s),
              right = 6,
              widget = wibox.container.margin
            },
            bg = colors.darker_gray,
            shape = function(cr, width, height)
              gears.shape.partially_rounded_rect(
                cr, width, height, false, true, true, false, 30
              )
            end,
            widget = wibox.container.background
          },
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

    local middle = mytextclock(s)
    local right = {
      helpers.margin(5),
      -- widgets.volume,
      helpers.margin(5),
      s.systray,
      layout = wibox.layout.fixed.horizontal
    }

    -- Create the wibox
    s.mywibox = awful.wibar {
        position = "top",
        screen   = s,
        height = dpi(40),
        opacity = 1,
        widget   = wibox.container.margin({
              layout = wibox.layout.align.horizontal,
              expand = "none",
              left,
              middle,
              right,
            }, 0, 0, 0, 2)

    }
end)

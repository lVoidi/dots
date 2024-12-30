local gears = require("gears")
local rubato = require("modules.rubato")
local separate = require("utils.helpers").margin
local beautiful = require("beautiful")
local colors  = beautiful.colors
local awful = require("awful")
local wibox = require("wibox")
local dpi           = require("beautiful.xresources").apply_dpi


-- Default general vlaues
local dir = os.getenv("HOME") .. "/.config/awesome"
local username          = beautiful.username
local phrase            = beautiful.description
local myavatar          = dir .. "/images/global/avatar.jpg"
local menu_opacity      = 1

-- This widget contains the username, the phrase and the description 
-- Image is 200x200 but the avatar.jpg file can be any size
local my_user_widget = wibox.widget {
  {
    {
      {
        {
          {
            {
              image = myavatar,
              forced_width = 200,
              forced_height = 200,
              widget = wibox.widget.imagebox
            },
            shape = gears.shape.rounded_bar,
            shape_clip = true,
            widget = wibox.container.background
          },
          widget = wibox.container.margin
        },
        {
          {
            {
              markup = '<span foreground="'..colors.fg..'">'..username.."</span>",
              font = "FiraCode Nerd Font 60",
              forced_height = 80,
              widget = wibox.widget.textbox
            },
            top = 40,
            left = 40,
            widget = wibox.container.margin
          },
          {
            {
              markup = '<span foreground="'
                        ..colors.blue
                        ..'">'
                        ..phrase
                        .."  </span>",
              font = "FiraCode Nerd Font 35",
              forced_height = 60,
              widget = wibox.widget.textbox
            },
            left = 40,
            bottom = 10,
            widget = wibox.container.margin
          },
          layout = wibox.layout.fixed.vertical
        },
        layout = wibox.layout.fixed.horizontal
      },
      margins = 10,
      widget = wibox.container.margin
    },
    bg = colors.gray .. "53",
    shape = function(cr, width, height)
      gears.shape.partially_rounded_rect (cr, width, height, true, true, false, false,
      10)
    end,
    widget = wibox.container.background
  },
  margins = 0,
  widget = wibox.container.margin
}


-- Shows the local hour, weekday and date
local clock = wibox.widget {
  {
    {
      {
        format = '<span foreground="'..colors.green..'">%H</span><span font="Varsity Regular 50"> </span>',
        font = "FiraCode Nerd Font 120",
        widget = wibox.widget.textclock
      },
      margins = 10,
      bottom = 0,
      widget = wibox.container.margin
    },
    {
      {

        wibox.widget{
          markup = '<span foreground="'..colors.yellow..'"> </span>',
          font = "FiraCode Nerd Font 14",
          widget = wibox.widget.textbox
        },
        {
          top = 15,
          widget = wibox.container.margin
        },
        wibox.widget{
          markup = '<span foreground="'..colors.yellow..'"> </span>',
          font = "FiraCode Nerd Font 14",
          widget = wibox.widget.textbox
        },
        layout = wibox.layout.fixed.vertical
      },
      valign = 'center',
      widget = wibox.container.place
    },
    {
      {
        format = '<span font="Varsity Regular 40"> </span><span foreground="'..colors.blue..'">%M</span>',
        font = "FiraCode Nerd Font 120",
        widget = wibox.widget.textclock
      },
      margins = 10,
      bottom = 0,
      widget = wibox.container.margin
    },
    layout = wibox.layout.align.horizontal
  },
  {
      {
        format = '<span foreground="'..colors.fg..'"><i>%A, %B %e </i></span>',
        font = "FiraCode Nerd Font 30",
        forced_height = 60,
        widget = wibox.widget.textclock,
        halign = "center"
      },
      widget = wibox.container.margin
  },
  layout = wibox.layout.fixed.vertical
}

-- Wraps the clock in a single widget
clock = wibox.widget{
  {
    clock,
    halign = 'center',
    valign = 'bottom',
    widget = wibox.container.place
  },
  bg = colors.gray .. "af",
  shape = function(cr, width, height)
    gears.shape.partially_rounded_rect(
      cr, width, height,
      false, false,
      true, true,
      10
    )
  end,
  widget = wibox.container.background
}


-- Shows the launch button
local start_widget = wibox.widget{
  {
    {
      markup = '<span foreground="'
        ..colors.gray..
        '"><span font="FiraCode Nerd Font 26">󱓟 '
        ..'</span><span font="FiraCode Nerd Font 20"> Launch</span></span>',
      align = 'center',
      valign = 'center',
      widget = wibox.widget.textbox
    },
    margins = 10,
    widget = wibox.container.margin
  },
  bg = colors.blue .. "df",
  shape = function(cr, width, height)
    gears.shape.partially_rounded_rect(
      cr,  width, height,
      true, true,
      false, false,
      10
    )
  end,
  widget = wibox.container.background
}

-- Required signals for visuals and functionality
start_widget:connect_signal("mouse::enter", function()
  start_widget.bg = colors.blue .. "ff"
end)

start_widget:connect_signal("mouse::leave", function()
  start_widget.bg = colors.blue .. "df"
end)

start_widget:connect_signal("button::press", function()
  start_widget.bg = colors.fg
  awful.spawn.with_shell("rofi -show drun")
end)

---------------------- 
---
--- System Bars 
---
----------------------

-- Ram wrapper 
local ram_bar = wibox.widget {
  max_value     = 100,
  value         = 99,
  forced_height = dpi(5),
  margins       = {
    top = dpi(8),
    bottom = dpi(8),
  },
  forced_width  = dpi(450),
  background_color = colors.darker_gray,
  color = colors.fg,
  shape         = gears.shape.rounded_bar,
  widget        = wibox.widget.progressbar,
}


-- Ram script used 
local used_ram_script = [[
  bash -c "
  free -m | grep 'Mem:' | awk '{printf \"%d@@%d@\", $7, $2}'
  "]]

awful.widget.watch(used_ram_script, 20, function(_, stdout)
                     local available = stdout:match('(.*)@@')
                     local total = stdout:match('@@(.*)@')
                     local used_ram_percentage = (total - available) / total * 100
                     ram_bar.value = used_ram_percentage
end)

-- Ram widget wrapper 
local ram = wibox.widget{
  {
    markup = '<span foreground="'..colors.blue..'" font="FiraCode Nerd Font 20"> </span>',
    widget = wibox.widget.textbox,
  },
  separate(5),
  ram_bar,
  expand = "inside",
  layout = wibox.layout.align.horizontal,
  widget = wibox.container.background
}

-- CPU BAR
local cpu_bar = wibox.widget {
  max_value     = 100,
  forced_height = dpi(5),
  margins       = {
    top = dpi(8),
    bottom = dpi(8),
  },
  forced_width  = dpi(450),
  background_color = colors.darker_gray,
  color = colors.fg, --.. "ef",
  shape         = gears.shape.rounded_bar,
  widget        = wibox.widget.progressbar,
}

local cpu_idle_script = [[
  bash -c "
  vmstat 1 2 | tail -1 | awk '{printf \"%d\", $15}'
  "]]

awful.widget.watch(cpu_idle_script, 20, function(_, stdout)
  local cpu_idle = stdout
  cpu_idle = string.gsub(cpu_idle, '^%s*(.-)%s*$', '%1')
  cpu_bar.value = 100-tonumber(cpu_idle)
end)

-- CPU wrapper 
local cpu = wibox.widget{
  {
    markup = '<span foreground="'..colors.blue.."ef"..'" font="FiraCode Nerd Font 20">  </span>',
    ellipsize = "none",
    widget = wibox.widget.textbox,
  },
  separate(5),
  cpu_bar,
  expand = "inside",
  layout = wibox.layout.align.horizontal,
  widget = wibox.container.background
}


-- Disk wrapper 
local disk_bar = wibox.widget {
  max_value     = 1,
  value         = 0.3,
  forced_height = dpi(5),
  margins       = {
    top = dpi(8),
    bottom = dpi(8),
  },
  forced_width  = dpi(450),
  background_color = colors.darker_gray,
  color = colors.fg, --.. "ef",
  shape         = gears.shape.rounded_bar,
  widget        = wibox.widget.progressbar,
}

local disk_idle_script = "python3 "..dir.."/scripts/syscript.py -u s"

awful.widget.watch(disk_idle_script, 20, function(_, stdout)
  disk_bar.value = tonumber(stdout)
end)

local disk = wibox.widget{
  {
    markup = '<span foreground="'..colors.blue.."ef"..'" font="FiraCode Nerd Font 20"> </span>',
    widget = wibox.widget.textbox,
  },
  separate(5),
  disk_bar,
  expand = "inside",
  layout = wibox.layout.align.horizontal,
  widget = wibox.container.background
}

-- Logout button, calls the logout popup
local logout = wibox.widget{
  {
    {
      markup = '<span foreground="'
        ..colors.gray..
        '"><span font="FiraCode Nerd Font 20">󰗼 '
        ..'</span><span font="FiraCode Nerd Font 16">Logout</span></span>',
      separate(0),
      align = 'center',
      valign = 'center',
      widget = wibox.widget.textbox
    },
    margins = 4,
    widget = wibox.container.margin
  },
  bg = colors.red,
  shape = function(cr, width, height)
    gears.shape.partially_rounded_rect(
      cr, width, height,
      false, false,
      true,  true,
      10
    )
  end,
  widget = wibox.container.background
}

logout:connect_signal("mouse::enter", function()
  logout.bg = colors.red .. "ff"
end)

logout:connect_signal("mouse::leave", function()
  logout.bg = colors.red .. "df"
end)

logout:connect_signal("button::press", function()
  logout.bg = colors.fg
  require("modules.awesome-wm-widgets.logout-popup-widget.logout-popup").launch()
end)


-- This function wraps the menu as a widget for the wibar, with the awesome wm logo. You can change this 
-- in images/global/awesome.svg. Any SVG would work.
local function return_menu(screen)
  local menu_popup = awful.popup {
      widget = {
        {
          {
            {
              my_user_widget,
              clock,
              {
                bottom = 12,
                widget = wibox.container.margin
              },
              {
                start_widget,
                {
                  {
                    {
                        {
                          ram,
                          cpu,
                          disk,
                          spacing = 5,
                          layout = wibox.layout.grid.vertical
                        },
                        margins = 7,
                        widget = wibox.container.margin
                    },
                    align = 'center',
                    valign = 'center',
                    widget = wibox.container.place
                  },
                  bg = colors.gray .. "df",
                  widget = wibox.container.background
                },

                logout,
                layout = wibox.layout.fixed.vertical
              },
              layout = wibox.layout.fixed.vertical
            },
            margins = 7,
            widget = wibox.container.margin
          },
          bg = colors.bg,
          widget = wibox.container.background
        },
        margins = 3,
        widget = wibox.container.margin
      },
      shape =function(cr, width, height)
        gears.shape.partially_rounded_rect(
          cr, width, height,
          false, false,
          true,  false,
          15
        )
      end,
      ontop           = true,
      visible         = false,
      opacity         = menu_opacity,
      is_visible      = false,
  }

  local menu = wibox.widget{
    {
        {
            image  = dir .. "/images/global/awesome.svg",
            resize = true,
            widget = wibox.widget.imagebox
        },
        --Margin 
        margins = 3,
        widget = wibox.container.margin,
    },
    widget     = wibox.container.background,
    buttons = awful.button({}, 1, function()
    menu_popup.y = screen.workarea.y
    menu_popup.x = -1000
    if menu_popup.is_visible == false then
      menu_popup.visible = true
      menu_popup.is_visible = true
      local timed_movement_in = rubato.timed {
          duration = 1/2,
          intro = 1/4,
          rate = 100,
          easing = rubato.quadratic,
          subscribed = function(pos)
            menu_popup.x = menu_popup.width*(pos-1)
	    menu_popup.opacity = pos*menu_opacity
          end
      }
      timed_movement_in.target = 1

     else
      local timed_movement_out = rubato.timed {
          duration = 1/2,
          intro = 1/4,
          rate = 100,
          easing = rubato.quadratic,
          subscribed = function(pos)
            menu_popup.x = -menu_popup.width*pos
	    menu_popup.opacity = (1-pos)*menu_opacity
          end
      }
      timed_movement_out.target = 1
      menu_popup.is_visible = false
    end
  end)
  }

  return menu
end

return return_menu

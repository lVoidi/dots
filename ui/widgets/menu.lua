local gears = require("gears")
local add_app = require("utils.helpers").app
local beautiful = require("beautiful")
local colors  = beautiful.colors
local awful = require("awful")
local wibox = require("wibox")
local vars = require("config.declarations")
local dpi           = require("beautiful.xresources").apply_dpi

local dir = os.getenv("HOME") .. "/.config/awesome"

local username = os.getenv("USER")
local myavatar = dir .. "/images/global/avatar.jpg"

local myfavoritebrowser = vars.browser
local terminal          = vars.terminal
local editor            = vars.editor
local phrase            = "Please give me social credit"

local my_user_widget = wibox.widget {
  {
    {
      {
        {
          
          {
            {
              markup = '<span foreground="'..colors.red..'">'..username.."</span>",
              font = "Huggie Bunny 40",
              align = "center",
              widget = wibox.widget.textbox
            },
            {
              markup = '<span foreground="'
                        ..colors.orange
                        ..'">'
                        ..phrase
                        .."</span>",
              font = 'Roboto 13',  
              widget = wibox.widget.textbox
            },
            
            layout = wibox.layout.fixed.vertical
          },
          {
            {
              {
                image = myavatar,
                vertical_fit_policy = "fit",
                forced_width = 128,
                forced_height = 128,
                widget = wibox.widget.imagebox
              },
              clip_shape = true,
              shape = gears.shape.rounded_bar,
              widget = wibox.container.background
            },
            margins = 10,
            widget = wibox.container.margin
          },
          layout = wibox.layout.fixed.horizontal
        },
        halign = 'center',
        valign = 'center',
        widget = wibox.container.place
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



local clock = wibox.widget {
  {
    {
      {
        format = '<span foreground="'..colors.red..'">%H</span>',
        font = "Roboto 80",
        align = "top",
        widget = wibox.widget.textclock
      },
      margins = 10,
      bottom = 0, 
      widget = wibox.container.margin
    },
    {
      {
        {
          top = 15,
          bottom = 15,
          widget = wibox.container.margin
        },
        wibox.widget{
          markup = '<span foreground="'..colors.green..'"></span>',
          font = "JetBrainsMono Nerd Font 14",
          widget = wibox.widget.textbox        
        },
        {
          top = 5,
          bottom = 5,
          widget = wibox.container.margin
        },
        wibox.widget{
          markup = '<span foreground="'..colors.yellow..'"></span>',
          font = "JetBrainsMono Nerd Font 14",
          widget = wibox.widget.textbox
        }, 
        {
          top = 10,
          bottom = 10,
          widget = wibox.container.margin
        },
        layout = wibox.layout.fixed.vertical
        
      },
      valign = 'center',
      widget = wibox.container.place
    },
    {
      {
        format = '<span foreground="'..colors.purple..'">%M</span>',
        font = "Roboto 80",
        align = "top",
        widget = wibox.widget.textclock
      },
      margins = 10,
      bottom = 0,
      widget = wibox.container.margin
    },
    layout = wibox.layout.fixed.horizontal
  },
  layout = wibox.layout.fixed.vertical
}
clock = wibox.widget{
  {
    { 
      clock,
      align = 'center',
      valign = 'center',
      widget = wibox.container.place
    },
    {
      {
        format = '<span foreground="'..colors.blue..'"><i>%A</i></span>',
        font = "Roboto 20",
        align = 'top',
        widget = wibox.widget.textclock
      },
      valign = 'top',
      align = 'center',
      widget = wibox.container.place
    },
    wibox.container.margin(nil, 0, 0, 0, 20),
    layout = wibox.layout.align.vertical
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

local function return_menu(screen)
  local adjustment = function() 
    if screen.workarea.width <= 1366 then
      return 0.3

    else
      return 1
    end
  end

  local adjust = adjustment()

  local menu_popup = awful.popup {
      widget = {
        {
          {
            
            {
              my_user_widget,
              clock,
              {
                bottom = 10*adjust,
                widget = wibox.container.margin
              },
              
              layout = wibox.layout.fixed.vertical
            },
            
            margins = 10*adjust,
            widget = wibox.container.margin
          },
          bg = colors.bg,
          widget = wibox.container.background
        },
        margins = 5*adjust,
        widget = wibox.container.margin
      },
      bg           = colors.bg,
      fg           = colors.fg,
      border_color = colors.gray,
      border_width = 5*adjust,
      --hide_on_right_click = true,
      ontop        = true,
      visible      = false,
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
    if menu_popup.visible then
      menu_popup.visible = false
    else
      menu_popup.x = screen.workarea.x 
      menu_popup.y = screen.workarea.y
      --menu_popup.y = 50
      --menu_popup:move_next_to(mouse.current_widget_geometry)
      menu_popup.visible = true
    end
  end)
  }

  return menu 
end

return return_menu

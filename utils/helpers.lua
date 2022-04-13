local wibox = require("wibox")
local colors = require("beautiful").colors
local gears = require("gears")

local separator = function(size) 
  return wibox.widget{
    margins = size,
    widget = wibox.container.margin
  } 
end


local function add_app(app, text, fg, bg)     

        local widget = wibox.widget {
            {
              {
                  {
                    markup = text,
                    font = "JetBrainsMono Nerd Font 12",
                    widget = wibox.widget.textbox
                  },
                  -- Margin 
                  left   = 10,
                  spacing = 20,
                  top    = 4,
                  bottom = 4,
                  right  = 10,
                  widget = wibox.container.margin,
              },
              align = 'center',
              valign = 'center',
              widget = wibox.container.place
            },
            
            bg         = bg,
            fg         = fg,
            shape_border_width = 5,
            shape_border_color = colors.fg .. "0e",
            -- Sets the shape 
            shape      = gears.shape.rounded_rect,
            shape_clip = true,
            widget     = wibox.container.background,
        }
        -- When pressed the widget, it will
        -- change its color and spawn the app
        widget:connect_signal("button::press",
            function()
                widget.fg = colors.blue
                app()
                --awful.spawn.with_shell(app)
            end
        )

        -- This function will be called when the button  is 
        -- released
        widget:connect_signal("button::release",
            function()
                widget.fg = fg
            end
        )

        -- When its on hover, it will change its color
        widget:connect_signal("mouse::enter",
            function()

                widget.fg = colors.fg
            end
        )
        
        widget:connect_signal("mouse::leave",
            function()
                widget.fg = fg

            end
        )
        return widget
    end

return {
  margin = separator,
  app = add_app
}

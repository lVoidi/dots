local awful = require("awful")
local wibox = require("wibox")
local colors = require("beautiful").colors
local dpi = require("beautiful.xresources").apply_dpi

awful.util.tagnames = {
  '<span foreground="'..colors.red..'">󱇶 </span>',
  '<span foreground="'..colors.yellow..'"> </span>',
  '<span foreground="'..colors.green..'">󰅨 </span>',
  '<span foreground="'..colors.blue..'"> </span>',
  '<span foreground="'..colors.purple..'"> </span>'
}

awful.util.taglist_buttons = {
    awful.button({ }, 1, function(t) t:view_only() end),
    awful.button({ modkey }, 1, function(t)
        if client.focus then
            client.focus:move_to_tag(t)
        end
    end),
    awful.button({ }, 3, awful.tag.viewtoggle),
    awful.button({ modkey }, 3, function(t)
        if client.focus then
            client.focus:toggle_tag(t)
        end
    end),
    awful.button({ }, 4, function(t) awful.tag.viewnext(t.screen) end),
    awful.button({ }, 5, function(t) awful.tag.viewprev(t.screen) end)
  }


local function return_taglist(s)
    local unfocus_icon = " "
    local item_color = colors.blue

    local empty_icon = " "

    local focus_icon =  " "
    local focus_color = colors.dim_blue
----------------------------------------------------------------------
----------------------------------------------------------------------

    -- Function to update the tags
    local update_tags = function(self, c3)
        local tagicon = self:get_children_by_id('icon_role')[1]
        local isurgent = false
        if c3.selected then
            tagicon.text = focus_icon
            self.fg = focus_color
    elseif #c3:clients() == 0 then
            tagicon.text = empty_icon
            self.fg = item_color
        elseif c3.urgent then
            tagicon.text = " "
            self.fg = colors.yellow
        else
            if isurgent == false then
                tagicon.text = unfocus_icon
                self.fg = item_color
            end
        end

        c3:connect_signal("property::urgent",
        function()
            isurgent = true
            tagicon.text = " "
            self.fg = colors.yellow
        end
        )
    end
----------------------------------------------------------------------
----------------------------------------------------------------------
local icon_taglist = awful.widget.taglist {
  screen = s,
  filter = awful.widget.taglist.filter.all,
  layout = {spacing = 0, layout = wibox.layout.flex.horizontal},
  widget_template = {
    {
      {
        {
          id = 'workspace_role',
          font = "JetBrainsMono Nerd Font 16",
          widget = wibox.widget.textbox
        },
        {
          id = 'icon_role',
          font = "JetBrainsMono Nerd Font 8",
          valign = "top",
          widget = wibox.widget.textbox
        },
        spacing = 0,
        layout = wibox.layout.fixed.horizontal
      },
      id = 'margin_role',
      top = dpi(0),
      bottom = dpi(0),
      left = dpi(2),
      right = dpi(2),
      widget = wibox.container.margin
    },
    id = 'background_role',
    widget = wibox.container.background,
    create_callback = function(self, c3, index, _)
      update_tags(self, c3)
      local workspace = self:get_children_by_id('workspace_role')[1]
      workspace.markup = awful.util.tagnames[index]
    end,
    update_callback = function(self, c3, index, _) --luacheck: no unused args
      update_tags(self, c3)
      local workspace = self:get_children_by_id('workspace_role')[1]
      workspace.markup = awful.util.tagnames[index]
    end,

    },
    buttons = awful.util.taglist_buttons
  }
    local taglist = wibox.widget{
      {
        icon_taglist,
        left = 7,
        right = 7,
        widget = wibox.container.margin
      },
      margins = 1,
      widget = wibox.container.margin
  }

  return taglist
end

return return_taglist

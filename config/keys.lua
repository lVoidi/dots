local awful = require("awful")
local vars = require("config.declarations")
local hotkeys_popup = require("awful.hotkeys_popup")
local volume_widget = require('modules.awesome-wm-widgets.volume-widget.volume')
local alt = "Mod1"


awful.mouse.append_global_mousebindings({
    awful.button({ }, 4, awful.tag.viewprev),
    awful.button({ }, 5, awful.tag.viewnext),
})

awful.keyboard.append_global_keybindings({

  -- Browser
  awful.key({ vars.mod }, "w", function() awful.spawn(vars.browser) end,
            {description="Open browser", group="custom"}),

  -- Telegram
  awful.key({ vars.mod }, "t", function() awful.spawn(vars.telegram_client) end,
            {description="Opens telegram", group="custom"}),

  -- Discord
  awful.key({ vars.mod }, "d", function() awful.spawn(vars.discord_client) end,
            {description="Open discord", group="custom"}),

  -- Teams
  awful.key({ vars.mod }, "c", function() awful.spawn("teams") end,
            {description="Open microsoft teams", group="custom"}),

  -- Office
  awful.key({ vars.mod }, "g", function() awful.spawn(vars.office) end,
            {description="Open microsoft teams", group="custom"}),
  
  -- File Manager
  awful.key({ vars.mod }, "e", function() awful.spawn(vars.file_manager) end,
            {description="File Manager", group="custom"}),

  -- Screenshot
  awful.key({ }, "Print", function() awful.spawn(vars.screenshot) end,
            {description="Take screenshot", group="custom"}),

  -- Swap between keyboard layouts
  -- awful.key({ vars.mod }, "space", function() awful.spawn({"bash", "/home/mrjakesir/.config/awesome/scripts/switch_keyboard.sh"}) end,
  --           {description="Switch keyboard layout", group="custom"}),

  -- System security
  awful.key({ vars.mod }, "z", function() awful.spawn.with_shell("bash /home/mrjakesir/Documentos/Proyects/security/run.sh") end,
            {description="Switch keyboard layout", group="custom"}),
  
  -- Audio
  awful.key({ vars.mod }, "v", function() awful.spawn.with_shell(vars.audio_control) end,
            {description="Open audio control", group="custom"}),
  
  -- Increasing volume
  awful.key({ vars.mod }, "=", function() volume_widget:inc() end,
            {description="Increase volume", group="custom"}),
  
  -- Decreasing volume
  awful.key({ vars.mod }, "-", function() volume_widget:dec() end,
            {description="Decrease volume", group="custom"}),

  -- Logout
  awful.key({ vars.mod }, "x", require("modules.awesome-wm-widgets.logout-popup-widget.logout-popup").launch,
            {description="Logout", group="custom"}),

  awful.key({ vars.mod }, "a", function() awful.spawn.with_shell("python /home/mrjakesir/Documentos/Proyects/asistente/main.py") end)
})

awful.keyboard.append_global_keybindings({
    awful.key({ vars.mod,           }, "s",      hotkeys_popup.show_help,
              {description="show help", group="awesome"}),

    awful.key({ vars.mod, "Shift" }, "r", awesome.restart,
              {description = "reload awesome", group = "awesome"}),

    awful.key({ vars.mod, "Shift"   }, "q", awesome.quit,
              {description = "quit awesome", group = "awesome"}),

    awful.key({ vars.mod,           }, "Return", function () awful.spawn(vars.terminal) end,
              {description = "open a terminal", group = "launcher"}),

    awful.key({ vars.mod },            "r",     function () awful.spawn.with_shell(vars.run) end,
              {description = "run prompt", group = "launcher"}),

    awful.key({ vars.mod }, "p", function() menubar.show() end,
              {description = "show the menubar", group = "launcher"}),
})

-- Tags related keybindings
awful.keyboard.append_global_keybindings({
    awful.key({ vars.mod,           }, "Left",   awful.tag.viewprev,
              {description = "view previous", group = "tag"}),
    awful.key({ vars.mod,           }, "Right",  awful.tag.viewnext,
              {description = "view next", group = "tag"}),
    awful.key({ vars.mod,           }, "Escape", awful.tag.history.restore,
              {description = "go back", group = "tag"}),

    -- Move tag to the left
    awful.key({ vars.mod, "Shift" }, "Left",
      function() 
        local tag = awful.screen.focused().selected_tag
        awful.tag.move(tag.index - 1, tag)
      end,
      {
        description = "Move current tag to the left",
        group = "tag"
      }
    ),

    -- Move tag to the right
    awful.key({ vars.mod, "Shift" }, "Right", 
      function() 
        local tag = awful.screen.focused().selected_tag
        awful.tag.move(tag.index + 1, tag)
      end,
      {
        description = "Move current tag to the right",
        group = "tag"
      }
    ),
    
    -- Increment gap
    awful.key({ "Mod1", "Control" }, "h", 
      function()
        local screen = awful.screen.focused()
        local tag = screen.selected_tag
        tag.gap = tag.gap + 1
        awful.layout.arrange(screen)
      end,
      {
        description = "Increment gaps",
        group = "tag"
      }
    ),

    -- Decrement gap
    awful.key({ "Mod1", "Control" }, "j", 
      function()
        local screen = awful.screen.focused()
        local tag = screen.selected_tag
        tag.gap = tag.gap - 1
        awful.layout.arrange(screen)
      end,
      {
        description = "Decrement gaps",
        group = "tag"
      }
    )
})

-- Focus related keybindings
awful.keyboard.append_global_keybindings({
    awful.key({ vars.mod,           }, "j",
        function ()
            awful.client.focus.byidx( 1)
        end,
        {description = "focus next by index", group = "client"}
    ),
    awful.key({ vars.mod,           }, "k",
        function ()
            awful.client.focus.byidx(-1)
        end,
        {description = "focus previous by index", group = "client"}
    ),
    awful.key({ vars.mod,           }, "Tab",
        function ()
            awful.client.focus.history.previous()
            if client.focus then
                client.focus:raise()
            end
        end,
        {description = "go back", group = "client"}),
    awful.key({ vars.mod, "Control" }, "j", function () awful.screen.focus_relative( 1) end,
              {description = "focus the next screen", group = "screen"}),
    awful.key({ vars.mod, "Control" }, "k", function () awful.screen.focus_relative(-1) end,
              {description = "focus the previous screen", group = "screen"}),
    awful.key({ vars.mod, "Control" }, "n",
              function ()
                  local c = awful.client.restore()
                  -- Focus restored client
                  if c then
                    c:activate { raise = true, context = "key.unminimize" }
                  end
              end,
              {description = "restore minimized", group = "client"}),
})

-- Layout related keybindings
awful.keyboard.append_global_keybindings({
    awful.key({ vars.mod, "Shift"   }, "j", function () awful.client.swap.byidx(  1)    end,
              {description = "swap with next client by index", group = "client"}),
    awful.key({ vars.mod, "Shift"   }, "k", function () awful.client.swap.byidx( -1)    end,
              {description = "swap with previous client by index", group = "client"}),
    awful.key({ vars.mod,           }, "u", awful.client.urgent.jumpto,
              {description = "jump to urgent client", group = "client"}),
    awful.key({ vars.mod,           }, "l",     function () awful.tag.incmwfact( 0.05)          end,
              {description = "increase master width factor", group = "layout"}),
    awful.key({ vars.mod,           }, "h",     function () awful.tag.incmwfact(-0.05)          end,
              {description = "decrease master width factor", group = "layout"}),
    awful.key({ vars.mod, "Shift"   }, "h",     function () awful.tag.incnmaster( 1, nil, true) end,
              {description = "increase the number of master clients", group = "layout"}),
    awful.key({ vars.mod, "Shift"   }, "l",     function () awful.tag.incnmaster(-1, nil, true) end,
              {description = "decrease the number of master clients", group = "layout"}),
    awful.key({ vars.mod, "Control" }, "h",     function () awful.tag.incncol( 1, nil, true)    end,
              {description = "increase the number of columns", group = "layout"}),
    awful.key({ vars.mod, "Control" }, "l",     function () awful.tag.incncol(-1, nil, true)    end,
              {description = "decrease the number of columns", group = "layout"}),
    awful.key({ vars.mod, "Control" }, "Right", function () awful.layout.inc( 1)                end,
              {description = "select next", group = "layout"}),
    awful.key({ vars.mod, "Control" }, "Left", function () awful.layout.inc(-1)                end,
              {description = "select previous", group = "layout"}),
})


awful.keyboard.append_global_keybindings({
    awful.key {
        modifiers   = { vars.mod },
        keygroup    = "numrow",
        description = "only view tag",
        group       = "tag",
        on_press    = function (index)
            local screen = awful.screen.focused()
            local tag = screen.tags[index]
            if tag then
                tag:view_only()
            end
        end,
    },
    awful.key {
        modifiers   = { vars.mod, "Control" },
        keygroup    = "numrow",
        description = "toggle tag",
        group       = "tag",
        on_press    = function (index)
            local screen = awful.screen.focused()
            local tag = screen.tags[index]
            if tag then
                awful.tag.viewtoggle(tag)
            end
        end,
    },
    awful.key {
        modifiers = { vars.mod, "Shift" },
        keygroup    = "numrow",
        description = "move focused client to tag",
        group       = "tag",
        on_press    = function (index)
            if client.focus then
                local tag = client.focus.screen.tags[index]
                if tag then
                    client.focus:move_to_tag(tag)
                    tag:view_only()
                end
            end
        end,
    },
    awful.key {
        modifiers   = { vars.mod, "Control", "Shift" },
        keygroup    = "numrow",
        description = "toggle focused client on tag",
        group       = "tag",
        on_press    = function (index)
            if client.focus then
                local tag = client.focus.screen.tags[index]
                if tag then
                    client.focus:toggle_tag(tag)
                end
            end
        end,
    },
    awful.key {
        modifiers   = { vars.mod },
        keygroup    = "numpad",
        description = "select layout directly",
        group       = "layout",
        on_press    = function (index)
            local t = awful.screen.focused().selected_tag
            if t then
                t.layout = t.layouts[index] or t.layout
            end
        end,
    }
})

client.connect_signal("request::default_mousebindings", function()
    awful.mouse.append_client_mousebindings({
        awful.button({ }, 1, function (c)
            c:activate { context = "mouse_click" }
        end),
        awful.button({ vars.mod }, 1, function (c)
            c:activate { context = "mouse_click", action = "mouse_move"  }
        end),
        awful.button({ vars.mod }, 3, function (c)
            c:activate { context = "mouse_click", action = "mouse_resize"}
        end),
    })
end)

client.connect_signal("request::default_keybindings", function()
    awful.keyboard.append_client_keybindings({
        awful.key({ vars.mod,           }, "f",
            function (c)
                c.fullscreen = not c.fullscreen
                c:raise()
            end,
            {description = "toggle fullscreen", group = "client"}),
        awful.key({ vars.mod   }, "q",      function (c) c:kill()                         end,
                {description = "close", group = "client"}),

       awful.key({ vars.mod, "Shift" }, "space",  awful.client.floating.toggle,
              {description = "toggle floating", group = "client"}), 

        awful.key({ vars.mod, "Control" }, "Return", function (c) c:swap(awful.client.getmaster()) end,
                {description = "move to master", group = "client"}),
        awful.key({ vars.mod,           }, "o",      function (c) c:move_to_screen()               end,
                {description = "move to screen", group = "client"}),
        awful.key({ vars.mod,           }, "t",      function (c) c.ontop = not c.ontop            end,
                {description = "toggle keep on top", group = "client"}),
        awful.key({ vars.mod,           }, "n",
            function (c)
                -- The client currently has the input focus, so it cannot be
                -- minimized, since minimized clients can't have the focus.
                c.minimized = true
            end ,
            {description = "minimize", group = "client"}),
        awful.key({ vars.mod,           }, "m",
            function (c)
                c.maximized = not c.maximized
                c:raise()
            end ,
            {description = "(un)maximize", group = "client"}),
        awful.key({ vars.mod, "Control" }, "m",
            function (c)
                c.maximized_vertical = not c.maximized_vertical
                c:raise()
            end ,
            {description = "(un)maximize vertically", group = "client"}),
        awful.key({ vars.mod, "Shift"   }, "m",
            function (c)
                c.maximized_horizontal = not c.maximized_horizontal
                c:raise()
            end ,
            {description = "(un)maximize horizontally", group = "client"}),
    })
end)



local awful = require("awful")

client.connect_signal("mouse::enter", function(c)
    c:activate { context = "mouse_enter", raise = false }
end)

client.connect_signal("manage", function(c)
    if awesome.startup and
      not c.size_hints.user_position
      and not c.size_hints.program_position then
        awful.placement.no_offscreen(c)
    end

end)


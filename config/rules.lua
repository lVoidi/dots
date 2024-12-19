local ruled = require("ruled")
local awful = require("awful")
local beautiful = require("beautiful")
local vars = require("config.declarations")

ruled.client.connect_signal("request::rules", function()
    -- All clients will match this rule.
    ruled.client.append_rule {
        id         = "global",
        rule       = { },
        properties = {
            border_width = beautiful.border_width,
            border_color = beautiful.border_normal,
            focus = awful.client.focus.filter,
            raise = true,
            screen = awful.screen.preferred,
            placement = awful.placement.no_overlap+awful.placement.no_offscreen,
            size_hints_honor = false
        }
    }

    -- Floating clients.
    ruled.client.append_rule {
        id       = "floating",
        rule_any = {
            instance = { "copyq", "pinentry" },
            class    = {
                "Arandr", "Blueman-manager", "Gpick", "Kruler", "Sxiv",
                "Tor Browser", "Wpa_gui", "veromix", "xtightvncviewer"
            },
            name    = {
                "Event Tester",
            },
            role    = {
                "AlarmWindow",
                "ConfigManager",
                "pop-up",
            }
        },
        properties = { floating = true }
    }
    -- Terminal opacity
    ruled.client.append_rule {
        id       = "terminal",
        rule_any = {
            class    = {
                "Alacritty",
                "kitty"
            },
        },
        properties = { opacity = 1 }
    }
    -- Set telegram media viewer fullscreen
    ruled.client.append_rule {
        id       = "Media viewer",
        rule_any = {
            name    = {
                "Media viewer",
            }
        },
        properties = { fullscreen = true, ontop = true}
    }

    -- Add titlebars to normal clients and dialogs
    ruled.client.append_rule {
        id         = "titlebars",
        rule_any   = { type = { "normal", "dialog" } },
        properties = { titlebars_enabled = true      }
    }

end)

ruled.notification.connect_signal('request::rules', function()
    ruled.notification.append_rule {
        rule       = { },
        properties = {
            screen           = awful.screen.preferred,
            implicit_timeout = 5,
        }
    }
end)

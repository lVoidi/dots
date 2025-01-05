local theme_assets = require("beautiful.theme_assets")
local xresources = require("beautiful.xresources")
local rnotification = require("ruled.notification")
local dpi = xresources.apply_dpi

local gfs = require("gears.filesystem")
local themes_path = gfs.get_themes_dir()
local path = string.format("%s/.config/awesome", os.getenv("HOME"))
local icon_path = "~/.config/awesome/images/icons/"
local theme = {}

theme.font          = "FiraCode Nerd Font 8"
theme.font_name     = "FiraCode Nerd Font "
theme.username      = "lVoidi"
theme.description   = "Lock tf in"
theme.colors = {
    red = "#bf616a",
    orange = "#d08770",
    yellow = "#ebcb8b",
    green = "#a3be8c",
    purple = "#b48ead",
    blue = "#8fbcbb",
    dim_blue = "#81a1c1",
    bg = "#2e3440",
    fg = "#d8dee9",
    gray = "#4c566a",
    darker_gray_but_not_that_dark = "#434c5eaa",
    darker_gray = "#3b4252"
}

theme.bg_normal     = theme.colors.bg 
theme.bg_focus      = theme.colors.bg .. "00"
theme.bg_urgent     = theme.colors.bg .. "00"
theme.bg_minimize   = theme.colors.bg .. "00"
theme.bg_systray    = theme.colors.gray

theme.hotkeys_modifiers_fg    = theme.colors.fg .. "df"
theme.fg_normal     = theme.colors.fg
theme.fg_focus      = theme.colors.purple
theme.fg_urgent     = theme.colors.red
theme.fg_minimize   = theme.colors.dim_blue

theme.useless_gap         = 10
theme.border_width        = dpi(0)
theme.border_radius       = dpi(10)
theme.systray_icon_spacing = 5
theme.border_color_normal = theme.colors.gray
theme.border_color_active = theme.colors.fg
theme.border_color_marked = theme.colors.yellow

-- titlebar 
theme.titlebar_bg_focus = theme.colors.bg
theme.titlebar_bg = theme.colors.bg


-- There are other variable sets
-- overriding the default one when
-- defined, the sets are:
-- taglist_[bg|fg]_[focus|urgent|occupied|empty|volatile]
-- tasklist_[bg|fg]_[focus|urgent]
-- titlebar_[bg|fg]_[normal|focus]
-- tooltip_[font|opacity|fg_color|bg_color|border_width|border_color]
-- mouse_finder_[color|timeout|animate_timeout|radius|factor]
-- prompt_[fg|bg|fg_cursor|bg_cursor|font]
-- hotkeys_[bg|fg|border_width|border_color|shape|opacity|modifiers_fg|label_bg|label_fg|group_margin|font|description_font]
-- Example:
--theme.taglist_bg_focus = "#ff0000"

-- Generate taglist squares:
-- local taglist_square_size = dpi(4)
-- theme.taglist_squares_sel = theme_assets.taglist_squares_sel(
--     taglist_square_size, theme.fg_normal
-- )
-- theme.taglist_squares_unsel = theme_assets.taglist_squares_unsel(
--     taglist_square_size, theme.fg_normal
-- )

-- Variables set for theming notifications:
-- notification_font
-- notification_[bg|fg]
-- notification_[width|height|margin]
-- notification_[border_color|border_width|shape|opacity]

-- Variables set for theming the menu:
-- menu_[bg|fg]_[normal|focus]
-- menu_[border_color|border_width]
theme.menu_submenu_icon = themes_path.."default/submenu.png"
theme.menu_height = dpi(15)
theme.menu_width  = dpi(100)

-- You can add as many variables as
-- you wish and access them by using
-- beautiful.variable in your rc.lua
--theme.bg_widget = "#cc0000"
theme.titlebar_close_button_normal = icon_path.."titlebar/close/close_1.png"
theme.titlebar_close_button_focus = icon_path.."titlebar/close/close_2.png"
theme.titlebar_maximized_button_normal_inactive = icon_path.."titlebar/maximize/maximize_1.png"
theme.titlebar_maximized_button_focus_inactive  = icon_path.."titlebar/maximize/maximize_2.png"
theme.titlebar_maximized_button_normal_active = icon_path.."titlebar/maximize/maximize_3.png"
theme.titlebar_maximized_button_focus_active  = icon_path.."titlebar/maximize/maximize_3.png"
theme.titlebar_minimize_button_normal = icon_path.."titlebar/minimize/minimize_1.png"
theme.titlebar_minimize_button_focus  = icon_path.."titlebar/minimize/minimize_2.png"

-- hover
theme.titlebar_close_button_normal_hover = icon_path.."titlebar/close/close_3.png"
theme.titlebar_close_button_focus_hover = icon_path.."titlebar/close/close_3.png"
theme.titlebar_maximized_button_normal_inactive_hover = icon_path.."titlebar/maximize/maximize_3.png"
theme.titlebar_maximized_button_focus_inactive_hover  = icon_path.."titlebar/maximize/maximize_3.png"
theme.titlebar_maximized_button_normal_active_hover = icon_path.."titlebar/maximize/maximize_3.png"
theme.titlebar_maximized_button_focus_active_hover  = icon_path.."titlebar/maximize/maximize_3.png"
theme.titlebar_minimize_button_normal_hover = icon_path.."titlebar/minimize/minimize_3.png"
theme.titlebar_minimize_button_focus_hover  = icon_path.."titlebar/minimize/minimize_3.png"

theme.wallpaper = path.."/images/global/wallpaper.png"

-- You can use your own layout icons like this:
theme.layout_fairh = themes_path.."default/layouts/fairhw.png"
theme.layout_fairv = themes_path.."default/layouts/fairvw.png"
theme.layout_floating  = themes_path.."default/layouts/floatingw.png"
theme.layout_magnifier = themes_path.."default/layouts/magnifierw.png"
theme.layout_max = themes_path.."default/layouts/maxw.png"
theme.layout_fullscreen = themes_path.."default/layouts/fullscreenw.png"
theme.layout_tilebottom = themes_path.."default/layouts/tilebottomw.png"
theme.layout_tileleft   = themes_path.."default/layouts/tileleftw.png"
theme.layout_tile = themes_path.."default/layouts/tilew.png"
theme.layout_tiletop = themes_path.."default/layouts/tiletopw.png"
theme.layout_spiral  = themes_path.."default/layouts/spiralw.png"
theme.layout_dwindle = themes_path.."default/layouts/dwindlew.png"
theme.layout_cornernw = themes_path.."default/layouts/cornernww.png"
theme.layout_cornerne = themes_path.."default/layouts/cornernew.png"
theme.layout_cornersw = themes_path.."default/layouts/cornersww.png"
theme.layout_cornerse = themes_path.."default/layouts/cornersew.png"

-- Generate Awesome icon:
theme.awesome_icon = theme_assets.awesome_icon(
    theme.menu_height, theme.bg_focus, theme.fg_focus
)

theme.notification_spacing = theme.useless_gap
theme.notification_border_radius = dpi(0)
theme.notification_border_width = dpi(0)

-- Define the icon theme for application icons. If not set then the icons
-- from /usr/share/icons and /usr/share/icons/hicolor will be used.

theme.icon_theme = nil
return theme

-- vim: filetype=lua:expandtab:shiftwidth=4:tabstop=8:softtabstop=4:textwidth=80

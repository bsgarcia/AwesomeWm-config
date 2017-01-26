
--[[
                                             
     Powerarrow Darker Awesome WM config 2.0 
     github.com/copycat-killer               
                                             
--]]

theme                               = {}

themes_dir                          = os.getenv("HOME") .. "/.config/awesome/themes/random"
theme.wallpaper                     = "/home/random/.config/awesome/themes/random/yosemite.jpg"


theme.useless_gap_width             = 16
theme.font                          = "Terminus 8"
theme.fg_normal                     = "#DDDDFF"
theme.fg_focus                      = "#416644"--#13927C"
theme.fg_urgent                     = "#CC9393"
theme.bg_normal                     = "#1A1A1A"
theme.bg_focus                      = "#313131"
theme.bg_urgent                     = "#1a1a1a"
theme.wibox_border_color            = "#1a1a1a"
theme.wibox_border_width            = "2.2"
theme.border_width                  = "2.2"
theme.border_normal                 = "#282828"--"#1A1A1A"
theme.border_focus                  = "#416644"--#739890"
theme.titlebar_bg_normal            = "#1A1A1A"
theme.taglist_fg_focus              = "#DDDDFF"
theme.tasklist_bg_focus             = "1a1a1a"
theme.tasklist_fg_focus             = "#416644"--"#13927C"
theme.textbox_widget_margin_top     = 5 
theme.notify_fg                     = theme.fg_normal
theme.notify_bg                     = theme.bg_normal
theme.notify_border                 = theme.border_focus
theme.awful_widget_height           = 14
theme.awful_widget_margin_top       = 3 
theme.mouse_finder_color            = "#CC9393"
theme.menu_height                   = "16"
theme.menu_width                    = "140"

theme.submenu_icon                  = themes_dir .. "/icons/submenu.png"
--theme.taglist_squares_sel           = themes_dir .. "/icons/green_line_sel.png"
--theme.taglist_squares_unsel         = themes_dir .. "/icons/line_unsel.png"

-- | Taglist | --
theme.taglist_bg_empty = "png:" .. themes_dir .. "/icons/bg_unsel.png"
theme.taglist_bg_occupied = "png:" .. themes_dir .. "/icons/bg_unsel.png"
--theme.taglist_bg_urgent = themes_dir .. "/icons/urgent.png"
theme.taglist_bg_focus = "png:".. themes_dir .. "/icons/bg_sel_green.png"
theme.taglist_bg_urgent= "png:" .. themes_dir .. "/icons/bg_urgent.png"


theme.layout_uselesstile            = themes_dir .. "/icons/tile.png"
theme.layout_tilegaps               = themes_dir .. "/icons/tilegaps.png"
theme.layout_tileleft               = themes_dir .. "/icons/tileleft.png"
theme.layout_uselesstilebottom      = themes_dir .. "/icons/tilebottom.png"
theme.layout_tiletop                = themes_dir .. "/icons/tiletop.png"
theme.layout_uselesstilefairv       = themes_dir .. "/icons/fairv.png"
theme.layout_uselesstilefairh       = themes_dir .. "/icons/fairh.png"
theme.layout_uselesspiral                 = themes_dir .. "/icons/spiral.png"
theme.layout_uselessfair            =  themes_dir .. "/icons/tile.png"
theme.layout_centerwork             = "~/.config/awesome/lib/lain/icons/layout/default/centerworkw.png"
theme.layout_dwindle                = themes_dir .. "/icons/dwindle.png"
theme.layout_max                    = themes_dir .. "/icons/max.png"
theme.layout_fullscreen             = themes_dir .. "/icons/fullscreen.png"
theme.layout_magnifier              = themes_dir .. "/icons/magnifier.png"
theme.layout_floating               = themes_dir .. "/icons/floating.png"

theme.arrl                          = themes_dir .. "/icons/arrl.png"
theme.arrl_dl                       = themes_dir .. "/icons/arrl_dl.png"
theme.arrl_ld                       = themes_dir .. "/icons/arrl_ld.png"

theme.widget_ac                     = themes_dir .. "/icons/ac.png"
theme.widget_battery                = themes_dir .. "/icons/battery.png"
theme.widget_battery_low            = themes_dir .. "/icons/battery_low.png"
theme.widget_battery_empty          = themes_dir .. "/icons/battery_empty.png"
theme.widget_mem                    = themes_dir .. "/icons/mem.png"
theme.widget_cpu                    = themes_dir .. "/icons/cpu.png"
--theme.widget_temp                   = themes_dir .. "/icons/temp.png"
theme.widget_net                    = themes_dir .. "/icons/net.png"
theme.widget_hdd                    = themes_dir .. "/icons/hdd.png"
theme.widget_music                  = themes_dir .. "/icons/note.png"
theme.widget_music_on               = themes_dir .. "/icons/green_note_on.png"
theme.widget_vol                    = themes_dir .. "/icons/vol.png"
theme.widget_vol_low                = themes_dir .. "/icons/vol_low.png"
theme.micon_on                      = themes_dir .. "/icons/micon_on.png"
theme.micon_off                      = themes_dir .. "/icons/micon_off.png"
theme.widget_vol_no                 = themes_dir .. "/icons/vol_no.png"
theme.widget_vol_mute               = themes_dir .. "/icons/vol_mute.png"
theme.widget_mail                   = themes_dir .. "/icons/mail.png"
theme.widget_mail_on                = themes_dir .. "/icons/mail_on.png"

theme.tasklist_disable_icon         = true
theme.tasklist_floating             = ""
theme.tasklist_maximized_horizontal = ""
theme.tasklist_maximized_vertical   = ""

return theme

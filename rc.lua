--[[
                                             
     Random's green Awesome WM config 2.0 
     github.com/getzneet    
                                             
--]]

-- {{{ Required libraries
local gears     = require("gears")
local awful     = require("awful")
awful.rules     = require("awful.rules")
                  require("awful.autofocus")
local wibox     = require("wibox")
local beautiful = require("beautiful")
local naughty   = require("naughty")
local drop      = require("scratchdrop")
local lain      = require("lain")
local vicious   = require("vicious")
local leaved = require("awesome-leaved")

-- }}}

--- DEFAULT ICON SIZE

naughty.config.defaults.icon_size = 45 



-- {{{ Error handling
if awesome.startup_errors then
    naughty.notify({ preset = naughty.config.presets.critical,
                     title = "Oops, there were errors during startup!",
                     text = awesome.startup_errors })
end

do
    local in_error = false
    awesome.connect_signal("debug::error", function (err)
        if in_error then return end
        in_error = true

        naughty.notify({ preset = naughty.config.presets.critical,
                         title = "Oops, an error happened!",
                         text = err })
        in_error = false
    end)
end
-- }}}

-- {{{ Autostart applications
function run_once(cmd)
  findme = cmd
  firstspace = cmd:find(" ")
  if firstspace then
     findme = cmd:sub(0, firstspace-1)
  end
  awful.util.spawn_with_shell("pgrep -u $USER -x " .. findme .. " > /dev/null || (" .. cmd .. ")")
  awful.util.spawn_with_shell("compton") 
end
 -- launch the Cairo Composite Manager
awful.util.spawn_with_shell("compton") 
run_once("urxvtd -q -o -f")

--- Fix touchpad bug
run_once("synclient TapButton1=1")

--- launch clipboard
run_once("xfce4-clipman")

--- launch nm-applet 
run_once("nm-applet")
run_once("unclutter -root")
-- }}}

-- {{{ Variable definitions

-- beautiful init
beautiful.init(os.getenv("HOME") .. "/.config/awesome/themes/random/green_random.lua")

-- common
modkey     = "Mod4"
altkey     = "Mod1"
terminal   = "urxvtc" 
editor     = "gvim"
editor_cmd = terminal .. "sudo" .. editor

-- user defined

gui_editor = "gvim"
graphics   = "gimp"
mail       = terminal .. " -e mutt "
iptraf     = terminal .. " -g 180x54-20+34 -e sudo iptraf-ng -i all "
musicplr   = terminal .. " -g 130x34-320+16 -e ncmpcpp "
browser = "firefox"
midori = "midori"
light = "light"
thunar = "thunar"
komodo = "komodo"
steam = "steam"
taskmanager = "xfce4-taskmanager"
texmaker = "texmaker"
chromium = "chromium"
Tor = " /run/media/random/DATA/tor-browser_en-US/Browser/start-tor-browser --detach"
Mullvad = "/home/random/Python-exp/mullvad/ba.sh"
Messenger = "messengerfordesktop"
Djamradio =  "urxvt -e bash djam.sh"
vga_on = "xrandr --output VGA1 --auto --primary"  
vga_off = "xrandr --output VGA1 --off"
lvds_off = "xrandr --output LVDS1 --off"
lvds_on = "xrandr --output LVDS1 --auto --primary"
hdmi_off = "xrandr --output HDMI1 --off"
hdmi_on = "xrandr --output HDMI1 --auto --primary"
irssi = "urxvt -e /home/random/C_programs/irssi.sh"

local layouts = {
    awful.layout.suit.floating,
    lain.layout.uselessfair,
    --lain.layout.centerwork,
    
}
-- }}}

path = "/home/random/Téléchargements/"

-- {{{ Tags
tags = {
   names = { "  ", "  ", "  ", "  ", "  "},
   layout = { layouts[1], layouts[1], layouts[1], layouts[1], layouts[1] },
   icons = {path .. "chrome.png", path .. "coding.png",path .. "terminal-sign.png",path .. "folders.png",path .. "chrome.png"}

}


for s = 1, screen.count() do
   tags[s] = awful.tag(tags.names, s, tags.layout)
    --[[for i, t in ipairs(tags[s]) do]]
      --awful.tag.seticon(tags.icons[i], t)
      --awful.tag.setproperty(t, "icon_only", 1)
  --[[end]]
end 



-- }}}

-- {{{ Wallpaper
if beautiful.wallpaper then
    for s = 1, screen.count() do
        gears.wallpaper.maximized(beautiful.wallpaper, s, true)
    end
end

local new_shape = function(cr, width, height)
    gears.shape.radial_progress(cr, 70, 20, .3)
end



-- {{{ Menu

myawesomemenu = {
   { "> Manual", terminal .. " -e man awesome" },
   { "> Edit config", editor .. " " .. awesome.conffile },
   { "> Edit theme", "gvim /home/random/.config/awesome/themes/random/green_random.lua" },
   { "> Switch theme", "theme-switcher"}, 
   {"> Restart", awesome.restart },
   { "> Quit", awesome.quit },
   
}

used = {{"> gvim", gui_editor },
    {"> Firefox-light", light },
    {"> Chromium", chromium },
    {"> Tor", Tor },
    {"> Thunar", thunar },
    {"> Komodo", komodo },
    { "> Texmaker", texmaker},
    {"> Task-manager", taskmanager },
    {"> Mullid", Mullvad },
    {"> FB Messenger", Messenger },
    { "> Steam", steam},
    {"> Djam radio", Djamradio},
    {"> Irssi", irssi}}


system = {
   { "> Reboot", "reboot" },
   { "> Shutdown",  "./shutdown.sh"}}

screens =  {{ "> HDMI  = ON", hdmi_on},
    {"> HDMI  = OFF", hdmi_off },
    {"> VGA   = ON", vga_on},
    {"> VGA   = OFF", vga_off},
    { "> LVDS  = ON", lvds_on},
    {"> LVDS  = OFF", lvds_off}}

   
mymainmenu = awful.menu.new({ items = { require("menugen").build_menu(),  
{ "Awesome", myawesomemenu },                                       
{ "Screens", screens},{ "Programs", used },{"System", system}, { "Logout", "oblogout"}},
                        theme = { height = 16, width = 130 }})




-- {{{ Wibox
markup = lain.util.markup
separators = lain.util.separators

-- Textclock (with automatic launch of xflux to go easy on eyes at night + raspberry checker)
clockicon = wibox.widget.imagebox(beautiful.widget_clock)
--mytextclock = awful.widget.textclock(" %a %d %b  %H:%M")
 
mytextclock = lain.widgets.abase({
    timeout  = 30,
    cmd      = "date +'%a %d %b %R'",
    settings = function()
        widget:set_text(" " .. output)
        
        -- XFLUX LAUNCHER
        -- check if evening, then launch xflux
        str = string.match(output, "%d%d:")
        str = string.gsub(str, ":", "")
        if io.popen("pgrep xflux"):read() == nil then
                if tonumber(str) >= 20 or tonumber(str) <= 7 then
                    run_once("xflux -l 44.8351 -g  -0.5686")
        end     end
       
       -- RASPBERRY PI CHECKER
       --check if google.com is up, if it is, then it means that we are 
       --connected to the internet, thus we check if raspberry pi is up. 
       --[[if type(io.popen("curl --url http://google.com &"):read()) == "string" then]]
           --if type(io.popen("curl --url http://canal5.fr &"):read()) == "string" then
                --print("1")
           --else
                --io.popen("notify-send -i /home/random/.warning.png 'canal5.fr is down!'")
           --end 
       --else
            --print("0")
        --[[end]]
    end 
    
})




-- calendar
lain.widgets.calendar:attach(mytextclock, { font_size = 10 })



-- {{{ Voice commander

micon = wibox.widget.imagebox(beautiful.micon_off)
on_off = false
micon:buttons(awful.util.table.join(awful.button({ }, 1,
function () 
    on_off = not on_off
    if on_off == true then 
        io.popen("rm /home/random/Python/VoiceCommander/my_pid")
        run_once("speech")
        micon:set_image(beautiful.micon_on)
    else
        pid = io.popen("cat /home/random/Python/VoiceCommander/my_pid")
        for i in pid:lines() do 
            io.popen("kill " .. i)
        end
        micon:set_image(beautiful.micon_off)
    end
end  )))


-- Mail IMAP check

mailicon = wibox.widget.imagebox(beautiful.widget_mail)

--[[vicious.register(mailicon, vicious.widgets.gmail, function(widget, args)]]

    --local newMail = tonumber(args["{count}"])
    --if newMail == nil then
        --newMail = 0
    --end 
    --if newMail < 55555555 then
        --mailicon:set_image(beautiful.widget_mail)
    
    --else
        --mailicon:set_image(beautiful.widget_mail_on)
    --end
    
--[[end, 15)]]

-- to make GMail pop up when pressed:
mailicon:buttons(awful.util.table.join(awful.button({ }, 1,
function () awful.util.spawn_with_shell("chromium gmail.com") end)))

-- MPD / Cmus
mpdicon = wibox.widget.imagebox(beautiful.widget_music)
mpdicon:buttons(awful.util.table.join(awful.button({ }, 1, function () awful.util.spawn_with_shell(musicplr) end)))
mpdwidget = lain.widgets.mpd({
    settings = function()
        
        if mpd_now.state == "play" then
            artist = " " .. mpd_now.artist .. " "
            title  = mpd_now.title  .. " "
            mpdicon:set_image(beautiful.widget_music_on)
        elseif mpd_now.state == "pause" then
            artist = "paused"
            title  = "paused "
            mpdicon:set_image(beautiful.widget_music_on)

        else
            
            --if mpd is not running try to retrieve infos from cmus

            artist = io.popen("cmus-remote -Q | grep ' artist ' | cut -d ' ' -f3-"):read()
            --for line in artist:lines() do
                --artist = line
            --end 
            if type(artist) == "string" then 
                title= io.popen("cmus-remote -Q | grep title | cut -d ' ' -f3-"):read()
                mpdicon:set_image(beautiful.widget_music_on)
            
            else 
                artist = ""
                title  = ""
                mpdicon:set_image(beautiful.widget_music)
        end
        end

        widget:set_markup(markup(theme.fg_focus, artist))
    end
})

-- MEM
memicon = wibox.widget.imagebox(beautiful.widget_mem)
memwidget = lain.widgets.mem({
    settings = function()
        widget:set_text(" " .. mem_now.used .. "MB ")
    end
})

-- CPU
cpuicon = wibox.widget.imagebox(beautiful.widget_cpu)
cpuwidget = lain.widgets.cpu({
    settings = function()
        widget:set_text(" " .. cpu_now.usage .. "% ")
    end
})

--[[-- Coretemp]]
--tempicon = wibox.widget.imagebox(beautiful.widget_temp)
--tempwidget = lain.widgets.temp({
    --settings = function()
        --widget:set_text(" " .. coretemp_now .. "°C ")
    --end
--})


--/ Weather

--[[weather = lain.widgets.weather({]]
    --settings = function()
        --widget:set_text(" ".. weather_now.)

--myweather = lain.widgets.weather({
--city_id = 3621849, -- placeholder
--settings = function()
    --descr = weather_now["weather"][1]["description"]:lower()
    --units = math.floor(weather_now["main"]["temp"])
   --widget:set_markup(markup("#eca4c4", descr .. " @ " .. units .. "°C "))
--end
--[[})]]


-- / fs
fsicon = wibox.widget.imagebox(beautiful.widget_hdd)
fswidget = lain.widgets.fs({
    settings  = function()
        widget:set_text(" " .. fs_now.used .. "% ")
    end
})

-- Battery
baticon = wibox.widget.imagebox(beautiful.widget_battery)
batwidget = lain.widgets.bat({
    settings = function()
        if bat_now.perc == "N/A" then
            widget:set_markup(" AC ")
            baticon:set_image(beautiful.widget_ac)
            return
        elseif tonumber(bat_now.perc) <= 5 then
            baticon:set_image(beautiful.widget_battery_empty)
        elseif tonumber(bat_now.perc) <= 15 then
            baticon:set_image(beautiful.widget_battery_low)
        else
            baticon:set_image(beautiful.widget_battery)
        end
        widget:set_markup(" " .. bat_now.perc .. "% ")
    end
})

-- ALSA volume
volicon = wibox.widget.imagebox(beautiful.widget_vol)
volumewidget = lain.widgets.alsa({
    settings = function()
        
        if volume_now.status == "off" then
            volicon:set_image(beautiful.widget_vol_mute)
        elseif tonumber(volume_now.level) == 0 then
            volicon:set_image(beautiful.widget_vol_no)
        elseif tonumber(volume_now.level) <= 50 then
            volicon:set_image(beautiful.widget_vol_low)
        else
            volicon:set_image(beautiful.widget_vol)
        end

        widget:set_text(" " .. volume_now.level .. "% ")
    end
})

-- Net
nm_applet = "nm-applet"
neticon = wibox.widget.imagebox(beautiful.widget_net)
neticon:buttons(awful.util.table.join(awful.button({ }, 1, function () awful.util.spawn_with_shell(nm_applet) end)))
netwidget = lain.widgets.net({
    settings = function()
        widget:set_markup(markup("#B4B4B4", " " .. net_now.received)
                          .. " " ..
                          markup("#B4B4B4", " " .. net_now.sent .. " "))
    end
})



-- Manjaro icon

--myicon = wibox.widget.imagebox()
--myicon:set_image("/home/random/.config/awesome/themes/powerarrow-darker/icons/manjaro.png")
--[[--myicon:set_width(10)]]


-- Separators
spr = wibox.widget.textbox(' ')
--[[arrl:set_image(beautiful.arrl)]]
--arrl_dl = separators.arrow_left(beautiful.fg_focus, "alpha")
--arrl_ld = separators.arrow_left("alpha", beautiful.fg_focus)

-- Create a wibox for each screen and add it
mywibox = {}
mypromptbox = {}
mylayoutbox = {}
mytaglist = {}
mytaglist.buttons = awful.util.table.join(
                    awful.button({ }, 1, awful.tag.viewonly),
                    awful.button({ modkey }, 1, awful.client.movetotag),
                    awful.button({ }, 3, awful.tag.viewtoggle),
                    awful.button({ modkey }, 3, awful.client.toggletag),
                    awful.button({ }, 4, function(t) awful.tag.viewnext(awful.tag.getscreen(t)) end),
                    awful.button({ }, 5, function(t) awful.tag.viewprev(awful.tag.getscreen(t)) end)
                    )
mytasklist = {}
mytasklist.buttons = awful.util.table.join(
                     awful.button({ }, 1, function (c)
                                              if c == client.focus then
                                                  c.minimized = true
                                              else
                                                  -- Without this, the following
                                                  -- :isvisible() makes no sense
                                                  c.minimized = false
                                                  if not c:isvisible() then
                                                      awful.tag.viewonly(c:tags()[1])
                                                  end
                                                  -- This will also un-minimize
                                                  -- the client, if needed
                                                  client.focus = c
                                                  c:raise()
                                              end
                                          end),
                     awful.button({ }, 3, function ()
                                              if instance then
                                                  instance:hide()
                                                  instance = nil
                                              else
                                                  instance = awful.menu.clients({ width=250 })
                                              end
                                          end),
                     awful.button({ }, 4, function ()
                                              awful.client.focus.byidx(1)
                                              if client.focus then client.focus:raise() end
                                          end),
                     awful.button({ }, 5, function ()
                                              awful.client.focus.byidx(-1)
                                              if client.focus then client.focus:raise() end
                                          end))

for s = 1, screen.count() do

    -- Create a promptbox for each screen
    mypromptbox[s] = awful.widget.prompt()

    -- We need one layoutbox per screen.
    mylayoutbox[s] = awful.widget.layoutbox(s)
    mylayoutbox[s]:buttons(awful.util.table.join(
                            awful.button({ }, 1, function () awful.layout.inc(layouts, 1) end),
                            awful.button({ }, 3, function () awful.layout.inc(layouts, -1) end),
                            awful.button({ }, 4, function () awful.layout.inc(layouts, 1) end),
                            awful.button({ }, 5, function () awful.layout.inc(layouts, -1) end)))

    -- Create a taglist widget
    mytaglist[s] = awful.widget.taglist(s, awful.widget.taglist.filter.all, mytaglist.buttons)
    
    -- Create a tasklist widget
    mytasklist[s] = awful.widget.tasklist(s, awful.widget.tasklist.filter.currenttags, mytasklist.buttons)
    -- Screen padding
    --[[awful.screen.padding(screen[s],{top = 40})]]
    
    
    
    -- Create the wibox (retrieving screen width to adjust wibox's width) --
    
    used_screen = io.popen("xdpyinfo  | grep -Po '([0-9][0-9][0-9][0-9])x'", "r"):read()
    used_screen = string.gsub(used_screen, "x", "")
    used_screen = tonumber(used_screen)
    
    mywibox[s] = awful.wibox({ position = "top", screen = s, height = 18, width = used_screen - 25 })
    mywibox[s].x = 9 
    mywibox[s].border_color = beautiful.wibox_border_color
    mywibox[s].border_width = beautiful.wibox_border_width
    mywibox[s].opacity = 0.86 
    
    -- Widgets that are aligned to the upper left
    local left_layout = wibox.layout.fixed.horizontal()
    if s == 1 then left_layout:add(mytaglist[s]) left_layout:add(spr) end
    --left_layout:add(myicon)
    if s ~= 1 then left_layout:add(mytaglist[s]) end
    left_layout:add(mypromptbox[s])
    left_layout:add(spr)

    -- Widgets that are aligned to the upper right
    local right_layout_toggle = true
    local function right_layout_add (...)
        local arg = {...}
        if right_layout_toggle then
            right_layout:add(spr)

            for i, n in pairs(arg) do
                right_layout:add(wibox.widget.background(n , "#1A1A1A"))--beautiful.bg_focus))
            end
        else
            right_layout:add(spr)
            for i, n in pairs(arg) do
                right_layout:add(n)
            end
        end
        right_layout_toggle = not right_layout_toggle
    end

    right_layout = wibox.layout.fixed.horizontal()
    --right_layout:add(arrl)
    if s == 1 then right_layout:add(wibox.widget.systray()) end
    
    right_layout:add(spr)
    right_layout:add(micon)
    right_layout:add(spr)
    right_layout_add(mpdicon, mpdwidget)
    right_layout:add(spr)
    right_layout_add(volicon, volumewidget)
    right_layout:add(spr)
    right_layout_add(memicon, memwidget)
    right_layout:add(spr)
    right_layout_add(cpuicon, cpuwidget)
    right_layout:add(spr)
    --right_layout_add(tempicon, tempwidget)
    right_layout_add(fsicon, fswidget)
    right_layout:add(spr)
    right_layout_add(baticon, batwidget)
    right_layout:add(spr)
    --right_layout_add(mytextclock, spr)
    right_layout_add(mylayoutbox[s])

    -- Now bring it all together (with the tasklist in the middle)
    local layout = wibox.layout.align.horizontal()
    layout:set_left(left_layout)
    layout:set_middle(mytextclock, spr)
    layout:set_right(right_layout)
    mywibox[s]:set_widget(layout)

end
-- }}}

-- {{{ Mouse Bindings
root.buttons(awful.util.table.join(
    awful.button({ }, 3, function () mymainmenu:toggle() end),
    awful.button({ }, 4, awful.tag.viewnext),
    awful.button({ }, 5, awful.tag.viewprev)
))
-- }}}

-- {{{ Key bindings
globalkeys = awful.util.table.join(
    -- Take a screenshot
    -- https://github.com/copycat-killer/dots/blob/master/bin/screenshot
    awful.key({ altkey }, "p", function() os.execute("scrot") end),
    awful.key( {altkey }, "s", function() awful.util.spawn_with_shell("xfce4-screenshooter -r -s /home/random/screens/") end),
    awful.key( {altkey, "i" }, "s", function() awful.util.spawn_with_shell("xfce4-screenshooter -r -i") end),

    -- Tag browsing
    awful.key({ modkey }, "Left",   awful.tag.viewprev       ),
    awful.key({ modkey }, "Right",  awful.tag.viewnext       ),
    awful.key({ modkey }, "Escape", awful.tag.history.restore),

    -- Non-empty tag browsing
    --[[awful.key({ altkey }, "Left", function () lain.util.tag_view_nonempty(-1) end),]]
    --[[awful.key({ altkey }, "Right", function () lain.util.tag_view_nonempty(1) end),]]
    

    -- Awesome i3wm-like window organization
    awful.key({ modkey }, "o", leaved.keys.shiftOrder),



    -- Default client focus
    awful.key({ modkey }, "Tab",
        function ()
            awful.client.focus.byidx( 1)
            if client.focus then client.focus:raise() end
        end),
   --[[ awful.key({ altkey }, "s",]]
        --function ()
            --awful.client.focus.byidx(-1)
            --if client.focus then client.focus:raise() end
        --[[end),]]

    -- By direction client focus
    awful.key({ modkey }, "j",
        function()
            awful.client.focus.bydirection("down")
            if client.focus then client.focus:raise() end
        end),
    awful.key({ modkey }, "k",
        function()
            awful.client.focus.bydirection("up")
            if client.focus then client.focus:raise() end
        end),
    awful.key({ modkey }, "h",
        function()
            awful.client.focus.bydirection("left")
            if client.focus then client.focus:raise() end
        end),
    awful.key({ modkey }, "l",
        function()
            awful.client.focus.bydirection("right")
            if client.focus then client.focus:raise() end
        end),

    -- Show Menu
    awful.key({ modkey }, "w",
        function ()
            mymainmenu:show({ keygrabber = true })
        end),

    -- Show/Hide Wibox
    awful.key({ modkey }, "b", function ()
        mywibox[mouse.screen].visible = not mywibox[mouse.screen].visible
        
        for s = 1, screen.count() do

            mywibox[s].y = 4
        end
    end),

    -- Layout manipulation
    awful.key({ modkey, "Shift"   }, "j", function () awful.client.swap.byidx(  1)    end),
    awful.key({ modkey, "Shift"   }, "k", function () awful.client.swap.byidx( -1)    end),
    awful.key({ modkey, "Control" }, "j", function () awful.screen.focus_relative( 1) end),
    awful.key({ modkey, "Control" }, "k", function () awful.screen.focus_relative(-1) end),
    awful.key({ modkey,           }, "u", awful.client.urgent.jumpto),
    awful.key({ modkey,           }, "7896",
        function ()
            awful.client.focus.history.previous()
            if client.focus then
                client.focus:raise()
            end
        end),
    awful.key({ altkey, "Shift"   }, "l",      function () awful.tag.incmwfact( 2)     end),
    awful.key({ altkey, "Shift"   }, "h",      function () awful.tag.incmwfact(-2)     end),
    awful.key({ modkey, "Shift"   }, "l",      function () awful.tag.incnmaster(-1)       end),
    awful.key({ modkey, "Shift"   }, "h",      function () awful.tag.incnmaster( 1)       end),
    awful.key({ modkey, "Control" }, "l",      function () awful.tag.incncol(-1)          end),
    awful.key({ modkey, "Control" }, "h",      function () awful.tag.incncol( 1)          end),
    awful.key({ modkey,           }, "space",  function () awful.layout.inc(layouts,  1)  end),
    awful.key({ modkey, "Shift"   }, "space",  function () awful.layout.inc(layouts, -3)  end),
    awful.key({ modkey, "Control" }, "n",      awful.client.restore),
   

    awful.key({ modkey, altkey    }, "Right",     function () awful.tag.incmwfact(1)    end),
    awful.key({ modkey, altkey    }, "Left",     function () awful.tag.incmwfact(-1)    end),
    awful.key({ modkey, altkey   }, "Down",     function () awful.client.incwfact(1)    end),
    awful.key({ modkey, altkey    }, "Up",     function () awful.client.incwfact(-1)    end),
    -- On the fly useless gaps change
    awful.key({ altkey, "Control" }, "=", function () lain.util.useless_gaps_resize( 2) end),
    awful.key({ altkey, "Control" }, "-", function () lain.util.useless_gaps_resize(-2) end),
    -- Standard program
    awful.key({ modkey,           }, "Return", function () awful.util.spawn(terminal) end),
    awful.key({ modkey, "Control" }, "r",      awesome.restart),
    awful.key({ modkey, "Shift"   }, "q",      awesome.quit),

    -- Dropdown terminal
    awful.key({ modkey,	          }, "z",      function () awful.util.spawn(terminal) end),
    -- Dropdown file manager
    awful.key({ modkey,           }, "a",       function () awful.util.spawn(thunar) end),

    -- Widgets popups
    awful.key({ altkey,           }, "c",      function () lain.widgets.calendar:show(7) end),
    awful.key({ altkey,           }, "h",      function () fswidget.show(7) end),
    
    -- Dropdown irssi
    awful.key({ modkey,          }, "i",     function () awful.util.spawn(irssi) end),
    
    -- ALSA volume control
    awful.key({ altkey }, "Up",
        function ()
            os.execute(string.format("amixer set %s 1%%+", volumewidget.channel))
            volumewidget.update()
        end),
    awful.key({ altkey }, "Down",
        function ()
            os.execute(string.format("amixer set %s 1%%-", volumewidget.channel))
            volumewidget.update()
        end),
    awful.key({ altkey }, "m",
        function ()
            os.execute(string.format("amixer set %s toggle", volumewidget.channel))
            volumewidget.update()
        end),
    awful.key({ altkey, "Control" }, "m",
        function ()
            os.execute(string.format("amixer set %s 100%%", volumewidget.channel))
            volumewidget.update()
        end),

    -- MPD control
    awful.key({ altkey, "Control" }, "Up",
        function ()
            awful.util.spawn_with_shell("mpc toggle || ncmpc toggle || pms toggle")
            mpdwidget.update()
        end),
    awful.key({ altkey, "Control" }, "Down",
        function ()
            awful.util.spawn_with_shell("mpc stop || ncmpc stop || pms stop")
            mpdwidget.update()
        end),
    awful.key({ altkey, "Control" }, "Left",
        function ()
            awful.util.spawn_with_shell("mpc prev || ncmpc prev || pms prev")
            mpdwidget.update()
        end),
    awful.key({ altkey, "Control" }, "Right",
        function ()
            awful.util.spawn_with_shell("mpc next || ncmpc next || pms next")
            mpdwidget.update()
        end),

    -- Copy to clipboard
    awful.key({altkey, modkey}, "c", function () awful.util.spawn("xsel -p -o | xsel -i -b") end),

    -- User programs
    awful.key({ modkey }, "q", function () awful.util.spawn(browser) end),
    awful.key({ modkey }, "i", function () awful.util.spawn(browser2) end),
    awful.key({ modkey }, "s", function () awful.util.spawn(gui_editor) end),
    awful.key({ modkey }, "g", function () awful.util.spawn(graphics) end),
    awful.key({ modkey }, "l", function () awful.util.spawn("urxvtc -e speech")
                                end), 
    
    awful.key({ modkey }, "y", function () awful.util.spawn("xfce4-terminal") end),

    -- Prompt
    awful.key({ modkey }, "r", function () awful.util.spawn('rofi -show run -fg "#B0E670" -hlbg "#B0E670" \
                                                            --lines 3 -location 0 -yoffset -100') end))
    --awful.key({ modkey }, "Tab", function () awful.util.spawn("rofi -show window") end), 
    --awful.key({ modkey }, "r", function () mypromptbox[mouse.screen]:run() end),
    --[[awful.key({ modkey }, "x",]]
              --function ()
                  --awful.prompt.run({ prompt = "Run Lua code: " },
                  --mypromptbox[mouse.screen].widget,
                  --awful.util.eval, nil,
                  --awful.util.getdir("cache") .. "/history_eval")


clientkeys = awful.util.table.join(
    awful.key({ modkey,           }, "f",      function (c) c.fullscreen = not c.fullscreen  end),
    awful.key({ modkey,          }, "c",      function (c) c:kill()                         end),

    awful.key({ modkey, "Control" }, "space",  awful.client.floating.toggle                     ),
    awful.key({ modkey, "Control" }, "Return", function (c) c:swap(awful.client.getmaster()) end),
    awful.key({ modkey,           }, "o",      awful.client.movetoscreen                        ),
    awful.key({ modkey,           }, "t",      function (c) c.ontop = not c.ontop            end),
    awful.key({ modkey,           }, "n",
        function (c)
            -- The client currently has the input focus, so it cannot be
            -- minimized, since minimized clients can't have the focus.
            c.minimized = true
        end),
    awful.key({ modkey,           }, "m",
        function (c)
            c.maximized_horizontal = not c.maximized_horizontal
            c.maximized_vertical   = not c.maximized_vertical
        end)
)

-- Bind all key numbers to tags.
-- be careful: we use keycodes to make it works on any keyboard layout.
-- This should map on the top row of your keyboard, usually 1 to 9.
for i = 1, 9 do
    globalkeys = awful.util.table.join(globalkeys,
        -- View tag only.
        awful.key({ modkey }, "#" .. i + 9,
                  function ()
                        local screen = mouse.screen
                        local tag = awful.tag.gettags(screen)[i]
                        if tag then
                           awful.tag.viewonly(tag)
                        end
                  end),
        -- Toggle tag.
        awful.key({ modkey, "Control" }, "#" .. i + 9,
                  function ()
                      local screen = mouse.screen
                      local tag = awful.tag.gettags(screen)[i]
                      if tag then
                         awful.tag.viewtoggle(tag)
                      end
                  end),
        -- Move client to tag.
        awful.key({ modkey, "Shift" }, "#" .. i + 9,
                  function ()
                      if client.focus then
                          local tag = awful.tag.gettags(client.focus.screen)[i]
                          if tag then
                              awful.client.movetotag(tag)
                          end
                     end
                  end),
        -- Toggle tag.
        awful.key({ modkey, "Control", "Shift" }, "#" .. i + 9,
                  function ()
                      if client.focus then
                          local tag = awful.tag.gettags(client.focus.screen)[i]
                          if tag then
                              awful.client.toggletag(tag)
                          end
                      end
                  end))
end

clientbuttons = awful.util.table.join(
    awful.button({ }, 1, function (c) client.focus = c; c:raise() end),
    awful.button({ modkey }, 1, awful.mouse.client.move),
    awful.button({ modkey }, 3, awful.mouse.client.resize))

-- Set keys
root.keys(globalkeys)
-- }}}




-- {{{ Rules
awful.rules.rules = {
    -- All clients will match this rule.
    { rule = {},
      properties = { border_width = beautiful.border_width,
                     border_color = beautiful.border_normal,
                     focus = awful.client.focus.filter,
                     keys = clientkeys,
                     buttons = clientbuttons,
	                   size_hints_honor = false } },
    { rule = { class = "URxvt" },
          properties = { opacity = 0.99 } },

    { rule = { class = "Oblogout" },
          properties = {    fullscreen = true
                             } },

    { rule = { instance = "plugin-container" },
          properties = { tag = tags[1][1] } },

     { rule = {class = "Firefox"},
          properties = { tag = tags[1][1] } },


    { rule = { class = "Gimp", role = "gimp-image-window" },
          properties = { maximized_horizontal = true,
                         maximized_vertical = true } },
}
-- }}}

-- {{{ Signals
-- signal funtion to execute when a new client appears.
local sloppyfocus_last = {c=nil}
client.connect_signal("manage", function (c, startup)
    
    awful.placement.centered(c)
    awful.placement.no_overlap(c)
    awful.placement.no_offscreen(c)
    -- Enable sloppy focus
    client.connect_signal("mouse::enter", function(c)
         if awful.layout.get(c.screen) ~= awful.layout.suit.magnifier
            and awful.client.focus.filter(c) then
             -- Skip focusing the client if the mouse wasn't moved.
             if c ~= sloppyfocus_last.c then
                 client.focus = c
                 sloppyfocus_last.c = c
                 
             end
         
         end
     end)

    local titlebars_enabled = false
    if titlebars_enabled and (c.type == "normal" or c.type == "dialog") then
        -- buttons for the titlebar
        local buttons = awful.util.table.join(
                awful.button({ }, 1, function()
                    client.focus = c
                    c:raise()
                    awful.mouse.client.move(c)
                end),
                awful.button({ }, 3, function()
                    client.focus = c
                    c:raise()
                    awful.mouse.client.resize(c)
                end)
                )

        -- widgets that are aligned to the right
        local right_layout = wibox.layout.fixed.horizontal()
        right_layout:add(awful.titlebar.widget.floatingbutton(c))
        right_layout:add(awful.titlebar.widget.maximizedbutton(c))
        right_layout:add(awful.titlebar.widget.stickybutton(c))
        right_layout:add(awful.titlebar.widget.ontopbutton(c))
        right_layout:add(awful.titlebar.widget.closebutton(c))

        -- the title goes in the middle
        local middle_layout = wibox.layout.flex.horizontal()
        local title = awful.titlebar.widget.titlewidget(c)
        title:set_align("center")
        middle_layout:add(title)
        middle_layout:buttons(buttons)

        -- now bring it all together
        local layout = wibox.layout.align.horizontal()
        layout:set_right(right_layout)
        layout:set_middle(middle_layout)

        awful.titlebar(c,{size=16}):set_widget(layout)
    end
end)

-- No border for maximized clients
client.connect_signal("focus",
    function(c)
        if c.maximized_horizontal == true and c.maximized_vertical == true then
            c.border_color = beautiful.border_focus
            
        else
            c.border_color = beautiful.border_focus
        end
    end)
client.connect_signal("unfocus", function(c) c.border_color = beautiful.border_normal end)
-- 
-- {{{ Arrange signal handler
for s = 1, screen.count() do screen[s]:connect_signal("arrange", function ()
        local clients = awful.client.visible(s)
        local layout  = awful.layout.getname(awful.layout.get(s))

        if #clients > 0 then -- Fine grained borders and floaters control
            for _, c in pairs(clients) do -- Floaters always have borders
                if awful.client.floating.get(c) or layout == "floating" then
                    c.border_width = beautiful.border_width

                -- No borders with only one visible client
                elseif #clients == 1 or layout == "max" then
                    c.border_width = beautiful.border_width

                else
                    c.border_width = beautiful.border_width
                end
            end
        end
      end)
end
-- }}}

local bottom_layout = wibox.layout.fixed.horizontal()

wibox = {}

--{ Moar wibox settings]]
for s = 1, screen.count() do
    mywibox[s].y = 6
    --wibox[s].y = 735
    --wibox[s].x = 635
    --bottom_layout:add(mytaglist[s])
    awful.screen.padding(screen[s],{top = 10})
    --awful.titlebar(c,{size=16}):set_widget(bottom_layout)
    --awflul.screen.padding(screen[s], {right = 5})
end

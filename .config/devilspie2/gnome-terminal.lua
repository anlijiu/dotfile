-- debug_print command does only print anything to stdout
-- if devilspie2 is run using the --debug option
debug_print("Window Name: " .. get_window_name());
debug_print("Application name: " .. get_application_name())
 
-- I want my Xfce4-terminal to the right on the second screen of my two-monitor
-- setup. (Strings are case sensitive, please note this when creating rule
-- scripts.)
if (get_window_name()=="Terminal") then
   -- x,y, xsize, ysize
   -- set_window_geometry(1600,300,900,700);
   set_window_opacity(0.5);
end

if (get_application_name() == "终端") then
    set_window_opacity(0.85)
    set_window_size(1000, 650)
    center()
end

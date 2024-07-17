--[[
Ring Meters by londonali1010 (2009)

This script draws percentage meters as rings. It is fully customisable; all options are described in the script.

IMPORTANT: if you are using the 'cpu' function, it will cause a segmentation fault if it tries to draw a ring straight away. The if statement on line 145 uses a delay to make sure that this doesn't happen. It calculates the length of the delay by the number of updates since Conky started. Generally, a value of 5s is long enough, so if you update Conky every 1s, use update_num > 5 in that if statement (the default). If you only update Conky every 2s, you should change it to update_num > 3; conversely if you update Conky every 0.5s, you should use update_num > 10. ALSO, if you change your Conky, is it best to use "killall conky; conky" to update it, otherwise the update_num will not be reset and you will get an error.

To call this script in Conky, use the following (assuming that you save this script to ~/scripts/rings.lua):
lua_load ~/scripts/rings-v1.2.1.lua
lua_draw_hook_pre ring_stats

Changelog:
+ v1.2.1 -- Fixed minor bug that caused script to crash if conky_parse() returns a nil value (20.10.2009)
+ v1.2 -- Added option for the ending angle of the rings (07.10.2009)
+ v1.1 -- Added options for the starting angle of the rings, and added the "max" variable, to allow for variables that output a numerical value rather than a percentage (29.09.2009)
+ v1.0 -- Original release (28.09.2009)
]]
--===================================================================================================================================================================================

-- "clock_x" and "clock_y" are the coordinates of the centre of the clock, in pixels, from the top left of the Conky window.
--
clock_x=100
clock_y=180
-- Use these settings to define the origin and extent of your clock.
--
clock_r=90

cpu_x=100
cpu_y=732

battery_x=420
battery_y=725

disk_x=270
disk_y=730

settings_table = {
    {
        name="time", arg="%I", max=12,
        bg_colour=0xffffff, bg_alpha=.1,
        fg_colour=0x7FFF4F, fg_alpha=0.6,
        x=clock_x, y=clock_y,
        radius=72, thickness=3,
        start_angle=0, end_angle=360
    },
    {
        name="time", arg="%M", max=60,
        bg_colour=0xffffff, bg_alpha=0.1,
        fg_colour=0x0097AD, fg_alpha=0.6,
        x=clock_x, y=clock_y,
        radius=81, thickness=3,
        start_angle=0, end_angle=360
    },
    {
        name="time",  arg="%S", max=60,
        bg_colour=0xffffff, bg_alpha=0.1,
        fg_colour=0xFF6565, fg_alpha=0.6,
        x=clock_x, y=clock_y,
        radius=90, thickness=3,
        start_angle=0, end_angle=360
    },
    {
        name="eval",  arg="1", max=1,
        bg_colour=0xEEEEEE, bg_alpha=1,
        fg_colour=0xEEEEEE, fg_alpha=1,
        x=clock_x, y=clock_y,
        radius=1, thickness=7,
        start_angle=0, end_angle=360
    },
}

settings_bars = {
    {
	    name='diskio_read',		--Conky var.
		arg='/dev/sda',			--Conky arg.
		max=5000000,			--Max return value. (Here set for a value that makes the diskio bar jumpy. If the ret. value is greater than max, the bar will show 100%.)
		bg_colour=0xF4753E,		--Bar bg.
		bg_alpha=0.4,			--Bg alpha.
		fg_colour=0xF4CA3E,		--Bar fg.
		fg_alpha=0.8,			--Fg alpha.
		x=200, y=190,			--Starting point of the bar. (In pixels)
		length=100,			--Length of the bar. (In pixels.)
		thickness=6,			--Thickness of the bar.
		angle=-math.pi/4		--Angle of the bar. (In radians from horizontal. A negative angle rotates the bar CCW.)
	},
	{
		name='diskio_write',
		arg='/dev/sda',
		max=5000000,
		bg_colour=0xF4753E,
		bg_alpha=0.4,
		fg_colour=0xFF453E,
		fg_alpha=0.8,
		x=390, y=90,
		length=100,
		thickness=6,
		angle=-math.pi/4
	},
	{
		name='diskio_read',
		arg='/dev/sdb',
		max=5000000,
		bg_colour=0xF4753E,
		bg_alpha=0.4,
		fg_colour=0xF4CA3E,
		fg_alpha=0.8,
		x=370, y=90,
		length=100,
		thickness=6,
		angle=-math.pi/4
	},
	{
		name='diskio_write',
		arg='/dev/sdb',
		max=5000000,
		bg_colour=0xF4753E,
		bg_alpha=0.4,
		fg_colour=0xFF453E,
		fg_alpha=0.8,
		x=360, y=90,
		length=100,
		thickness=6,
		angle=-math.pi/4
	},
	{
		name='diskio_read',
		arg='/dev/sdc',
		max=1000000,
		bg_colour=0xF4753E,
		bg_alpha=0.4,
		fg_colour=0xF4CA3E,
		fg_alpha=0.8,
		x=340, y=90,
		length=100,
		thickness=6,
		angle=-math.pi/4
	},
	{
		name='diskio_write',
		arg='/dev/sdc',
		max=1000000,
		bg_colour=0xF4753E,
		bg_alpha=0.4,
		fg_colour=0xFF453E,
		fg_alpha=0.8,
		x=330, y=90,
		length=100,
		thickness=6,
		angle=-math.pi/4
	},
}

gauge = {
{
    name='cpu',                    arg='cpu1',                  max_value=100,
    x=cpu_x,                       y=cpu_y,
    graph_radius=90,
    graph_thickness=5,
    graph_start_angle=180,
    graph_unit_angle=2.7,          graph_unit_thickness=2.7,
    graph_bg_colour=0xffffff,      graph_bg_alpha=0.1,
    graph_fg_colour=0xFFFFFF,      graph_fg_alpha=0.3,
    hand_fg_colour=0xEF5A29,       hand_fg_alpha=1.0,
    txt_radius=0,
    txt_weight=0,                  txt_size=9.0,
    txt_fg_colour=0xEF5A29,        txt_fg_alpha=1.0,
    graduation_radius=28,
    graduation_thickness=0,        graduation_mark_thickness=1,
    graduation_unit_angle=27,
    graduation_fg_colour=0xFFFFFF, graduation_fg_alpha=0.3,
    caption='',
    caption_weight=1,              caption_size=9.0,
    caption_fg_colour=0xFFFFFF,    caption_fg_alpha=0.3,
},
{
    name='cpu',                    arg='cpu2',                  max_value=100,
    x=cpu_x,                       y=cpu_y,
    graph_radius=83,
    graph_thickness=5,
    graph_start_angle=180,
    graph_unit_angle=2.7,          graph_unit_thickness=2.7,
    graph_bg_colour=0xffffff,      graph_bg_alpha=0.1,
    graph_fg_colour=0xFFFFFF,      graph_fg_alpha=0.3,
    hand_fg_colour=0xEF5A29,       hand_fg_alpha=1.0,
    txt_radius=0,
    txt_weight=0,                  txt_size=9.0,
    txt_fg_colour=0xEF5A29,        txt_fg_alpha=1.0,
    graduation_radius=28,
    graduation_thickness=0,        graduation_mark_thickness=1,
    graduation_unit_angle=27,
    graduation_fg_colour=0xFFFFFF, graduation_fg_alpha=0.3,
    caption='',
    caption_weight=1,              caption_size=9.0,
    caption_fg_colour=0xFFFFFF,    caption_fg_alpha=0.3,
},
{
    name='cpu',                    arg='cpu3',                  max_value=100,
    x=cpu_x,                       y=cpu_y,
    graph_radius=76,
    graph_thickness=5,
    graph_start_angle=180,
    graph_unit_angle=2.7,          graph_unit_thickness=2.7,
    graph_bg_colour=0xffffff,      graph_bg_alpha=0.1,
    graph_fg_colour=0xFFFFFF,      graph_fg_alpha=0.3,
    hand_fg_colour=0xEF5A29,       hand_fg_alpha=1.0,
    txt_radius=0,
    txt_weight=0,                  txt_size=9.0,
    txt_fg_colour=0xEF5A29,        txt_fg_alpha=1.0,
    graduation_radius=28,
    graduation_thickness=0,        graduation_mark_thickness=1,
    graduation_unit_angle=27,
    graduation_fg_colour=0xFFFFFF, graduation_fg_alpha=0.3,
    caption='',
    caption_weight=1,              caption_size=9.0,
    caption_fg_colour=0xFFFFFF,    caption_fg_alpha=0.3,
},
{
    name='cpu',                    arg='cpu4',                  max_value=100,
    x=cpu_x,                       y=cpu_y,
    graph_radius=69,
    graph_thickness=5,
    graph_start_angle=180,
    graph_unit_angle=2.7,          graph_unit_thickness=2.7,
    graph_bg_colour=0xffffff,      graph_bg_alpha=0.1,
    graph_fg_colour=0xFFFFFF,      graph_fg_alpha=0.3,
    hand_fg_colour=0xEF5A29,       hand_fg_alpha=1.0,
    txt_radius=0,
    txt_weight=0,                  txt_size=9.0,
    txt_fg_colour=0xEF5A29,        txt_fg_alpha=1.0,
    graduation_radius=28,
    graduation_thickness=0,        graduation_mark_thickness=1,
    graduation_unit_angle=27,
    graduation_fg_colour=0xFFFFFF, graduation_fg_alpha=0.3,
    caption='',
    caption_weight=1,              caption_size=9.0,
    caption_fg_colour=0xFFFFFF,    caption_fg_alpha=0.3,
},
{
    name='cpu',                    arg='cpu5',                  max_value=100,
    x=cpu_x,                       y=cpu_y,
    graph_radius=62,
    graph_thickness=5,
    graph_start_angle=180,
    graph_unit_angle=2.7,          graph_unit_thickness=2.7,
    graph_bg_colour=0xffffff,      graph_bg_alpha=0.1,
    graph_fg_colour=0xFFFFFF,      graph_fg_alpha=0.3,
    hand_fg_colour=0xEF5A29,       hand_fg_alpha=1.0,
    txt_radius=0,
    txt_weight=0,                  txt_size=9.0,
    txt_fg_colour=0xEF5A29,        txt_fg_alpha=1.0,
    graduation_radius=28,
    graduation_thickness=0,        graduation_mark_thickness=1,
    graduation_unit_angle=27,
    graduation_fg_colour=0xFFFFFF, graduation_fg_alpha=0.3,
    caption='',
    caption_weight=1,              caption_size=9.0,
    caption_fg_colour=0xFFFFFF,    caption_fg_alpha=0.3,
},
{
    name='cpu',                    arg='cpu6',                  max_value=100,
    x=cpu_x,                       y=cpu_y,
    graph_radius=55,
    graph_thickness=5,
    graph_start_angle=180,
    graph_unit_angle=2.7,          graph_unit_thickness=2.7,
    graph_bg_colour=0xffffff,      graph_bg_alpha=0.1,
    graph_fg_colour=0xFFFFFF,      graph_fg_alpha=0.3,
    hand_fg_colour=0xEF5A29,       hand_fg_alpha=1.0,
    txt_radius=0,
    txt_weight=0,                  txt_size=9.0,
    txt_fg_colour=0xEF5A29,        txt_fg_alpha=1.0,
    graduation_radius=28,
    graduation_thickness=0,        graduation_mark_thickness=1,
    graduation_unit_angle=27,
    graduation_fg_colour=0xFFFFFF, graduation_fg_alpha=0.3,
    caption='',
    caption_weight=1,              caption_size=9.0,
    caption_fg_colour=0xFFFFFF,    caption_fg_alpha=0.3,
},
{
    name='cpu',                    arg='cpu7',                  max_value=100,
    x=cpu_x,                       y=cpu_y,
    graph_radius=48,
    graph_thickness=5,
    graph_start_angle=180,
    graph_unit_angle=2.7,          graph_unit_thickness=2.7,
    graph_bg_colour=0xffffff,      graph_bg_alpha=0.1,
    graph_fg_colour=0xFFFFFF,      graph_fg_alpha=0.3,
    hand_fg_colour=0xEF5A29,       hand_fg_alpha=1.0,
    txt_radius=0,
    txt_weight=0,                  txt_size=9.0,
    txt_fg_colour=0xEF5A29,        txt_fg_alpha=1.0,
    graduation_radius=28,
    graduation_thickness=0,        graduation_mark_thickness=1,
    graduation_unit_angle=27,
    graduation_fg_colour=0xFFFFFF, graduation_fg_alpha=0.3,
    caption='',
    caption_weight=1,              caption_size=9.0,
    caption_fg_colour=0xFFFFFF,    caption_fg_alpha=0.3,
},
{
    name='cpu',                    arg='cpu8',                  max_value=100,
    x=cpu_x,                       y=cpu_y,
    graph_radius=41,
    graph_thickness=5,
    graph_start_angle=180,
    graph_unit_angle=2.7,          graph_unit_thickness=2.7,
    graph_bg_colour=0xffffff,      graph_bg_alpha=0.1,
    graph_fg_colour=0xFFFFFF,      graph_fg_alpha=0.3,
    hand_fg_colour=0xEF5A29,       hand_fg_alpha=1.0,
    txt_radius=0,
    txt_weight=0,                  txt_size=9.0,
    txt_fg_colour=0xEF5A29,        txt_fg_alpha=1.0,
    graduation_radius=28,
    graduation_thickness=0,        graduation_mark_thickness=1,
    graduation_unit_angle=27,
    graduation_fg_colour=0xFFFFFF, graduation_fg_alpha=0.3,
    caption='',
    caption_weight=1,              caption_size=9.0,
    caption_fg_colour=0xFFFFFF,    caption_fg_alpha=0.3,
},
{
    name='fs_used_perc',           arg='/',                     max_value=100,
    x=disk_x,                      y=disk_y,
    graph_radius=64,
    graph_thickness=7,
    graph_start_angle=180,
    graph_unit_angle=2.7,          graph_unit_thickness=2.7,
    graph_bg_colour=0xffffff,      graph_bg_alpha=0.1,
    graph_fg_colour=0xFFFFFF,      graph_fg_alpha=0.3,
    hand_fg_colour=0xEF5A29,       hand_fg_alpha=1.0,
    txt_radius=76,
    txt_weight=0,                  txt_size=13.0,
    txt_fg_colour=0xEF5A29,        txt_fg_alpha=1.0,
    graduation_radius=23,
    graduation_thickness=0,        graduation_mark_thickness=2,
    graduation_unit_angle=27,
    graduation_fg_colour=0xFFFFFF, graduation_fg_alpha=0.3,
    caption='Root',
    caption_weight=1,              caption_size=12.0,
    caption_fg_colour=0xFFFFFF,    caption_fg_alpha=0.5,
},
{
    name='fs_used_perc',           arg='/home/an/',                     max_value=100,
    x=disk_x,                      y=disk_y,
    graph_radius=53,
    graph_thickness=7,
    graph_start_angle=180,
    graph_unit_angle=2.7,          graph_unit_thickness=2.7,
    graph_bg_colour=0xffffff,      graph_bg_alpha=0.1,
    graph_fg_colour=0xFFFFFF,      graph_fg_alpha=0.3,
    hand_fg_colour=0xEF5A29,       hand_fg_alpha=1.0,
    txt_radius=43,
    txt_weight=0,                  txt_size=13.0,
    txt_fg_colour=0xEF5A29,        txt_fg_alpha=1.0,
    graduation_radius=23,
    graduation_thickness=0,        graduation_mark_thickness=2,
    graduation_unit_angle=27,
    graduation_fg_colour=0xFFFFFF, graduation_fg_alpha=0.3,
    caption='Home',
    caption_weight=1,              caption_size=12.0,
    caption_fg_colour=0xFFFFFF,    caption_fg_alpha=0.5,
},
{
    name='memperc',                arg='',                      max_value=100,
    x=battery_x,                   y=battery_y,
    graph_radius=42,
    graph_thickness=7,
    graph_start_angle=180,
    graph_unit_angle=2.7,          graph_unit_thickness=2.7,
    graph_bg_colour=0xffffff,      graph_bg_alpha=0.1,
    graph_fg_colour=0x7FFF4F,      graph_fg_alpha=0.3,
    hand_fg_colour=0xEF5A29,       hand_fg_alpha=1.0,
    txt_radius=25,
    txt_weight=0,                  txt_size=16.0,
    txt_fg_colour=0xEF5A29,        txt_fg_alpha=1.0,
    graduation_radius=23,
    graduation_thickness=0,        graduation_mark_thickness=2,
    graduation_unit_angle=27,
    graduation_fg_colour=0xFFFFFF, graduation_fg_alpha=0.5,
    caption='Memory',
    caption_weight=1,              caption_size=12.0,
    caption_fg_colour=0x7FFF4F,    caption_fg_alpha=0.5,
},
{
    name='battery_percent',        arg='BAT0',                     max_value=100,
    x=battery_x,                   y=battery_y,
    graph_radius=53,
    graph_thickness=7,
    graph_start_angle=180,
    graph_unit_angle=2.7,          graph_unit_thickness=2.7,
    graph_bg_colour=0xffffff,      graph_bg_alpha=0.1,
    graph_fg_colour=0xFFFFFF,      graph_fg_alpha=0.3,
    hand_fg_colour=0xEF5A29,       hand_fg_alpha=1.0,
    txt_radius=43,
    txt_weight=0,                  txt_size=13.0,
    txt_fg_colour=0xEF5A29,        txt_fg_alpha=1.0,
    graduation_radius=23,
    graduation_thickness=0,        graduation_mark_thickness=2,
    graduation_unit_angle=27,
    graduation_fg_colour=0xFFFFFF, graduation_fg_alpha=0.3,
    caption='Battery',
    caption_weight=1,              caption_size=12.0,
    caption_fg_colour=0xFFFFFF,    caption_fg_alpha=0.5,
}
}

-----------------------------------------------------------------------------------------------------------------
--
--
--
-- Colour & alpha of the clock hands
--
hour_colour=0x7FFF4F
minute_colour=0x0097AD
second_colour=0xFF6565
clock_alpha=0.6
--
-- Do you want to show the seconds hand?
--
show_seconds=true
--
--===============================================================================================================
----------------
require 'cairo'
require 'cairo_xlib'
----------------
function rgb_to_r_g_b(colour,alpha)
    return ((colour / 0x10000) % 0x100) / 255., ((colour / 0x100) % 0x100) / 255., (colour % 0x100) / 255., alpha
end

function draw_ring(cr,t,pt)
    local w,h=conky_window.width,conky_window.height
    local xc,yc,ring_r,ring_w,sa,ea=pt['x'],pt['y'],pt['radius'],pt['thickness'],pt['start_angle'],pt['end_angle']
    local bgc, bga, fgc, fga=pt['bg_colour'], pt['bg_alpha'], pt['fg_colour'], pt['fg_alpha']
    local angle_0=sa*(2*math.pi/360)-math.pi/2
    local angle_f=ea*(2*math.pi/360)-math.pi/2
    local t_arc=t*(angle_f-angle_0)

    -- Draw background ring

    cairo_arc(cr,xc,yc,ring_r,angle_0,angle_f)
    cairo_set_source_rgba(cr,rgb_to_r_g_b(bgc,bga))
    cairo_set_line_width(cr,ring_w)
    cairo_stroke(cr)

    -- Draw indicator ring

    cairo_arc(cr,xc,yc,ring_r,angle_0,angle_0+t_arc)
    cairo_set_source_rgba(cr,rgb_to_r_g_b(fgc,fga))
    cairo_stroke(cr)        
end

function draw_bar(cr,t,pt)
	local w,h=conky_window.width,conky_window.height
	
	local xc,yc,bar_a,bar_w,bar_len=pt['x'],pt['y'],pt['angle'],pt['thickness'],pt['length']
	local bgc, bga, fgc, fga=pt['bg_colour'], pt['bg_alpha'], pt['fg_colour'], pt['fg_alpha']

	local t_len=t*bar_len
	local enx,eny=xc+bar_len*math.cos(bar_a),yc+bar_len*math.sin(bar_a)
	local enxi,enyi=xc+t_len*math.cos(bar_a),yc+t_len*math.sin(bar_a)


	-- Draw background bar

	cairo_move_to(cr, xc, yc)
	cairo_set_source_rgba(cr,rgb_to_r_g_b(bgc,bga))
	cairo_set_line_width(cr,bar_w)
	cairo_line_to(cr, enx, eny)
	cairo_stroke(cr)

	-- Draw indicator bar

	cairo_move_to(cr, xc, yc)
	cairo_set_source_rgba(cr,rgb_to_r_g_b(fgc,fga))
	cairo_line_to(cr, enxi, enyi)
	cairo_stroke(cr)
	
end

-- Draw clock hands

function draw_clock_hands(cr,xc,yc)
    local secs,mins,hours,secs_arc,mins_arc,hours_arc
    local xh,yh,xm,ym,xs,ys

    secs=os.date("%S")	
    mins=os.date("%M")
    hours=os.date("%I")

    secs_arc=(2*math.pi/60)*secs
    mins_arc=(2*math.pi/60)*mins+secs_arc/60/60
    hours_arc=(2*math.pi/12)*hours+mins_arc/60

    -- Draw hour hand

    xh=xc+0.7*clock_r*math.sin(hours_arc)
    yh=yc-0.7*clock_r*math.cos(hours_arc)
    cairo_move_to(cr,xc,yc)
    cairo_line_to(cr,xh,yh)

    cairo_set_line_cap(cr,CAIRO_LINE_CAP_ROUND)
    cairo_set_line_width(cr,4)
    cairo_set_source_rgba(cr,rgb_to_r_g_b(hour_colour,clock_alpha))
    cairo_stroke(cr)

    -- Draw minute hand

    xm=xc+0.86*clock_r*math.sin(mins_arc)
    ym=yc-0.86*clock_r*math.cos(mins_arc)
    cairo_move_to(cr,xc,yc)
    cairo_line_to(cr,xm,ym)

    cairo_set_line_cap(cr,CAIRO_LINE_CAP_ROUND)
    cairo_set_line_width(cr,2.5)
    cairo_set_source_rgba(cr,rgb_to_r_g_b(minute_colour,clock_alpha))
    cairo_stroke(cr)

    -- Draw seconds hand

    if show_seconds then
        xs=xc+1.0*clock_r*math.sin(secs_arc)
        ys=yc-1.0*clock_r*math.cos(secs_arc)
        cairo_move_to(cr,xc,yc)
        cairo_line_to(cr,xs,ys)

        cairo_set_line_cap(cr,CAIRO_LINE_CAP_ROUND) 
        cairo_set_line_width(cr,1)
        cairo_set_source_rgba(cr,rgb_to_r_g_b(second_colour,clock_alpha))
        cairo_stroke(cr)
    end
end

function conky_main_rings()
    local function setup_rings(cr,pt)
        local str=''
        local value=0
        str=string.format('${%s %s}',pt['name'],pt['arg'])
        str=conky_parse(str)
        value=tonumber(str)

        if value == nil then value = 0 end
        pct=value/pt['max']
        draw_ring(cr,pct,pt)
    end
    local function setup_bars(cr,pt)
        local str=''
        local value=0

        str=string.format('${%s %s}',pt['name'],pt['arg'])
        str=conky_parse(str)

        value=tonumber(str)
        if value == nil then value = 0 end
        if value>pt['max'] then pct=1 else pct=value/pt['max'] end

        draw_bar(cr,pct,pt)
    end

    -- Check that Conky has been running for at least (default) 5s
    if conky_window==nil then return end
    local cs=cairo_xlib_surface_create(conky_window.display,conky_window.drawable,conky_window.visual, conky_window.width,conky_window.height)
    local cr=cairo_create(cs)
    local updates=conky_parse('${updates}')
    update_num=tonumber(updates)
    if update_num>1 then
        go_gauge_rings(cr)

        for i in pairs(settings_table) do
            setup_rings(cr,settings_table[i])
        end
   --      for i in pairs(settings_bars) do
			-- setup_bars(cr,settings_bars[i])
   --      end
        draw_clock_hands(cr,clock_x,clock_y)

    end

    cairo_destroy(cr)
    cairo_surface_destroy(cs)
    cr=nil
    collectgarbage()
end
--=============================================================================================================================================

-- convert degree to rad and rotate (0 degree is top/north)
function angle_to_position(start_angle, current_angle)
    local pos = current_angle + start_angle
    return ( ( pos * (2 * math.pi / 360) ) - (math.pi / 2) )
end

-- displays gauges
function draw_gauge_ring(display, data, value)
    local max_value = data['max_value']
    local x, y = data['x'], data['y']
    local graph_radius = data['graph_radius']
    local graph_thickness, graph_unit_thickness = data['graph_thickness'], data['graph_unit_thickness']
    local graph_start_angle = data['graph_start_angle']
    local graph_unit_angle = data['graph_unit_angle']
    local graph_bg_colour, graph_bg_alpha = data['graph_bg_colour'], data['graph_bg_alpha']
    local graph_fg_colour, graph_fg_alpha = data['graph_fg_colour'], data['graph_fg_alpha']
    local hand_fg_colour, hand_fg_alpha = data['hand_fg_colour'], data['hand_fg_alpha']
    local graph_end_angle = (max_value * graph_unit_angle) % 360

    -- background ring
    cairo_arc(display, x, y, graph_radius, angle_to_position(graph_start_angle, 0), angle_to_position(graph_start_angle, graph_end_angle))
    cairo_set_source_rgba(display, rgb_to_r_g_b(graph_bg_colour, graph_bg_alpha))
    cairo_set_line_width(display, graph_thickness)
    cairo_stroke(display)

    -- arc of value
    local val = value % (max_value + 1)
    local start_arc = 0
    local stop_arc = 0
    local i = 1
    while i <= val do
        start_arc = (graph_unit_angle * i) - graph_unit_thickness
        stop_arc = (graph_unit_angle * i)
        cairo_arc(display, x, y, graph_radius, angle_to_position(graph_start_angle, start_arc), angle_to_position(graph_start_angle, stop_arc))
        cairo_set_source_rgba(display, rgb_to_r_g_b(graph_fg_colour, graph_fg_alpha))
        cairo_stroke(display)
        i = i + 1
    end
    local angle = start_arc

    -- hand
    start_arc = (graph_unit_angle * val) - (graph_unit_thickness * 2)
    stop_arc = (graph_unit_angle * val)
    cairo_arc(display, x, y, graph_radius, angle_to_position(graph_start_angle, start_arc), angle_to_position(graph_start_angle, stop_arc))
    cairo_set_source_rgba(display, rgb_to_r_g_b(hand_fg_colour, hand_fg_alpha))
    cairo_stroke(display)

    -- graduations marks
    local graduation_radius = data['graduation_radius']
    local graduation_thickness, graduation_mark_thickness = data['graduation_thickness'], data['graduation_mark_thickness']
    local graduation_unit_angle = data['graduation_unit_angle']
    local graduation_fg_colour, graduation_fg_alpha = data['graduation_fg_colour'], data['graduation_fg_alpha']
    if graduation_radius > 0 and graduation_thickness > 0 and graduation_unit_angle > 0 then
        local nb_graduation = graph_end_angle / graduation_unit_angle
        local i = 0
        while i < nb_graduation do
            cairo_set_line_width(display, graduation_thickness)
            start_arc = (graduation_unit_angle * i) - (graduation_mark_thickness / 2)
            stop_arc = (graduation_unit_angle * i) + (graduation_mark_thickness / 2)
            cairo_arc(display, x, y, graduation_radius, angle_to_position(graph_start_angle, start_arc), angle_to_position(graph_start_angle, stop_arc))
            cairo_set_source_rgba(display,rgb_to_r_g_b(graduation_fg_colour,graduation_fg_alpha))
            cairo_stroke(display)
            cairo_set_line_width(display, graph_thickness)
            i = i + 1
        end
    end

    -- text
    local txt_radius = data['txt_radius']
    local txt_weight, txt_size = data['txt_weight'], data['txt_size']
    local txt_fg_colour, txt_fg_alpha = data['txt_fg_colour'], data['txt_fg_alpha']
    local movex = txt_radius * math.cos(angle_to_position(graph_start_angle, angle))
    local movey = txt_radius * math.sin(angle_to_position(graph_start_angle, angle))
    cairo_select_font_face (display, "ubuntu", CAIRO_FONT_SLANT_NORMAL, txt_weight)
    cairo_set_font_size (display, txt_size)
    cairo_set_source_rgba (display, rgb_to_r_g_b(txt_fg_colour, txt_fg_alpha))
    if txt_radius > 0 then
        cairo_move_to (display, x + movex - (txt_size / 2), y + movey + 3)
        cairo_show_text (display, value)
        cairo_stroke (display)
    end

    -- caption
    local caption = data['caption']
    local caption_weight, caption_size = data['caption_weight'], data['caption_size']
    local caption_fg_colour, caption_fg_alpha = data['caption_fg_colour'], data['caption_fg_alpha']
    local tox = graph_radius * (math.cos((graph_start_angle * 2 * math.pi / 360)-(math.pi/2)))
    local toy = graph_radius * (math.sin((graph_start_angle * 2 * math.pi / 360)-(math.pi/2)))
    cairo_select_font_face (display, "ubuntu", CAIRO_FONT_SLANT_NORMAL, caption_weight);
    cairo_set_font_size (display, caption_size)
    cairo_set_source_rgba (display, rgb_to_r_g_b(caption_fg_colour, caption_fg_alpha))
    cairo_move_to (display, x + tox + 5, y + toy + 5)
    -- bad hack but not enough time !
    if graph_start_angle < 105 then
        cairo_move_to (display, x + tox - 30, y + toy + 1)
    end
    cairo_show_text (display, caption)
    cairo_stroke (display)
end

-- loads data and displays gauges
function go_gauge_rings(display)
    local function load_gauge_rings(display, data)
        local str, value = '', 0
        str = string.format('${%s %s}',data['name'], data['arg'])
        str = conky_parse(str)
        value = tonumber(str)
        draw_gauge_ring(display, data, value)
    end
    
    for i in pairs(gauge) do
        load_gauge_rings(display, gauge[i])
    end
end

--[[ TEXT WIDGET v1.42 by Wlourf 07 Feb. 2011

This widget can drawn texts set in the "text_settings" table with some parameters
http://u-scripts.blogspot.com/2010/06/text-widget.html

To call the script in a conky, use, before TEXT
lua_load /path/to/the/script/graph.lua
lua_draw_hook_pre main_graph
and add one line (blank or not) after TEXT

]]
--------------------------
require 'cairo'
require 'cairo_xlib'
--------------------------
function conky_draw_text()
    local text_settings={
        -------[ BEGIN OF PARAMETERS ]-------
        {
            text="CPU",
            x=cpu_x+30,
            y=cpu_y+50,
            colour={
                {0,0x7FFF4F,0.5},
                {0.6,0xEEEEEE,1},
                {1,0xDDDDDD,0.5}
            },
            font_name="Decker",
            font_size=28,
            bold=true,
            orientation="nn"
        },

    }
    --------------[ END OF PARAMETERS ]----------------

    if conky_window == nil then return end
    if tonumber(conky_parse("$updates"))<1 then return end

    local cs = cairo_xlib_surface_create(conky_window.display, conky_window.drawable, conky_window.visual, conky_window.width, conky_window.height)

    for i,v in pairs(text_settings) do    
        cr = cairo_create (cs)
        display_text(v)
        cairo_destroy(cr)
        cr = nil
    end

    cairo_surface_destroy(cs)

end

function rgb_to_r_g_b2(tcolour)
    local colour,alpha=tcolour[2],tcolour[3]
    return ((colour / 0x10000) % 0x100) / 255., ((colour / 0x100) % 0x100) / 255., (colour % 0x100) / 255., alpha
end

function display_text(t)
    if t.draw_me==true then t.draw_me = nil end
    if t.draw_me~=nil and conky_parse(tostring(t.draw_me)) ~= "1" then return end
    local function set_pattern(te)
        --this function set the pattern
        if #t.colour==1 then 
            cairo_set_source_rgba(cr,rgb_to_r_g_b2(t.colour[1]))
        else
            local pat

            if t.radial==nil then
                local pts=linear_orientation(t,te)
                pat = cairo_pattern_create_linear (pts[1],pts[2],pts[3],pts[4])
            else
                pat = cairo_pattern_create_radial (t.radial[1],t.radial[2],t.radial[3],t.radial[4],t.radial[5],t.radial[6])
            end

            for i=1, #t.colour do
                cairo_pattern_add_color_stop_rgba (pat, t.colour[i][1], rgb_to_r_g_b2(t.colour[i]))
            end
            cairo_set_source (cr, pat)
            cairo_pattern_destroy(pat)
        end
    end

    --set default values if needed
    if t.text==nil then t.text="Conky is good for you !" end
    if t.x==nil then t.x = conky_window.width/2 end
    if t.y==nil then t.y = conky_window.height/2 end
    if t.colour==nil then t.colour={{1,0xFFFFFF,1}} end
    if t.font_name==nil then t.font_name="Free Sans" end
    if t.font_size==nil then t.font_size=14 end
    if t.angle==nil then t.angle=0 end
    if t.italic==nil then t.italic=false end
    if t.oblique==nil then t.oblique=false end
    if t.bold==nil then t.bold=false end
    if t.radial ~= nil then
        if #t.radial~=6 then 
            print ("error in radial table")
            t.radial=nil 
        end
    end
    if t.orientation==nil then t.orientation="ww" end
    if t.h_align==nil then t.h_align="l" end
    if t.v_align==nil then t.v_align="b" end    
    if t.reflection_alpha == nil then t.reflection_alpha=0 end
    if t.reflection_length == nil then t.reflection_length=1 end
    if t.reflection_scale == nil then t.reflection_scale=1 end
    if t.skew_x==nil then t.skew_x=0 end
    if t.skew_y==nil then t.skew_y=0 end    
    cairo_translate(cr,t.x,t.y)
    cairo_rotate(cr,t.angle*math.pi/180)
    cairo_save(cr)       

    local slant = CAIRO_FONT_SLANT_NORMAL
    local weight = CAIRO_FONT_WEIGHT_NORMAL
    if t.italic then slant = CAIRO_FONT_SLANT_ITALIC end
    if t.oblique then slant = CAIRO_FONT_SLANT_OBLIQUE end
    if t.bold then weight = CAIRO_FONT_WEIGHT_BOLD end

    cairo_select_font_face(cr, t.font_name, slant,weight)

    for i=1, #t.colour do    
        if #t.colour[i]~=3 then 
            print ("error in color table")
            t.colour[i]={1,0xFFFFFF,1} 
        end
    end

    local matrix0 = cairo_matrix_t:create()
    tolua.takeownership(matrix0) 
    local skew_x,skew_y=t.skew_x/t.font_size,t.skew_y/t.font_size
    cairo_matrix_init (matrix0, 1,skew_y,skew_x,1,0,0)
    cairo_transform(cr,matrix0)
    cairo_set_font_size(cr,t.font_size)
    local te=cairo_text_extents_t:create()
    tolua.takeownership(te) 
    t.text=conky_parse(t.text)
    cairo_text_extents (cr,t.text,te)
    set_pattern(te)

    local mx,my=0,0

    if t.h_align=="c" then
        mx=-te.width/2-te.x_bearing
    elseif t.h_align=="r" then
        mx=-te.width
    end
    if t.v_align=="m" then
        my=-te.height/2-te.y_bearing
    elseif t.v_align=="t" then
        my=-te.y_bearing
    end
    cairo_move_to(cr,mx,my)

    cairo_show_text(cr,t.text)

    if t.reflection_alpha ~= 0 then 
        local matrix1 = cairo_matrix_t:create()
        tolua.takeownership(matrix1)         
        cairo_set_font_size(cr,t.font_size)

        cairo_matrix_init (matrix1,1,0,0,-1*t.reflection_scale,0,(te.height+te.y_bearing+my)*(1+t.reflection_scale))
        cairo_set_font_size(cr,t.font_size)
        te=nil
        local te=cairo_text_extents_t:create()
        tolua.takeownership(te) 
        cairo_text_extents (cr,t.text,te)


        cairo_transform(cr,matrix1)
        set_pattern(te)
        cairo_move_to(cr,mx,my)
        cairo_show_text(cr,t.text)

        local pat2 = cairo_pattern_create_linear (0,
        (te.y_bearing+te.height+my),
        0,
        te.y_bearing+my)
        cairo_pattern_add_color_stop_rgba (pat2, 0,1,0,0,1-t.reflection_alpha)
        cairo_pattern_add_color_stop_rgba (pat2, t.reflection_length,0,0,0,1)    

        --line is not drawn but with a size of zero, the mask won't be nice
        cairo_set_line_width(cr,1)
        local dy=te.x_bearing
        if dy<0 then dy=dy*(-1) end
        cairo_rectangle(cr,mx+te.x_bearing,te.y_bearing+te.height+my,te.width+dy,-te.height*1.05)
        cairo_clip_preserve(cr)
        cairo_set_operator(cr,CAIRO_OPERATOR_CLEAR)
        --cairo_stroke(cr)
        cairo_mask(cr,pat2)
        cairo_pattern_destroy(pat2)
        cairo_set_operator(cr,CAIRO_OPERATOR_OVER)
        te=nil
    end

end

function put_image(t)
    --[[
        function to put the images and rotate them.
        Params:
        <mandatory>
        x,y : coords
        file : image file
        <optional>
        scale : scaling factor (default 1)
        rotate (boolean): when set to true, rotates the image by angle theta
        theta : angle to rotate the image by. Required if rotate is true
    ]]--

    local scale = t.scale or 1
    local image = cairo_image_surface_create_from_png (IMAGEPATH..t.file);
    local w = cairo_image_surface_get_width (image);
    local h = cairo_image_surface_get_height (image);
    cairo_save(cr)
    cairo_translate (cr, t.x, t.y);
    if t.rotate then cairo_rotate(cr, t.theta) end
    cairo_scale  (cr, scale, scale);
    cairo_translate (cr, -0.5*w, -0.5*h);
    cairo_set_source_surface (cr, image, 0, 0);
    cairo_paint (cr);
    cairo_surface_destroy (image);
    cairo_restore(cr)
end

function linear_orientation(t,te)
    local w,h=te.width,te.height
    local xb,yb=te.x_bearing,te.y_bearing

    if t.h_align=="c" then
        xb=xb-w/2
    elseif t.h_align=="r" then
        xb=xb-w
    end    
    if t.v_align=="m" then
        yb=-h/2
    elseif t.v_align=="t" then
        yb=0
    end    
    local p=0
    if t.orientation=="nn" then
        p={xb+w/2,yb,xb+w/2,yb+h}
    elseif t.orientation=="ne" then
        p={xb+w,yb,xb,yb+h}
    elseif t.orientation=="ww" then
        p={xb,h/2,xb+w,h/2}
    elseif vorientation=="se" then
        p={xb+w,yb+h,xb,yb}
    elseif t.orientation=="ss" then
        p={xb+w/2,yb+h,xb+w/2,yb}
    elseif t.orientation=="ee" then
        p={xb+w,h/2,xb,h/2}        
    elseif t.orientation=="sw" then
        p={xb,yb+h,xb+w,yb}
    elseif t.orientation=="nw" then
        p={xb,yb,xb+w,yb+h}
    end
    return p
end
--===================================================================================================

--[[ =====================================================
=================== BACKGROUND ===========================
==========================================================
== Background script originally by londonali1010 (2009) ==
==========================================================
The change is that if you set width, and/or height to 0
then it assumes the width and/or height of the conky window

The command before line "TEXT" in conkyrc file is for load/call script
The command after line "TEXT" in conkyrc file is for setting background (see below)

lua_load ~/.conky/Conky-Name/scripts/lua/draw_bg.lua

TEXT

${lua conky_draw_bg 20 0 0 0 0 0x000000 0.4}
---------------------------------------------------------------------------------
See below:          1 2 3 4 5 6 7
---------------------------------------------------------------------------------
${lua conky_draw_bg corner_radius x_position y_position width height color alpha}
---------------------------------------------------------------------------------
A covers the whole window and will change if you change the minimum_size setting
---------------------------------------------------------------------------------
1 = 20            corner_radius background
2 = 0             x_position (across background)
3 = 0             y_position (down background)
4 = 0             width background
5 = 0             height background
6 = 0x000000      color background
7 = 0.4           alpha background
----------------------------------------------------------------------------------
You can load/call this script with full command before line "TEXT" in conkyrc file
----------------------------------------------------------------------------------
lua_load ~/.conky/Conky-Name/scripts/lua/draw_bg.lua
lua_draw_hook_pre draw_bg 0 0 0 0 0 0x000000 0.4

TEXT

]]
------------------------------------------------------------------------------------------------------------

require 'cairo'
require 'cairo_xlib'

------------------------------------------------------------------------------------------------------------
local    cs, cr = nil
function rgb_to_r_g_b(colour,alpha)
    return ((colour / 0x10000) % 0x100) / 255., ((colour / 0x100) % 0x100) / 255., (colour % 0x100) / 255., alpha
end
function conky_draw_bg(r,x,y,w,h,color,alpha)
    if conky_window == nil then return end
    if cs == nil then cairo_surface_destroy(cs) end
    if cr == nil then cairo_destroy(cr) end
    local cs = cairo_xlib_surface_create(conky_window.display, conky_window.drawable, conky_window.visual, conky_window.width, conky_window.height)
    local cr = cairo_create(cs)
    w=w
    h=h
    if w=="0" then w=tonumber(conky_window.width) end
    if h=="0" then h=tonumber(conky_window.height) end
    cairo_set_source_rgba (cr,rgb_to_r_g_b(color,alpha))

    --[[ TOP LEFT MID CIRCLE ]]--
    local xtl=x+r
    local ytl=y+r

    --[[ TOP RIGHT MID CIRCLE ]]--
    local xtr=(x+r)+((w)-(2*r))
    local ytr=y+r

    --[[ BOTTOM LEFT MID CIRCLE ]]--
    local xbr=(x+r)+((w)-(2*r))
    local ybr=(y+r)+((h)-(2*r))

    --[[ BOTTOM RIGHT MID CIRCLE ]]--
    local xbl=(x+r)
    local ybl=(y+r)+((h)-(2*r))
    ----------------------------------------------------------
    cairo_move_to (cr,xtl,ytl-r)
    cairo_line_to (cr,xtr,ytr-r)
    cairo_arc(cr,xtr,ytr,r,((2*math.pi/4)*3),((2*math.pi/4)*4))
    cairo_line_to (cr,xbr+r,ybr)
    cairo_arc(cr,xbr,ybr,r,((2*math.pi/4)*4),((2*math.pi/4)*1))
    cairo_line_to (cr,xbl,ybl+r)
    cairo_arc(cr,xbl,ybl,r,((2*math.pi/4)*1),((2*math.pi/4)*2))
    cairo_line_to (cr,xtl-r,ytl)
    cairo_arc(cr,xtl,ytl,r,((2*math.pi/4)*2),((2*math.pi/4)*3))
    cairo_close_path(cr)
    cairo_fill (cr)
    ------------------------------------------------------------
    cairo_surface_destroy(cs)
    cairo_destroy(cr)
    return ""
end
--############################################################--
--================================
--===[ REGARDS, ETLES_TEAM ] ===--
--================================

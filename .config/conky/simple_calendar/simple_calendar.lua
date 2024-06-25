--[[ Display to Conky LUA 1.0 Author : wolfie Release date : 19 December 2020 Tested on : Deepin 20
    Feel free to modity this script.
]]
-- This is a lua script for use in Conky.

function string.starts(String,Start)
   return string.sub(String,1,string.len(Start))==Start
end

require 'cairo'
require 'cairo_xlib'

local sxtwl = require("sxtwl")
local lunar = sxtwl.Lunar()

HOME = os.getenv("HOME")
lyaml = require('lyaml')
local holidayFile = io.open(HOME.."/.config/conky/simple_calendar/CN.yaml", "r")
local holidayConf = holidayFile:read("*a")
local holiday = {}
holidayFile:close()
if nil ~= holidayConf and "" ~= holidayConf then
    holiday = lyaml.load(holidayConf)
else
    holiday = {}
end
print("holiday:"..holiday.holidays.CN.names.zh)

function awesome_next(t, k)
    k, t = next(t, k)
    if not t then return end
    return k, table.unpack(t)
end

for dstr, key, value in awesome_next, holiday.holidays.CN.days do
    print("holiday date:"..dstr)
    print("key type:"..type(key))
    if nil ~= key then print("holiday key:"..key) end
    print("v:"..type(value))
end

for dstr, v in pairs(holiday.holidays.CN.days) do
    print("holiday date:"..dstr)
    print("holiday name: "..v.name.zh)
end



font = "Mono"
wenquanyi = "wenquanyi zen hei mono"
font_size = 26
xpos, ypos = 10, 20
increment = 40
red, green, blue, alpha = 1, 1, 1, 1
font_slant = CAIRO_FONT_SLANT_NORMAL
font_face_normal = CAIRO_FONT_WEIGHT_NORMAL
font_face_bold = CAIRO_FONT_WEIGHT_BOLD

os.setlocale("zh_CN.UTF8")

current_year = os.date("%Y")
current_month_spelled = os.date("%B")
first_of_the_month = 1
month_full_dates = ""

t = os.date('*t', os.time())
year, month, currentday = t.year, t.month, t.day

-- 今年今月的01号
first_day_of_the_month = os.date("*t",os.time{year=year,month=month,day=01})
first_day_of_the_month_wday = first_day_of_the_month.wday > 1 and first_day_of_the_month.wday - 1 or 7


local c27 = string.char(27)
local log = {}
local reset = c27 .. '[' .. tostring(0) .. 'm'
local green1 = c27 .. '[' .. tostring(32) .. 'm'
function log.info(msg)
    print(green1 .. "[info ]  " .. msg .. reset)
end

log.info("星期" .. first_day_of_the_month.wday .. "  year:" .. first_day_of_the_month.year .. " month:" .. first_day_of_the_month.month .. first_day_of_the_month.day )

daysOfTheWeekLong = { 
    en = { "Monday", "Tuesday", "Wednesday", "Thrusday", "Friday", "Saturday", "Sunday" }
}

daysOfTheWeekShort = {
	en = { "Mo", "Tu", "We", "Th", "Fr", "Sa", "Su" },
    zh = { "一", "二", "三", "四", "五", "六", "日" }
}


Gan = { "甲", "乙", "丙", "丁", "戊", "己", "庚", "辛", "壬", "癸"}
Zhi = { "子", "丑", "寅", "卯", "辰", "巳", "午", "未", "申", "酉", "戌", "亥"}
ShX = { "鼠", "牛", "虎", "兔", "龙", "蛇", "马", "羊", "猴", "鸡", "狗", "猪"}
ymc = { "十一", "十二", "正", "二", "三", "四", "五", "六", "七", "八", "九", "十"}
rmc = { "初一", "初二", "初三", "初四", "初五", "初六", "初七", "初八", "初九", "初十", "十一", "十二", "十三", "十四", "十五", "十六", "十七", "十八", "十九", "二十", "廿一", "廿二", "廿三", "廿四", "廿五", "廿六", "廿七", "廿八", "廿九", "三十", "卅一"}
Week = { "日", "一", "二", "三", "四", "五", "六"}
jqmc = {"冬至", "小寒", "大寒", "立春", "雨水", "惊蛰", "春分", "清明", "谷雨", "立夏", "小满", "芒种", "夏至", "小暑", "大暑", "立秋", "处暑","白露", "秋分", "寒露", "霜降", "立冬", "小雪", "大雪"}


function get_month_full_dates (month_table)
	monthly_full = ""
	
	for key, value in pairs( month_table ) do
	    monthly_full = monthly_full .. value .. "  "
	end
	
	return (monthly_full)
end


-- 1 2 3 4 5 6 7
--
-- x x x x x x x
-- x x x x x x x
-- x x x x x x x
-- x x x x x x x
-- x x x x x x x
-- x x x x x x x

function get_week_short_names (week)
	short_names = ""
	
	for key, value in pairs( week ) do
	    short_names = short_names .. value .. "    "
	end
	
	return (short_names)
end


function is_leap_year(year)
    return year % 4 == 0 and (year % 100 ~= 0 or year % 400 == 0)
end

function get_days_in_month (month, year)
    return month == 2 and is_leap_year(year) and 29
           or ("\31\28\31\30\31\30\31\31\30\31\30\31"):byte(month)
end
  
function split(pString, pPattern)
   local Table = {}  -- NOTE: use {n = 0} in Lua-5.0
   local fpat = "(.-)" .. pPattern
   local last_end = 1
   local s, e, cap = pString:find(fpat, 1)
   while s do
      if s ~= 1 or cap ~= "" then
     table.insert(Table,cap)
      end
      last_end = e+1
      s, e, cap = pString:find(fpat, last_end)
   end
   if last_end <= #pString then
      cap = pString:sub(last_end)
      table.insert(Table, cap)
   end
   return Table
end

-- 1 2 3 4 5 6 7
--
-- x x x x x x x
-- x x x x x x x
-- x x x x x x x
-- x x x x x x x
-- x x x x x x x
-- x x x x x x x

function conky_main ()
    conky_calendar()
end

function draw_weekend_cell()
end
function draw_currentday_cell()
end


function draw_workday_cell(cs, cs2, xpos, ypos, num)
	cairo_move_to(cs2, xpos-2, ypos - 2)  --SHADOW
	cairo_show_text(cs2, num)--SHADOW

	cairo_move_to (cs,xpos,ypos)
	cairo_show_text(cs, num)
end

M_PI = 3.1415926535


function conky_calendar()
  holidays = {}

  for dstr, v in pairs(holiday.holidays.CN.days) do
    if string.starts(dstr, "chinese") then
      if v.type == "lunar" then
        str:match("(%d+)-(%d+)-(%d+)")
        holidays[split(dstr, " ")[2]] = v
      end
    else
    end

    print("holiday date:"..dstr)
    print("holiday name: "..v.name.zh)
  end

  xpos, ypos = 40, 60
  increment = 80

  t = os.date('*t', os.time())
  year, month, currentday = t.year, t.month, t.day

  lunarMonth = lunar.yueLiCalc(lunar, year, month);

  -- 今年今月的01号
  first_day_of_the_month = os.date("*t",os.time{year=year,month=month,day=01})
  -- 1号周几
  first_day_of_the_month_wday = first_day_of_the_month.wday > 1 and first_day_of_the_month.wday - 1 or 7
  total_days = get_days_in_month(month, current_year) 
  print("first_day_of_the_month_wday: "..first_day_of_the_month_wday.."  first_day_of_the_month.wday:"..first_day_of_the_month.wday.."  total days:"..total_days.."    month:"..month)
  current_month_spelled = os.date("%B")

  if conky_window == nil then return end
  local cs = cairo_xlib_surface_create(conky_window.display, conky_window.drawable, conky_window.visual, conky_window.width, conky_window.height)
  local cr_month = cairo_create(cs)
  local cr_month2 = cairo_create(cs)
  local cr_week = cairo_create(cs)
  local cr_week2 = cairo_create(cs)
  local cr_workday = cairo_create(cs)
  local cr_workday2 = cairo_create(cs)
  local cr_currentday = cairo_create(cs)
  local cr_currentday2 = cairo_create(cs)
  local cr_currentday_bg = cairo_create(cs)
  local cr_weekend = cairo_create(cs)
  local cr_weekend2 = cairo_create(cs)

  -- 月标题
  cairo_select_font_face (cr_month, "wenquanyi zen hei mono", CAIRO_FONT_SLANT_NORMAL, CAIRO_FONT_WEIGHT_NORMAL);
  cairo_set_font_size (cr_month, 54)
  cairo_select_font_face (cr_month2, "wenquanyi zen hei mono", CAIRO_FONT_SLANT_NORMAL, CAIRO_FONT_WEIGHT_NORMAL);
  cairo_set_font_size (cr_month2, 54)
  cairo_set_source_rgba(cr_month, 255,255,255,1)
  cairo_set_source_rgba(cr_month2, 0, 0, 0, 0.5)--SHADOW

  -- 周标题
  cairo_select_font_face (cr_week, wenquanyi, CAIRO_FONT_SLANT_NORMAL, CAIRO_FONT_WEIGHT_NORMAL);
  cairo_set_font_size (cr_week, 34)
  cairo_set_source_rgba(cr_week,255,255,255,1)
  cairo_select_font_face (cr_week2, wenquanyi, CAIRO_FONT_SLANT_NORMAL, CAIRO_FONT_WEIGHT_NORMAL);
  cairo_set_font_size (cr_week2, 34)
  cairo_set_source_rgba(cr_week2, 0, 0, 0, 0.5)--SHADOW

  -- 工作日
  cairo_select_font_face (cr_workday, "Mono", CAIRO_FONT_SLANT_NORMAL, CAIRO_FONT_WEIGHT_NORMAL);
  cairo_set_font_size (cr_workday, 34)
  cairo_set_source_rgba(cr_workday,255,255,255,1)
  cairo_select_font_face (cr_workday2, "Mono", CAIRO_FONT_SLANT_NORMAL, CAIRO_FONT_WEIGHT_NORMAL);
  cairo_set_font_size (cr_workday2, 34)
  cairo_set_source_rgba(cr_workday2, 0, 0, 0, 0.5)--SHADOW

  cairo_set_source_rgb(cr_currentday_bg, 0, 0, 0.23);
  cairo_set_line_width(cr_currentday_bg, 20);


  print("")
  print("conky_calendar start xpos: "..xpos.. "         ypos: "..ypos.. " current_month_spelled:"..current_month_spelled)

  cairo_move_to(cr_month2, xpos, ypos - 2)  --SHADOW
  cairo_show_text(cr_month2, current_month_spelled)--SHADOW
  cairo_move_to(cr_month, xpos, ypos)
  cairo_show_text(cr_month, current_month_spelled)
  ypos = ypos + 100

  for j = 1, 7 do
    if(j > 5) then
      cairo_set_source_rgba(cr_week, 255,0,0,1)
      cairo_set_source_rgba(cr_week2, 0,255,255, 0.8)
    else
      cairo_set_source_rgba(cr_week, 255,255,255,1)
      cairo_set_source_rgba(cr_week2, 0,0,0, 0.5)
    end

    draw_workday_cell(cr_week, cr_week2, xpos, ypos, daysOfTheWeekShort.zh[j])
    xpos = xpos + increment
  end

  cairo_set_source_rgba(cr_week, 255,255,255,1)
  cairo_set_source_rgba(cr_week2, 0,0,0, 0.5)
  cairo_set_font_size (cr_week, 28)
  cairo_set_font_size (cr_week2, 28)

  ypos = ypos + 80
  xpos = 40

  pos = 1;
  cellstart = first_day_of_the_month_wday
  currentcell = first_day_of_the_month_wday + currentday - 1
  cellend = first_day_of_the_month_wday + total_days

  print("currentcell: "..currentcell)

  d = 1
  for i = 1, 6, 1 do
    for j = 1, 7 do
      if pos >= cellstart and pos < cellend then
        lunarDay = lunarMonth.days[d-1]
        d_ch = rmc[lunarDay.Ldi+1]
        if(lunarDay.qk >= 0) then 
          d_ch = jqmc[lunarDay.jqmc+1]
        end
        for dstr, v in pairs(holiday.holidays.CN.days) do
            if v.type == "lunar" and v.month == lunarDay.Lmc+1 and v.day == lunarDay.Ldi+1 then
                d_ch = v.name.zh
            elseif v.type == "solar" and v.month == month and v.day == d then
                d_ch = v.name.zh
            end
        end
        if pos == currentcell then
          -- 今天背景
          cairo_set_operator(cr_currentday_bg, CAIRO_OPERATOR_XOR)
          cairo_arc(cr_currentday_bg, xpos+20, ypos, 50, 0, 2*M_PI);
          cairo_fill_preserve(cr_currentday_bg);
          cairo_set_source_rgba(cr_currentday_bg, 1, 1, 1, 0.6)
          cairo_stroke(cr_currentday_bg);
        end

        if(j > 5) then
          cairo_set_source_rgba(cr_workday, 255,0,0,1)
          cairo_set_source_rgba(cr_workday2, 0,255,255, 0.3)
        else
          cairo_set_source_rgba(cr_workday, 255,255,255,1)
          cairo_set_source_rgba(cr_workday2, 0, 0, 0, 0.5)
        end
        draw_workday_cell(cr_workday, cr_workday2, xpos, ypos, d)
        draw_workday_cell(cr_week, cr_week2, xpos-10, ypos+30, d_ch)
        d = d + 1;

      end

      xpos = xpos + increment
      pos = pos + 1;

      -- print("pppppppppos: "..pos)
    end
    xpos = 40
    ypos = ypos + increment
  end


  -- End of output
  cairo_destroy(cr_month)
  cairo_destroy(cr_month2)
  cairo_destroy(cr_week)
  cairo_destroy(cr_week2)
  cairo_destroy(cr_workday)
  cairo_destroy(cr_workday2)
  cairo_destroy(cr_currentday)
  cairo_destroy(cr_currentday2)
  cairo_destroy(cr_currentday_bg)
  cairo_destroy(cr_weekend)
  cairo_destroy(cr_weekend2)
  cairo_surface_destroy(cs)
  cr_month=nil
  cr_week=nil
  cr_workday=nil
  cr_currentday=nil
  cr_weekend=nil
  cs = nil
end


function cairo_set_object (cairo_object)
  cairo_select_font_face (cairo_object, font, font_slant, font_face_bold);
  cairo_set_font_size (cairo_object, font_size)
  cairo_set_source_rgba (cairo_object, red, green, blue, alpha)
end

function cairo_move (cairo_object, xpos, ypos, calendar_string)
  cairo_move_to(cairo_object, xpos, ypos)
  cairo_select_font_face (cairo_object, font, font_slant, font_face_normalc);
  cairo_show_text (cairo_object, calendar_string)
end

function cairo_move_zh (cairo_object, xpos, ypos, calendar_string)
  cairo_move_to(cairo_object, xpos, ypos)
  cairo_select_font_face (cairo_object, wenquanyi, font_slant, font_face_normalc);
  cairo_show_text (cairo_object, calendar_string)
end

function cairo_destroy_all (cairo_object, cairo_surface)
  cairo_destroy (cairo_object)
  cairo_surface_destroy (cairo_surface)
  cairo_object = nil
end


-- 这里load 的sxtwl 是 ./sxtwl.so
local sxtwl = require("sxtwl")
-- 这里load 的holiday 是 ~/.config/conky/holiday.lua
local holiday = require("holiday")
-- print("sxtwl:"..sxtwl)
print(holiday['01-01'].name.zh)

function get_days_in_month (month, year)
    return month == 2 and is_leap_year(year) and 29
           or ("\31\28\31\30\31\30\31\31\30\31\30\31"):byte(month)
end

current_year = os.date("%Y")
current_month_spelled = os.date("%B")


t = os.date('*t', os.time())
year, month, currentday = t.year, t.month, t.day

dayCounts = get_days_in_month() 
day = sxtwl.fromSolar(year, month, currentday)
-- a:name()是语法糖a.name(a)
lunarDay = day.getLunarDay(day)
lunarMonth = day:getLunarMonth()

print(current_year..current_month_spelled.."("..year.."/"..month.."/"..currentday..") has daycounts: "..dayCounts..", lunarDay: "..lunarDay..", lunarMonth"..lunarMonth)


rmc = { "初一", "初二", "初三", "初四", "初五", "初六", "初七", "初八", "初九", "初十", "十一", "十二", "十三", "十四", "十五", "十六", "十七", "十八", "十九", "二十", "廿一", "廿二", "廿三", "廿四", "廿五", "廿六", "廿七", "廿八", "廿九", "三十", "卅一"}


d_ch = rmc[lunarDay]
print("lunar ch : "..d_ch)

dd = {
  a = 1,
  b = {
    c = 2
  }
}

-- for k, v in pairs(dd) do
--     print("holiday date:"..k)
--     print("holiday name: "..v)
-- end


-- TestSuite
-- print("January")
-- print("week: ", get_month_week(1, 7, 1))
-- print("week: ", get_month_week(8, 14, 3))
-- print("week: ", get_month_week(15, 21, 10))
-- print("week: ", get_month_week(22, 28, 17))
-- print("week: ", get_month_week(29, 35, 24))
-- print("week: ", get_month_week(36, 36, 31))

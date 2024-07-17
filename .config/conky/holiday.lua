
solar = 'solar'
lunar = 'lunar'

holidays = {
  ['01-01'] = {
    type = 'solar',
    name = {
      en = 'yuandan',
      zh = '元旦'
    },
    month = 1,
    day = 1,
  },
  ['03-08'] = {
    type = 'solar',
    name = {
      en = 'Women\'s Day',
      zh = '三八节',
    },
    month = 3,
    day = 8,
    note = Women,
  },
  ['05-01'] = {
    type = 'solar',
    name = {
      en = 'Worker\'s Day',
      zh = '劳动节',
    },
    month = 5,
    day = 4,
  },
  ['05-04'] = {
    type = 'solar',
    month = 5,
    day = 4,
    name = {
      en = 'Youth Day',
      zh = '青年节',
    },
    note = 'Youth from the age of 14 to 28',
  },
  ['06-01'] = {
    type = 'solar',
    month = 6,
    day = 1,
    name = {
      en = 'Children\'s Day',
      zh = '儿童节',
    },
    note = 'Children below the age of 14'
  },
  ['08-01'] = {
    type = solar,
    month = 8,
    day = 1,
    name = {
      en = 'Army Day',
      zh = '建军节',
    },
    note = 'Military personnel in active service',
  },
  ['10-01'] = {
    type = solar,
    month = 10,
    day = 1,
    name = {
      en = 'National Day',
      zh = '国庆节',
    },
  },
  ['01-01'] = {
    type = lunar,
    month = 1,
    day = 1,
    name = {
      en = 'Spring Festival',
      zh = '春节',
    },
  },
  ['05-05'] = {
    type = lunar,
    month = 5,
    day = 5,
    name = {
      en = 'Dragon Boat Festival',
      zh = '端午节',
    },
  },
  ['08-15'] = {
    type = lunar,
    month = 8,
    day = 15,
    name = {
      en = 'Mid-Autumn Festival',
      zh = '中秋节'
    }
  }
}

function dump(o, lvl)
   lvl = lvl or 7
   preBlank = string.rep(' ', lvl*2)
   if type(o) == 'table' then
      local s = '{ '
      for k,v in pairs(o) do
         if type(k) ~= 'number' then k = '"'..k..'"' end
         s = s .. '['..k..'] = ' .. dump(v, lvl+1) .. ',\n'
      end
      return s .. '} \n'
   else
      return tostring(o)
   end
end

dumpstr = dump(holidays)
print("dumpstr".. dumpstr) 

return holidays 

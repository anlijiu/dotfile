#!/usr/bin/ruby
require 'pp'
# all emoji
# 1000.times { |i| emoji(127740 + i) + ' ' }

# moon phases
# 8.times { |i| emoji(127761 + i) }

DELAY = 0.3;

# clean screen
def clean
  puts "\e[H\e[2J";
end

def emoji(n)
  # print n.to_s(16) + ':'
  [n].pack('U*');
end

# clean()

# 1F601 - 1F64F
puts '\n\n1. Emoticons ( 1F601 - 1F64F )'
'4F'.to_i(16).times {|i| print emoji('1F601'.to_i(16) + i) + '  ' }

# 2. Dingbats ( 2702 - 27B0 )
puts "\n\n2. Dingbats ( 2702 - 27B0 )"
'AF'.to_i(16).times {|i| print emoji('2702'.to_i(16) + i) + '  ' }

# 3. Transport and map symbols ( 1F680 - 1F6C0 )
puts "\n\n3. Transport and map symbols ( 1F680 - 1F6C0 )"
'46'.to_i(16).times {|i| print emoji('1F680'.to_i(16) + i) + '  ' }

# 4. Enclosed characters ( 24C2 - 1F251 )
puts "\n\n4. Enclosed characters ( 24C2, 1F170 - 1F251 )"
print emoji('24C2'.to_i(16)) + '  '
'E2'.to_i(16).times {|i| print emoji('1F170'.to_i(16) + i) + '  ' }

# 6a. Additional emoticons ( 1F600 - 1F636 )
puts "\n\n6a. Additional emoticons ( 1F600 - 1F636 )"
'37'.to_i(16).times {|i| print emoji('1F600'.to_i(16) + i) + '  ' }

# 6c. Other additional symbols ( 1F30D - 1F567 )
puts "\n\n6c. Other additional symbols ( 1F30D - 1F567 )"
'480'.to_i(16).times {|i| print emoji('1F300'.to_i(16) + i) + '  ' }

# 100000.times { |i| print emoji(107740 + i) + ' ' }

# 64.times do
#   8.times do |i|
#     clean
#     emoji(127768 - i)
#     puts
#     sleep DELAY
#   end
# end

puts "Please numbers: day month year"
day,month,year = gets.split(" ").map(&:to_i)
puts year
day_in_months = [31,28,31,30,31,30,31,31,30,31,30,31]
day_in_months[1] = 29 if (year % 4 == 0 && (year % 100 != 0 || year % 400 == 0))
puts day_in_months
res = day
(0...(month-1)).each { |i| res += day_in_months[i] }
puts res

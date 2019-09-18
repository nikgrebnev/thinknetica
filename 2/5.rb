puts "Please numbers: day month year"
day,month,year = gets.split(" ").map(&:to_i)
day_in_months = [31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31]
day_in_months[1] = 29 if (year % 4 == 0 && (year % 100 != 0 || year % 400 == 0))
res = day + day_in_months.take(month - 1).sum
puts res

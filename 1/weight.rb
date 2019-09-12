

puts "Please enter your name"
name=gets.chomp
puts "Please enter your height"
height=gets.chomp.to_f
height*=100 if height<2.5 #Если он ввел в метрах
height*=30.48 if height<10.0 #Если он ввел в футах
ideal=height-110.0
puts "#{name}, Ваш вес уже оптимальный" if ideal <= 0.0
puts "#{name}, Ваш идеальный вес #{ideal}"


# Программа написана в соответствии с ТЗ. Ее назначение для меня туманно, т.к. мы не запрашиваем текущий вес человека, чтобы с ним сравнить

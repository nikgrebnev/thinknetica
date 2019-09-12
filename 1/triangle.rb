puts "Please enter 3 sides of triangle separated by spaces"
s = gets.split(" ").map(&:to_f).sort
if s[0]==s[1] && s[1]==s[2]
  puts "Это равносторонний треугольник"
else
  if s[0]==s[1] || s[1]==s[2]
    puts "Это равнобедренный треугольник"
  end
  if s[0]**2 + s[1]**2 == s[2]**2
    puts "Это прямоугольний треугольник"
  end
end

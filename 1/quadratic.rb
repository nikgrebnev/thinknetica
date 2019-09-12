puts "Please enter a b c values of quadratic equation "
a,b,c=gets.split(" ").map { |i| i.to_f }
d=b*b - 4*a*c
if d<0
	puts "D=#{d}, no roots"
elsif d>0
	r1 = (-b+Math.sqrt(d))/(2*a)
	r2 = (-b-Math.sqrt(d))/(2*a)
	puts "D=#{d} r1=#{r1} r2=#{r2}"
else
	r=-b/(2*a)
	puts "D=#{d} r1=r2=#{r}"
end


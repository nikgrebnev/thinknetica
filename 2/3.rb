a = [0,1]
i = a[-1] + a[-2]
while i < 100
  a << i
  i = a[-1] + a[-2]
end
puts a

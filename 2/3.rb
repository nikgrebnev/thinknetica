a = [0]
i=1
while i < 100
  a << i
  i = a[-1] + a[-2]
end
puts a

puts "Please enter goods name, price and quantity separated by space. And стоп when done"
basket = Hash.new
loop do
  name,price,quantity = gets.split(" ")
  break if name == 'стоп'
  basket[name] = [price.to_f, quantity.to_f]
end
total = 0.0
puts "=============================="
basket.each do |k,v|
  current = v[0] * v[1]
  total += current
  puts "Name: #{k}, price: #{v[0]}, quantity: #{v[1]}, cost #{current}"
end
puts "==== Total: #{total} ===="


puts "Please enter goods name, price and quantity separated by space. And стоп when done"
basket = {}
loop do
  input_vals = gets.split(" ")
  break if input_vals[0] == 'стоп'
  name = input_vals[0...-2].join(" ")
  price = input_vals[-2]
  quantity = input_vals[-1]
  basket[name] = { price: price.to_f, quantity: quantity.to_f}
end
total = 0.0
puts "=============================="
basket.each do |name, vals|
  current = vals[:price] * vals[:quantity]
  total += current
  puts "Name: #{name}, price: #{vals[:price]}, quantity: #{vals[:quantity]}, cost #{current}"
end
puts "==== Total: #{total} ===="

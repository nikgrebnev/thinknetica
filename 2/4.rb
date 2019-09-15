vowels = ['A', 'E', 'I', 'O', 'U']
result = Hash.new
('A'..'Z').each_with_index do |k,v|
  result[k] = v if vowels.include?(k) 
end
puts result

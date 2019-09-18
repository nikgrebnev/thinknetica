vowels = %w[A E I O U] #['A', 'E', 'I', 'O', 'U']
result = {}
('A'..'Z').each.with_index(1) do |character,id|
  result[character] = id if vowels.include?(character) 
end
puts result

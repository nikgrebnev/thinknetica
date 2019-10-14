require_relative 'card.rb'
require_relative 'deck.rb'
require_relative 'player.rb'
require_relative 'game.rb'

loop do
  game = Game.new
  game.main_menu
  puts ""
  puts "Введите 1 для того, чтобы начать еще раз"
  break unless gets.chomp.to_i == 1
end

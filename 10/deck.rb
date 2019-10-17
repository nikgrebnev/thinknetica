class Deck
  CARDS = %w(2 3 4 5 6 7 8 9 10 В Д К Т)
  SUITS = [:spade, :heart, :diamond, :club]

  attr_reader :deck
  def initialize
    @deck = []
    CARDS.each do |c|
      SUITS.each do |s|
        @deck << Card.new(c, s, cost(c))
      end
    end
    @deck.shuffle!
  end


  def take_card
    @deck.pop
  end
  
  private

  def cost(c)
    return [c.to_i, 0] if c.to_i > 1

    return [1, 10] if c == 'Т'

    [10, 0]
  end
end
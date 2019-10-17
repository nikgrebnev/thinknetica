class Player
  MAX_SCORE = 21
  NAME_FORMAT = /^[a-zа-я ]+$/i.freeze

  attr_writer :type
  attr_reader :money, :type_default

  def initialize(name, type)
    @name = name
    @money = 100
    @type_default = type
    validate!
  end

  def max_cards?
    true if @hand.count == 3
  end

  def allowed_add_card?
    true if @hand.count == 2
  end

  def overscore?
    calc_hand > MAX_SCORE
  end

  def change_money(val)
    @money += val
    raise @name if @money < 0

    -val
  end

  def give_card(deck)
    @hand << deck.take_card if @hand.count < 3
  end

  def clear_hand
    @hand = []
    @type = @type_default
  end

  def print_cards
    str = ''
    @hand.each do |card|
      card_symbol = @type == :showed ? card.to_s : '**'
      str += "#{card_symbol} "
    end
    str
  end

  def calc_hand
    score = 0
    @hand.each { |card| score += card.cost }
    @hand.each do |card|
      score += 10 if card.name == 'Т' && (score + 10 <= MAX_SCORE)
      # убрал по требованию cost1 (10 для Туза). Мое мнение то что было - было красивее. 
      # В том варианте который у меня был, мы цифири подсчета имели только в одном месте
      # - в инициализации новой колоды. Все! А сейчас что сколько стоит мы имеем в 2х местах.
      # При инициализации колоды и при подсчете (а запихивать в cost array в случае туза - еще хуже, 
      # т.к. только затруднит понимание кода)
      # но раз надо, то надо.
      # Почему +10 а не +11 - т.к. +1 уже был в первоначальном цикле. И нам надо посмотреть
      # улучшит ли +10 положение по очкам. И нам надо ВСЕГДА проходить просчет по всем картам 2 раза
      # т.к. тузов может быть несколько, и считаться они будут по-разному. Первый может дать +10
      # а остальные уже точно не дадут
    end
    score
  end

  def show_score
    @type == :showed ? calc_hand : '???'
  end

  def to_s
    @name
  end

  private

  def validate!
    raise "Имя слишком короткое!" if @name.length < 2
    raise "Имя некорректное, можно только буквы и пробелы" if @name !~ NAME_FORMAT
  end
end

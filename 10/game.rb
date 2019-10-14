class Game
  STAKE = 10
  MAX_SCORE = 21

  def main_menu
    puts "Добро пожаловать в наш санаторий для наслаждающихся игровой зависимостью!"
    puts "У нас вы можете чувствовать в полной безопасности!"
    puts "Ведь в случае необходимости - такси бесплатно!"
    print "Как вас называть? :"
    name = gets.chomp
    @slave = Player.new(name, :showed)
    @master = Player.new('Крупье', :hidden)
    @players = [@master, @slave]
    start_game
  rescue StandardError => e
    puts "Возникла ошибка #{e.message}."
    puts e.backtrace
  end

  private

  def game_over(name)
    puts "===================================================="
    puts "У #{name} нет денег на новую игру. Игра закончилась."
    puts "===================================================="
  end

  def show_table
    puts "===== Стол ====="
    puts "Банк #{@bank}"
    @players.each do |p|
      puts "Игрок #{p.to_s}, карты на руках #{p.print_cards}, деньги на руках #{p.money}"
    end
    puts "==== Сумма моих карт #{@slave.calc_hand}"
  end

  def start_game
    loop do
      @deck = Deck.new
      @players.each(&:clear_hand)
      2.times do
        @players.each { |p| p.give_card @deck }
      end
      @bank = 0
      @players.each do |p|
        @bank += p.change_money -STAKE
      end
      loop do
        @turn_stop = 0
        turn_slave
        turn_master if @turn_stop == 0
        @turn_stop = 1 if @slave.max_cards && @slave.max_cards
        if @turn_stop == 1
          turn_end
          break
        end
      end
    end
  rescue RuntimeError => e
    game_over e.message
  end

  def turn_slave
    show_table
    puts "Ваш ход. Что будете делать?"
    puts "Введите 1, если хотите пропустить ход"
    puts "Введите 2, если хотите добавить карту" if @slave.allowed_add_card
    puts "Введите 3, если хотите открыть карты"
    print "Ваш выбор? :"
    case gets.chomp.to_i
    when 2
      @slave.give_card @deck
      show_table
      @turn_stop = 1 if @slave.calc_hand > MAX_SCORE
    when 3 then @turn_stop = 1
    end
  end

  def turn_master
    puts "Ход игрока #{@master.to_s}"
    if @master.allowed_add_card && @master.calc_hand < 17
      puts "Беру карту"
      @master.give_card @deck
      @turn_stop = 1 if @master.calc_hand > MAX_SCORE     
    else puts "Пропускаю ход"
    end
  end

  def turn_end
    puts "===============  Текущий раунд закончился"
    @master.type = :showed
    show_table
    master_score = @master.calc_hand
    slave_score = @slave.calc_hand
    puts "==== Сумма карт #{@master.to_s} #{master_score}"
    if master_score == slave_score
      puts "Ничья\n\n\n"
      @slave.change_money @bank / 2
      @master.change_money @bank / 2
    elsif master_score > MAX_SCORE || (master_score < slave_score && slave_score <= MAX_SCORE)
      puts "Вы выиграли!\n\n\n"
      @slave.change_money @bank
    else
      puts "Вы проиграли!\n\n\n"
      @master.change_money @bank
    end
    @bank = 0
  end
end

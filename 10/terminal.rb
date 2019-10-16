class TerminalInterface
  attr_accessor :game

  def start_game
    loop do
      puts "===============  Новый раунд"
      @game.turn_new_init
      loop do
        show_table
        @turn_stop = 0
        slave
        master if @turn_stop == 0
        @turn_stop = 1 if @game.turn_stop?
        if @turn_stop == 1
          turn_end
          break
        end
      end
    end
  rescue RuntimeError => e
    game_over e.message
  end

  def turn_end
    puts "===============  Текущий раунд закончился"
    show_table(true)
    case @game.turn_end
    when 1 then puts "Ничья\n\n\n"
    when 2 then puts "Вы выиграли!\n\n\n"
    when 3 then puts "Вы проиграли!\n\n\n"
    end
  end

  def slave
    puts 'Ваш ход. Что будете делать?'
    puts 'Введите 1, если хотите пропустить ход'
    puts 'Введите 2, если хотите добавить карту' if @game.slave_add_card?
    puts 'Введите 3, если хотите открыть карты'
    print 'Ваш выбор? :'
    case gets.chomp.to_i
    when 2
      @game.turn_slave
      @turn_stop = 1 if @game.slave_overscore?
      show_table
    when 3 then @turn_stop = 1
    end
  end

  def master
    puts "Ход игрока #{@game.master.to_s}"
    if @game.turn_master
      puts 'Беру карту'
    else
      puts 'Пропускаю ход'
    end
  end

  def show_error(e)
    puts "Возникла ошибка #{e.message}."
    puts e.backtrace
  end

  def continue_game
    puts ''
    puts 'Введите 1 для того, чтобы начать еще раз'
    gets.chomp.to_i == 1
  end

  def input_name
    puts 'Добро пожаловать в наш санаторий для наслаждающихся игровой зависимостью!'
    puts 'У нас вы можете чувствовать в полной безопасности!'
    puts 'Ведь в случае необходимости - такси бесплатно!'
    print 'Как вас называть? :'
    gets.chomp
  end

  private

  def show_table(change_master = false)
    @game.change_master_view if change_master
    puts '================= Стол ================='
    puts "Банк #{@game.bank}"
    @game.players.each do |p|
      puts "Игрок #{p.to_s}, карты на руках #{p.print_cards}, сумма карт #{p.show_score}, деньги на руках #{p.money}"
    end
    puts
  end

  def game_over(name)
    puts "===================================================="
    puts "У #{name} нет денег на новую игру. Игра закончилась."
    puts "===================================================="
  end
end

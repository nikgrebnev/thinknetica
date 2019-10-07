class RailRoad
  attr_accessor :stations, :trains, :routes

  def initialize
    @stations = []
    @trains = []
    @routes = []
  end

  def menu_main
    loop do
      puts "\n\n#####========= Главное меню =========#####"
      puts "введите число для совершения операции "
      puts " 0 - завершение работы"
      puts " 1 - работа со станциями"
      puts " 2 - работа с маршрутами"
      puts " 3 - работа с поездами"
      puts " 10 - заполнение тестовыми примерами"
      case gets.chomp.to_i
      when 0  then return
      when 1  then menu_stations
      when 2  then menu_routes
      when 3  then menu_trains_main
      when 10 then seed
      end
    end
  end

  private

  def station_list
    puts "\n-------- Список станций на данной железной дороге --------"
    if stations.size > 0 
      stations.each.with_index { |station, i| puts "Cтанция #{i}: #{station.name}" } 
      puts "----------------------------------------------------------"
      true
    else 
      puts "##### станций пока нет! #####"
      false
    end
  end

  def station_create(station_name = "")
    if station_name.empty? 
      print "\n==== Создение новой станции. Введите название:"
      station_name = gets.chomp
    end
    stations.each { |station| return false if station.name == station_name }
    @stations << Station.new(station_name)
  rescue
    puts "!!! Ошибка! Некорректное название станции. Станция не создана"
  end

  def station_print_trains(station)
    if station_exists?(station)
      @stations[station].trains_print.each { |train| puts "Поезд #{train.number}, тип #{train.type.to_s}, количество вагонов #{train.carriages.size}" }
    else
      puts "Станции с таким номером нет. Проверьте корректность ввода"
      return false
    end
  end

  def station_exists?(station)
    station >=0 && station < @stations.size
  end

  def station_list_trains
    puts "\n============ Посмотрете список станций и введите номер станции на которой нужно посмотреть поезда"
    station_list
    print "Введите номер станции, на которой хотите посмотреть поезда:"
    station = gets.chomp.to_i
    station_print_trains(station)
  end

  def menu_stations
    loop do
      puts "\n======= работа со станциями ======"
      puts "введите число для совершения операции "
      puts " 0 - переход в главное меню"
      puts " 1 - просмотр списка станций"
      puts " 2 - создание станции"
      puts " 3 - посмотреть список поездов на станции"
      case gets.chomp.to_i
      when 0 then return
      when 1 then station_list
      when 2 then station_create
      when 3 then station_list_trains
      end
    end
  end
  
  def train_list
    puts "\n-------- Список поездов на данной железной дороге --------"
    if trains.size > 0 
      trains.each.with_index { |train, i| puts "Поезд #{i}: #{train.number}, тип #{train.type.to_s}, количество вагонов #{train.carriages.size}" } 
      puts "----------------------------------------------------------"
      true
    else 
      puts "##### поездов пока нет! #####"
      false
    end
  end

  def train_create_cargo(train_number = nil, num_carriages = nil)
    if train_number.nil?
      print "============  Создание грузового поезда. Введите номер:"
      train_number = gets.chomp
    end
    if num_carriages.nil?
      print "Введите количество вагонов:"
      num_carriages = gets.chomp.to_i
    end
    @trains << CargoTrain.new(train_number, num_carriages)
  rescue Exception => e
    puts "Возникла ошибка #{e.message}. Поезд не создан."
  end

  def train_create_passenger(train_number = nil, num_carriages = nil)
    if train_number.nil?
      print "============  Создание пассажирского поезда. Введите номер:"
      train_number = gets.chomp
    end
    if num_carriages.nil?
      print "Введите количество вагонов:"
      num_carriages = gets.chomp.to_i
    end
    @trains << PassengerTrain.new(train_number, num_carriages)
  rescue Exception => e
    puts "Возникла ошибка #{e.message}. Поезд не создан."
  end
  
  def train_set_route(train, route = nil)
    if route.nil?
      return unless route_list
      print "Введите номер маршрута на который передвигаем поезд:"
      route = gets.chomp.to_i
    end
    @trains[train].new_route(@routes[route])
  end

  def train_move_forward(train)
    @trains[train].move_forward
  end

  def train_manage_menu
    return unless train_list
    print "Введите номер поезда, которым будете управлять:"
    train = gets.chomp.to_i
    if @trains[train].nil?
      puts "--- Такого поезда нет! ---"
      false
    else
      loop do
        puts "\n======= работа с поездом #{@trains[train].number}  ======"
        puts "введите число для совершения операции "
        puts " 0 - переход в вышестоящее меню"
        puts " 1 - назначить маршрут поезду"
        puts " 2 - добавить вагон к поезду"
        puts " 3 - отцепить вагон у поезда"
        puts " 4 - переместить поезд на станцию вперед"
        puts " 5 - переместить поезд на станцию назад"
        puts " 6 - просмотр текущей станции"
        case gets.chomp.to_i
        when 0 then return
        when 1 then train_set_route train
        when 2 then @trains[train].carriage_add
        when 3 then @trains[train].carriage_remove
        when 4 then train_move_forward train
        when 5 then @trains[train].move_back
        when 6 then puts @trains[train].print_station
        end
      end
    end
  end

  def menu_trains_main
    loop do
      puts "\n======= работа с поездами ======"
      puts "введите число для совершения операции "
      puts " 0 - переход в главное меню"
      puts " 1 - просмотр списка поездов"
      puts " 2 - создание cargo поезда"
      puts " 3 - создание passenger поезда"
      puts " 4 - управление поездом"
      case gets.chomp.to_i
      when 0 then return
      when 1 then train_list
      when 2 then train_create_cargo
      when 3 then train_create_passenger
      when 4 then train_manage_menu
      end
    end
  end

  def route_list
    puts "\n----------  Список маршрутов на данной железной дороге ----------"
    if routes.size > 0 
      routes.each.with_index { |route, i| puts "Маршрут #{i}: #{route.to_s}" } 
      puts "-----------------------------------------------------------------"
      true
    else 
      puts "----- маршрутов пока нет! ------"
      false
    end
  end

  def route_create(from = nil, to = nil)
    if from.nil? || to.nil?
      puts "\n\n======== Список номеров станций ========"
      station_list
      print "Введите через пробел номер начальной и конечной станции:"
      from, to = gets.chomp.split(" ").map(&:to_i)
    end
    return if !station_exists?(from) || !station_exists?(to)
    routes << Route.new(@stations[from], @stations[to])
  end

  def route_show(route = nil)
    if route.nil?
      return unless route_list
      print "Введите номер маршрута, который необходимо посмотреть:"
      route = gets.chomp.to_i
    end
    return @routes[route].route_print if @routes[route]
    puts "--- Такого маршрута нет ---"
    false
  end

  def route_station_add(route, station_num = nil)
    if station_num.nil?
      return unless station_list
      print "Введите номер станции, которую надо добавть в маршрут:"
      station_num = gets.chomp.to_i
    end
    station = @stations[station_num]
    return @routes[route].station_add station if station 
    puts "--- Такой станции нет ---"
    false
  end

  def route_station_delete(route, station_num = nil)
    if station_num.nil?
      return unless station_list
      print "Введите номер станции, которую надо удалить из маршрута:"
      station_num = gets.chomp.to_i
    end
    station = @stations[station_num]
    return @routes[route].station_remove station if station 
    puts "--- Такой станции нет ---"
    false
  end

  def route_edit
    return unless route_list
    print "Введите номер маршрута, в который необходимо отредактировать:"
    route = gets.chomp.to_i
    if @routes[route].nil?
      puts "--- Такого маршрута нет ---"
      false
    else
      loop do
        puts "\n======= работа с маршрутом #{@routes[route].to_s}  ======"
        puts "введите число для совершения операции "
        puts " 0 - переход в вышестоящее меню"
        puts " 1 - просмотр маршрута"
        puts " 2 - добавление страниции к маршруту"
        puts " 3 - удаление страниции из маршрута"
        case gets.chomp.to_i
        when 0 then return
        when 1 then route_show route 
        when 2 then route_station_add route 
        when 3 then route_station_delete route 
        end
      end
    end
  end

  def menu_routes
    loop do
      puts "\n======= работа с маршрутами ======"
      puts "введите число для совершения операции "
      puts " 0 - переход в главное меню"
      puts " 1 - просмотр списка маршрутов"
      puts " 2 - создание маршрута"
      puts " 3 - просмотр маршрута"
      puts " 4 - управление маршрутом"
      case gets.chomp.to_i
      when 0 then return
      when 1 then route_list
      when 2 then route_create
      when 3 then route_show
      when 4 then route_edit
      end
    end
  end

  def seed
    station_create "Санкт-Петербург, Московский вокзал"
    station_create "Москва"
    station_create "Бологое"
    station_create "Санкт-Петербург, Финляндский вокзал"
    station_create "Выборг"
    station_create "Удельная"
    station_create "Зеленогорск"
    station_create "Рощино"
    station_create "Горьковское"
    station_create "Ланская"
    station_create "Новая Деревня"
    station_create "Старая Деревня"
    route_create 0,  1
    route_station_add 0, 2
    route_create 3, 11
    route_station_add 1, 9 
    route_station_add 1, 10
    route_station_add 1, 11
    route_create 3,  4
    route_station_add 2, 5
    route_station_add 2, 6
    route_station_add 2, 7
    route_station_add 2, 8
    train_create_cargo("111-11", 12)
    train_create_cargo("111-12", 11)
    train_create_cargo("111-13", 10)
    train_create_cargo("111-14", 9)
    train_create_cargo("111-15", 8)
    train_create_cargo("111-16", 7)
    train_create_cargo("111-17", 6)
    train_create_cargo("111-18", 5)
    train_create_passenger("211-11", 12)
    train_create_passenger("211-12", 11)
    train_create_passenger("211-13", 10)
    train_create_passenger("211-14", 9)
    train_create_passenger("211-15", 8)
    train_create_passenger("211-16", 7)
    train_create_passenger("211-17", 6)
    train_create_passenger("211-18", 5)
    train_set_route(0,0)
    train_set_route(1,1)
    train_move_forward(1)
    train_set_route(2,2)
    train_set_route(3,0)
    train_move_forward(3)
    train_set_route(4,1)
    train_set_route(5,2)
    train_move_forward(5)
    train_set_route(6,0)
    train_set_route(7,1)
    train_move_forward(7)
    train_set_route(8,2)
    train_set_route(9,0)
    train_move_forward(9)
    train_set_route(10,1)
    train_set_route(11,2)
    train_move_forward(11)
    train_set_route(12,0)
    train_set_route(13,1)
    train_move_forward(13)
    train_set_route(14,2)
    train_set_route(15,0)
    # У меня не получается код снизу перевести на Proc.new
#    carriages_block = Proc.new { |carriage| puts "Вагон номер #{carriage_num += 1}, тип #{carriage.type},свободно, #{carriage.free_volume}, занято #{carriage.reserved}" } 
    puts "==================== использование блока для станций ======================="
    Station.all.each do |station|
      puts "====== использование блока для станции #{station.name} ========"
      station.use_block do |train| 
        puts "Поезд #{train.number}, тип #{train.type.to_s}, количество вагонов #{train.carriages.size}"
        puts "--------- использование блока для данного поезда ---------"
        carriage_num = 0
        train.use_block { |carriage| puts "Вагон номер #{carriage_num += 1}, тип #{carriage.type},свободно, #{carriage.free_volume}, занято #{carriage.reserved}" } 
        puts "----------------------------------------------------------"
      end
      puts "======================================================================"
    end
  end
end

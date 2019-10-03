class Train
  include Producer
  include  InstanceCounter

  attr_accessor :speed
  attr_reader :carriages, :number, :type

  def self.find(num)
    t_arr = ObjectSpace.each_object(self).to_a
    puts t_arr.inspect
    t_arr.each { |t| return t if t.number == num }
    nil
  end

  def initialize(number, num_carriages)
    @number = number
    self.register_instance
  end
  
  def brake
    @speed = 0
  end
  
  def carriage_remove
    @carriages.pop  
  end

  def carriage_change(num)
    @carriage += num if @speed == 0 && num.abs == 1
    @carriage = 1 if @carriage < 1
  end

  def print_station
    puts "===== текущая станция: #{@route.route[@current_station].name} ====="
  end

  def new_route(route)
    @route = route
    @current_station = 0
    @route.route[@current_station].train_add(self)
  end

  def move_forward
    if @current_station < (@route.route.length - 1)
      @route.route[@current_station].train_departure(self)
      @current_station += 1
      @route.route[@current_station].train_add(self)
    end
  end

  def move_back
    if @current_station > 0
      @route.route[@current_station].train_departure(self)
      @current_station -= 1
      @route.route[@current_station].train_add(self)
    end
  end

  def where_in_route
    [ @current_station > 0 ? @route.route[@current_station - 1] : nil ,
      @route.route[@current_station] ,
      @current_station < (@route.route.length - 1) ? @route.route[@current_station + 1] : nil 
    ]
  end
end

class Train
  include Functions
  include InstanceCounter
  include Producer
  extend Accessors
  include Validation

  attr_accessor_with_history :speed
  attr_reader :carriages, :number, :type, :num_carriages

  NUMBER_FORMAT = /^[а-яa-z0-9]{3}-{0,1}[а-яa-z0-9]{2}$/i.freeze

  @@trains = {}

  def self.find(num)
    @@trains[num]
    #    t_arr = ObjectSpace.each_object(self).to_a
    #    puts t_arr.inspect
    #    t_arr.each { |t| return t if t.number == num }
  end

  def initialize(number, num_carriages)
    @number = number
    @num_carriages = num_carriages
    validate_train
    register_instance
    @@trains[number] = self
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
    @route.route[@current_station].name
  end

  def new_route(route)
    #    puts "new route #{route.inspect} to train #{self.inspect}"
    @route = route
    @current_station = 0
    @route.route[@current_station].train_add(self)
    #    puts print_station
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
    [@current_station > 0 ? @route.route[@current_station - 1] : nil,
     @route.route[@current_station],
     @current_station < (@route.route.length - 1) ? @route.route[@current_station + 1] : nil]
  end

  def each_carriage
    @carriages.each.with_index(1) { |carriage, i| yield(carriage, i) }
  end

  protected

  def validate_train
    raise 'Пустой номер' unless validate! @number, :presence
    raise 'Некорректное название' unless validate! @number, :format, NUMBER_FORMAT
    raise 'Некорректное количество вагонов' if num_carriages < 1
  end
end

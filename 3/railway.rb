class Station
  attr_reader :trains,:name

  def initialize(name)
    @name = name
    @trains = []
  end

  def train_add(train)
    @trains << train
  end

  def trains_print
    @trains.each { |train| puts train.number }
  end

  def trains_print_type(type)
    @trains.each { |train| puts train.number if train.type == type }
    puts "=== Station #{@name}: count of trains #{type} is #{@trains.select { |train| train.type == type }.size  } ==="
    # вот я лично сильно сомневаюсь, что эта конструкция более читаема чем то что было.
  end
  
  def train_departure(train)
    @trains.delete(train)
  end 
end

class Route
  attr_reader :route

  def initialize(station_from, station_to)
    @route = [station_from, station_to]
  end

  def station_add(station)
    @route.insert(-2, station)
  end

  def station_is_middle(station)
    station != @route[0] && station != @route[-1]
  end

  def station_remove(station)
    @route.delete(station) if station_is_middle
  end

  def route_print
    @route.each { |station| puts station.name }
  end
end

class Train
  attr_accessor :speed
  attr_reader :carriage, :number, :type

  def initialize(number, type, carriage)
    @number = number
    @type = type
    @carriage = carriage
  end
  
  def brake
    @speed = 0
  end
  
  def carriage_change(num)
    @carriage += num if @speed == 0 && num.abs == 1
    @carriage = 1 if @carriage < 1
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


=begin
s1=Station.new("s1")
s2=Station.new("s2")
s3=Station.new("s3")
s4=Station.new("s4")
s5=Station.new("s5")
s6=Station.new("s6")
s7=Station.new("s7")

r1=Route.new(s1,s7)
r2=Route.new(s2,s5)
r3=Route.new(s1,s4)
r1.station_add(s4)
r1.station_add(s2)
r1.station_add(s5)
r2.station_add(s6)
r2.station_add(s7)

   
puts r1
r1.route_print
puts r2
r2.route_print
puts r3
r3.route_print

r1.station_remove(s1)
r1.route_print
r1.station_remove(s7)
r1.route_print
r1.station_remove(s2)
r1.route_print

t1=Train.new(123,"p",11)
t2=Train.new(2112323,"p",12)
t3=Train.new(312323,"t",13)
t4=Train.new(445323,"t",14)

t1.new_route(r1)
t1.where_in_route
t1.move_forward
t1.where_in_route
t1.move_back


s1.trains_print
t2.new_route(r1)
s1.trains_print


t1.speed=20
t1.speed=50
t1.speed=100
t1.brake

=end

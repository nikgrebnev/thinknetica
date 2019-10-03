class Station
  attr_reader :trains,:name

  def self.all
    ObjectSpace.each_object(self).to_a
  end

  def initialize(name)
    @name = name
    @trains = []
  end

  def train_add(train)
    @trains << train
  end

  def trains_print
    puts "---- Поезда на станции #{@name}"
    if @trains.any?
      @trains.each { |train| puts train.number }
    else
      puts "Поездов на станции нет ----"
    end
  end

  def trains_print_type(type)
    @trains.each { |train| puts train.number if train.type == type }
    puts "=== Station #{@name}: count of trains #{type} is #{@trains.select { |train| train.type == type }.size  } ==="
  end
  
  def train_departure(train)
    @trains.delete(train)
  end 
end

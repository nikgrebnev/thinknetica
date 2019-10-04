class Station
  include  InstanceCounter
  attr_reader :trains,:name
  
  @@stations = []

  def self.all
    @@stations
#    ObjectSpace.each_object(self).to_a
  end

  def initialize(name)
    @name = name
    @trains = []
    self.register_instance
    @@stations << self
  end

  def train_add(train)
    @trains << train
  end

  def trains_print
    trains_num = []
    @trains.each { |train| trains_num << train.number }
    trains_num
  end

  def trains_print_type(type)
    trains_by_type = []
    @trains.each { |train| trains_by_type << train.number if train.type == type }
    trains_by_type
  end
  
  def train_departure(train)
    @trains.delete(train)
  end 
end

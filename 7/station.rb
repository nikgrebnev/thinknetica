class Station
  include InstanceCounter, Functions

  attr_reader :trains,:name

  @@stations = []

  NAME_FORMAT = /^[a-яa-z0-9\-, ]+$/i

  def self.all
    @@stations
#    ObjectSpace.each_object(self).to_a
  end

  def initialize(name)
    @name = name
    validate!
    @trains = []
    self.register_instance
    @@stations << self
  end

  def train_add(train)
    @trains << train
  end

  def trains_print
    trains_num = []
    @trains.each { |train| trains_num << train}
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

  def each_train
    @trains.each { |train| yield(train)}
  end

  protected

  def validate!
    raise "Некорректное название" if name !~ NAME_FORMAT
  end
end

class PassengerTrain < Train
  DEFAULT_PASSENGERS = 80

  def initialize(name, num_carriages)
    @type = :passenger
    @carriages = []
    num_carriages.times { @carriages << PassengerCarriage.new(name, DEFAULT_PASSENGERS) }
    super
  end

  def carriage_add
    @carriages << PassengerCarriage.new(@name, DEFAULT_PASSENGERS)
  end
end

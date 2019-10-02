class PassengerTrain < Train

  def initialize(name, num_carriages)
    @type = :passenger
    @carriages = []
    num_carriages.times {@carriages << PassengerCarriage.new(name)}
    super
  end

  def carriage_add
    @carriages << PassengerCarriage.new(@name)
  end
end

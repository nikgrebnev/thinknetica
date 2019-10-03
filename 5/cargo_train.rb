class CargoTrain < Train

  def initialize(name, num_carriages)
    @type = :cargo
    @carriages = []
    num_carriages.times {@carriages << CargoCarriage.new(name)}
    super
  end

  def carriage_add
    @carriages << CargoCarriage.new(@name)
  end
end

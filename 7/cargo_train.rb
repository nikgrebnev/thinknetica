class CargoTrain < Train

  DEFAULT_VOLUME = 150

  def initialize(name, num_carriages)
    @type = :cargo
    @carriages = []
    num_carriages.times {@carriages << CargoCarriage.new(name, DEFAULT_VOLUME)}
    super
  end

  def carriage_add
    @carriages << CargoCarriage.new(@name, DEFAULT_VOLUME)
  end
end

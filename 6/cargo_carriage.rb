class CargoCarriage < Carriage

  def initialize(train_name)
    @type = :cargo
    super
  end
end


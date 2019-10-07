class PassengerCarriage < Carriage
  attr_reader :reserved

  def initialize(train_name, passengers)
    @type = :passenger
    super
  end
end


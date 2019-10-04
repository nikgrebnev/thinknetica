class PassengerCarriage < Carriage

  def initialize(train_name)
    @type = :passenger
    super
  end
end


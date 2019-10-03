class Carriage
  include Producer

  attr_accessor :train_name
  attr_reader :type

  def initialize(train_name)
    @train_name = train_name
  end
end

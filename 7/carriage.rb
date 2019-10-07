class Carriage
  include Producer

  attr_accessor :train_name
  attr_reader :type, :reserved

  def initialize(train_name, total)
    @train_name = train_name
    @total = total
    @reserved = 0
  end

  def free_volume
    @total - @reserved
  end

  def reserve(volume = 1)
    if free_places >= volume
      @reserved += volume
      true
    end
  end

end






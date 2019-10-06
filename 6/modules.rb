module Producer
  attr_accessor :producer

=begin
  def producer_set(producer)
    self.producer = producer
  end

  def producer_get(producer)
    self.producer
  end
=end
end

module InstanceCounter
  def self.included(base)
    base.extend ClassMethods
    base.send :include, InstanceMethods
  end

  module ClassMethods
    attr_writer :instances

    def instances
      @instances ||= 0
    end
  end

  module InstanceMethods

    def register_instance
      self.class.instances += 1
    end

  end
end

module ValidCheck
  def valid?
    validate!
    true
  rescue
    false
  end
end
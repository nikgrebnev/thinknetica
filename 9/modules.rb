module Accessors
  def attr_accessor_with_history(*names)
    names.each do |name|
      var_name = "@#{name}".to_sym
      var_name_history = "@#{name}_history".to_sym

      define_method(name.to_sym) { instance_variable_get(var_name) }

      define_method("#{name}=".to_sym) do |value| 
        instance_variable_set(var_name, value)
        unless instance_variable_get(var_name_history)
          instance_variable_set(var_name_history, [])
        end
        eval( "#{var_name_history} << #{value}" )
      end

      define_method("#{name}_history".to_sym) { instance_variable_get(var_name_history) }
    end
  end

  def strong_attr_accessor(name,type)
      var_name = "@#{name}".to_sym

      define_method("#{name}=".to_sym) do |value|
        if value.instance_cf?(type)
          instance_variable_set(var_name, value)
        else
          raise "wrong type"
        end
      end

      define_method(name.to_sym) { instance_variable_get(var_name) }
  end

end

module Validation
  def self.validate(name, type, *args)
    case type
    when :presence
      name && name != ''
    when :format
      format = args[0]
      name =~ format
    when :type
      name.class = args[0]
    end
  end

  def validate!(name, type, *args)
    Validation.validate(name, type, *args)
  end

#  def valid?
#    validate!
#    true
#  rescue
#    false
#  end
end

module Producer
  attr_accessor :producer

  #   def producer_set(producer)
  #     self.producer = producer
  #   end
  #
  #   def producer_get(producer)
  #     self.producer
  #   end
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

module Functions
  def self.included(base)
    base.send :include, InstanceMethods
  end

  module InstanceMethods
    def valid?
      validate!
      true
    rescue StandardError
      false
    end
  end
end

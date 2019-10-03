module InstanceCounter
  def self.included(base)
    base.extend ClassMethods
    base.send :include, InstanceMethods
  end

  module ClassMethods

#	@@instances = 0

    def instances
	@@instances
    end
  end

  module InstanceMethods
    def register_instance
	@@instances += 1
#register_instance
#, который увеличивает счетчик кол-ва экземпляров класса и который можно вызвать из конструктора. При этом данный метод не должен быть публичным.
    end

    def print_class
      puts self.class
    end
  end
end


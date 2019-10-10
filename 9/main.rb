require_relative 'accessors.rb'
require_relative 'functions.rb'
require_relative 'instance_counter.rb'
require_relative 'producer.rb'
require_relative 'validation.rb'


require_relative 'station'
require_relative 'route'

require_relative 'carriage'
require_relative 'cargo_carriage'
require_relative 'passenger_carriage'

require_relative 'train'
require_relative 'passenger_train'
require_relative 'cargo_train'

require_relative 'railroad'

rr = RailRoad.new

rr.menu_main



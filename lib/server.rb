require 'sinatra'
require_relative './pizzabot'

get '/' do
  neighborhood = params['neighborhood']
  locations = params['locations']
  starting_point = params['starting_point']
  puts "locations: #{locations}"
  puts "neighborhood: #{neighborhood}"
  puts "params: #{params.inspect}"

  if locations.nil?
    [400, '']
  else
    [200, '']
  end

  house1_start = PizzabotHelper::Location.new(locations.split(';')[0])
  house2_e = PizzabotHelper::Location.new(locations.split(';')[1])
  pizzabot = Pizzabot.new

  delivery_instructions = pizzabot.get_directions(
    from_location: house1_start,
    to_location: house2_e
  )
end

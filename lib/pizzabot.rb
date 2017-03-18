require_relative 'pizzabot_helper'

# This is a pizza robot
class Pizzabot
  include PizzabotHelper
  attr_reader :neighborhood, :house_start, :locations

  def initialize(
      neighborhood: PizzabotHelper::Neighborhood.new(0, 0, 5, 5),
      locations: [],
      house_start: PizzabotHelper::Location.new(0, 0)
  )
    @house_start = house_start
    @locations = locations
    @neighborhood = neighborhood
    @location_sorter = ShortestRouteLocationSorter.new(locations)
    @location_sorter.sort
  end

  def get_directions(from_location:, to_location:)
    horizontal_move = get_horizontal_move(
      from_x_coord: from_location.x_coord,
      to_x_coord: to_location.x_coord
    )
    vertical_move = get_vertical_move(
      from_y_coord: from_location.y_coord,
      to_y_coord: to_location.y_coord
    )
    "#{add_move_delivery_instructions(horizontal_move)}"\
      "#{add_move_delivery_instructions(vertical_move)}"
  end

  def deliver
    return 'Sorry, bad address. No pizza for you today!' if bad_location?

    delivery_instructions = ''
    @locations.unshift(@house_start)
    @locations.each_cons(2) do |from_location, to_location|
      delivery_instructions << get_directions(
        from_location: from_location,
        to_location: to_location
      )
      delivery_instructions << 'D'
    end
    delivery_instructions
  end

  def add_move_delivery_instructions(move)
    instructions = ''
    move.number_of_steps.times do
      instructions << move.compass_direction
    end
    instructions
  end

  def bad_location?
    @locations.each do |location|
      return true if
        location.x_coord > (@neighborhood.max_y - 1) ||
        location.y_coord > (@neighborhood.max_x - 1)
    end
    false
  end
end

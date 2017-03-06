gem 'minitest', '~> 5.8'
require 'minitest/autorun'
require 'minitest/pride'
require_relative '../lib/pizzabot'

class PizzabotTest < Minitest::Test
  def test_delivery_with_north_direction
    house1_start = Pizzabot::Location.new(0, 0)
    house2_n = Pizzabot::Location.new(0, 1)
    pizzabot = Pizzabot.new

    delivery_instructions = pizzabot.get_directions(from_location: house1_start, to_location: house2_n)

    assert_equal "N", delivery_instructions
  end

  def test_delivery_with_south_direction
    house1_start = Pizzabot::Location.new(0, 1)
    house2_s = Pizzabot::Location.new(0, 0)
    pizzabot = Pizzabot.new

    delivery_instructions = pizzabot.get_directions(from_location: house1_start, to_location: house2_s)

    assert_equal "S", delivery_instructions
  end

  def test_delivery_with_east_direction
    house1_start = Pizzabot::Location.new(0, 0)
    house2_e = Pizzabot::Location.new(1, 0)
    pizzabot = Pizzabot.new

    delivery_instructions = pizzabot.get_directions(from_location: house1_start, to_location: house2_e)

    assert_equal "E", delivery_instructions
  end

  def test_delivery_with_west_direction
    house1_start = Pizzabot::Location.new(1, 0)
    house2_w = Pizzabot::Location.new(0, 0)
    pizzabot = Pizzabot.new

    delivery_instructions = pizzabot.get_directions(from_location: house1_start, to_location: house2_w)

    assert_equal "W", delivery_instructions
  end

  def test_delivery_with_multiple_directions_and_locations
    house1_start = Pizzabot::Location.new(0, 0)
    house2_ennn = Pizzabot::Location.new(1, 3)
    house3_eeen = Pizzabot::Location.new(4, 4)
    house4_ss = Pizzabot::Location.new(4, 2)
    house5_no_move = Pizzabot::Location.new(4, 2)
    house6_wwwws = Pizzabot::Location.new(0, 1)
    house7_eeen = Pizzabot::Location.new(3, 2)
    house8_wn = Pizzabot::Location.new(2, 3)
    house9_eess = Pizzabot::Location.new(4, 1)

    locations = [
      house2_ennn,
      house3_eeen,
      house4_ss,
      house5_no_move,
      house6_wwwws,
      house7_eeen,
      house8_wn,
      house9_eess
    ]
    pizzabot = Pizzabot.new(house_start: house1_start, locations: locations)

    delivery_instructions = pizzabot.deliver

    assert_equal "ENNNDEEENDSSDDWWWWSDEEENDWNDEESSD", delivery_instructions
  end

  def test_bad_location
    house_bad_location = Pizzabot::Location.new(100, 100)
    locations = [house_bad_location]
    pizzabot = Pizzabot.new(locations: locations)

    bad_location_message = pizzabot.deliver

    expected_message = "Sorry, bad address. No pizza for you today!"
    assert_equal expected_message, bad_location_message
  end

  def test_5_x_5_neighborhood_default
    pizzabot = Pizzabot.new

    neighborhood = Pizzabot::Neighborhood.new(0, 0, 5, 5)

    assert_equal neighborhood, pizzabot.neighborhood
  end

  def test_house_start_default
    pizzabot = Pizzabot.new

    house_start = Pizzabot::Location.new(0, 0)

    assert_equal house_start, pizzabot.house_start
  end

  def test_empty_location_array_default
    pizzabot = Pizzabot.new

    empty_locations = []

    assert_equal empty_locations, pizzabot.locations
  end
end

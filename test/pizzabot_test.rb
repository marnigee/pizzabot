gem 'minitest', '~> 5.8'
require 'minitest/autorun'
require 'minitest/pride'
require_relative '../lib/pizzabot'
require_relative '../lib/shortest_route_location_sorter'
require_relative '../lib/default_location_sorter'

class PizzabotTest < Minitest::Test
  def test_delivery_with_north_direction
    house1_start = PizzabotHelper::Location.new(0, 0)
    house2_n = PizzabotHelper::Location.new(0, 1)
    pizzabot = Pizzabot.new

    delivery_instructions = pizzabot.get_directions(
      from_location: house1_start,
      to_location: house2_n
    )

    assert_equal 'N', delivery_instructions
  end

  def test_delivery_with_south_direction
    house1_start = PizzabotHelper::Location.new(0, 1)
    house2_s = PizzabotHelper::Location.new(0, 0)
    pizzabot = Pizzabot.new

    delivery_instructions = pizzabot.get_directions(
      from_location: house1_start,
      to_location: house2_s
    )

    assert_equal 'S', delivery_instructions
  end

  def test_delivery_with_east_direction
    house1_start = PizzabotHelper::Location.new(0, 0)
    house2_e = PizzabotHelper::Location.new(1, 0)
    pizzabot = Pizzabot.new

    delivery_instructions = pizzabot.get_directions(
      from_location: house1_start,
      to_location: house2_e
    )

    assert_equal 'E', delivery_instructions
  end

  def test_delivery_with_west_direction
    house1_start = PizzabotHelper::Location.new(1, 0)
    house2_w = PizzabotHelper::Location.new(0, 0)
    pizzabot = Pizzabot.new

    delivery_instructions = pizzabot.get_directions(
      from_location: house1_start,
      to_location: house2_w
    )

    assert_equal 'W', delivery_instructions
  end

  def test_delivery_with_multiple_directions_and_locations
    pizzabot = setup_multiple_test

    delivery_instructions = pizzabot.deliver

    assert_equal 'ENNNDEEENDSSDDWWWWSDEEENDWNDEESSD', delivery_instructions
  end

  def test_bad_location
    house_bad_location = PizzabotHelper::Location.new(100, 100)
    locations = [house_bad_location]
    pizzabot = Pizzabot.new(locations: locations)

    bad_location_message = pizzabot.deliver

    expected_message = 'Sorry, bad address. No pizza for you today!'
    assert_equal expected_message, bad_location_message
  end

  def test_5_x_5_neighborhood_default
    pizzabot = Pizzabot.new

    neighborhood = PizzabotHelper::Neighborhood.new(0, 0, 5, 5)

    assert_equal neighborhood, pizzabot.neighborhood
  end

  def test_house_start_default
    pizzabot = Pizzabot.new

    house_start = PizzabotHelper::Location.new(0, 0)

    assert_equal house_start, pizzabot.house_start
  end

  def test_empty_location_array_default
    pizzabot = Pizzabot.new

    empty_locations = []

    assert_equal empty_locations, pizzabot.locations
  end

  def test_distance
    house1_start = PizzabotHelper::Location.new(0, 0)
    house2_ennn = PizzabotHelper::Location.new(1, 3)
    route_sorter = ShortestRouteLocationSorter.new(
      [house1_start, house2_ennn]
    )

    four_steps = route_sorter.distance(house1_start, house2_ennn)

    assert_equal four_steps, 4
  end

  def test_fastest_route_sorter
    house_furthest = PizzabotHelper::Location.new(3, 0)
    house_closest = PizzabotHelper::Location.new(1, 0)
    house_midway = PizzabotHelper::Location.new(2, 0)
    route_sorter = ShortestRouteLocationSorter.new(
      [house_furthest, house_closest, house_midway]
    )

    fastest_route = route_sorter.sort

    assert_equal fastest_route, [house_closest, house_midway, house_furthest]
  end

  private

  def setup_multiple_test
    house1_start = PizzabotHelper::Location.new(0, 0)
    Pizzabot.new(
      house_start: house1_start,
      locations: delivery_houses.values
    )
  end

  def delivery_houses
    {}.tap do |hash|
      hash[:house2_ennn] = PizzabotHelper::Location.new(1, 3)
      hash[:house3_eeen] = PizzabotHelper::Location.new(4, 4)
      hash[:house4_ss] = PizzabotHelper::Location.new(4, 2)
      hash[:house5_no_move] = PizzabotHelper::Location.new(4, 2)
      hash[:house6_wwwws] = PizzabotHelper::Location.new(0, 1)
      hash[:house7_eeen] = PizzabotHelper::Location.new(3, 2)
      hash[:house8_wn] = PizzabotHelper::Location.new(2, 3)
      hash[:house9_eess] = PizzabotHelper::Location.new(4, 1)
    end
  end
end

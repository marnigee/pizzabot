gem 'minitest', '~> 5.8'
require 'minitest/autorun'
require 'minitest/pride'
require_relative '../lib/pizzabot'

class PizzabotTest < Minitest::Test
  def test_delivery_with_N_direction
    house_start = Pizzabot::Location.new(0, 0)
    house_1_step_north = Pizzabot::Location.new(1, 0)
    locations = [house_start, house_1_step_north]
    pizzabot = Pizzabot.new(house_start: house_start, locations: locations)

    delivery_instructions = pizzabot.deliver

    assert_equal "ND", delivery_instructions
  end

  def test_delivery_with_S_direction
    house_start = Pizzabot::Location.new(1, 0)
    house_1_step_south = Pizzabot::Location.new(0, 0)
    locations = [house_start, house_1_step_south]
    pizzabot = Pizzabot.new(house_start: house_start,locations: locations)

    delivery_instructions = pizzabot.deliver

    assert_equal "SD", delivery_instructions
  end

  def test_delivery_with_E_direction
    house_start = Pizzabot::Location.new(0, 0)
    house_1_step_east = Pizzabot::Location.new(0, 1)
    locations = [house_start, house_1_step_east]
    pizzabot = Pizzabot.new(house_start: house_start,locations: locations)

    delivery_instructions = pizzabot.deliver

    assert_equal "ED", delivery_instructions
  end

  def test_delivery_with_W_direction
    house_start = Pizzabot::Location.new(0, 1)
    house_1_step_west = Pizzabot::Location.new(0, 0)
    locations = [house_start, house_1_step_west]
    pizzabot = Pizzabot.new(house_start: house_start,locations: locations)

    delivery_instructions = pizzabot.deliver

    assert_equal "WD", delivery_instructions
  end

  def test_delivery_with_multiple_directions
    house_start = Pizzabot::Location.new(0, 0)
    house_2_steps_east_1_step_north = Pizzabot::Location.new(1, 2)
    house_3_steps_north = Pizzabot::Location.new(4, 2)
    house_2_steps_east_3_steps_south = Pizzabot::Location.new(1, 4)
    locations = [
        house_start,
        house_2_steps_east_1_step_north,
        house_3_steps_north,
        house_2_steps_east_3_steps_south
    ]
    pizzabot = Pizzabot.new(house_start: house_start,locations: locations)

    delivery_instructions = pizzabot.deliver

    assert_equal "NEENNNSSSEED", delivery_instructions
  end

  def test_bad_location
    house_bad_location = Pizzabot::Location.new(100, 100)
    locations = [house_bad_location]
    pizzabot = Pizzabot.new(locations: locations)

    bad_location_message = pizzabot.deliver

    expected_message = "Sorry, bad address. No pizza for you today!"
    assert_equal expected_message, bad_location_message
  end
end

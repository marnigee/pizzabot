gem 'minitest', '~> 5.8'
require 'minitest/autorun'
require 'minitest/pride'
require 'rack/test'
require_relative '../lib/pizzabot'
require_relative '../lib/server'
require_relative '../lib/shortest_route_location_sorter'
require_relative '../lib/default_location_sorter'

class PizzabotTest < Minitest::Test
  include Rack::Test::Methods
  def app
    Sinatra::Application
  end

  def test_my_default
    get '/'
    assert_equal 400, last_response.status
  end

  def test_responds_with_empty_ok_response_if_given_empty_locations
    get '/', locations: '', neighborhood: '0;0;5;5', starting_point: '0;0'
    assert_equal 200, last_response.status
    assert_equal '', last_response.body
  end

  def test_pizzabot_response
    get '/', locations: '0,0;1,0', neighborhood: '0;0;5;5', starting_point: '0;0'
    assert_equal 200, last_response.status
    assert_equal 'E', last_response.body
  end
end

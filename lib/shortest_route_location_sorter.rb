# This is a shortest route location sorter
class ShortestRouteLocationSorter
  include PizzabotHelper
  def initialize(locations, house_start = PizzabotHelper::Location.new(0, 0))
    @locations = locations
    @house_start = house_start
  end

  def sort
    @locations.sort do |x, y|
      distance(@house_start, x) <=> distance(@house_start, y)
    end
  end
end

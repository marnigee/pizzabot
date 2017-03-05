class Pizzabot
  def initialize(neighborhood: Neighborhood.new(0, 0, 5, 5), locations: [], house_start: Location.new(0,0))
    @locations = locations
    @neighborhood = neighborhood
    @house_start = house_start
  end

  def get_directions(from_location:, to_location:)
    delivery_instructions = ''
    vertical_move = get_vertical_move(from_lattitude: from_location.lattitude, to_lattitude: to_location.lattitude)
    vertical_move.number_of_steps.times do
      delivery_instructions << vertical_move.compass_direction       
    end
    horizontal_move = get_horizontal_move(from_location: from_location, to_location: to_location)
    horizontal_move.number_of_steps.times do
      delivery_instructions << horizontal_move.compass_direction      
    end
    delivery_instructions
  end

  def deliver
    return "Sorry, bad address. No pizza for you today!" if bad_location?
    delivery_instructions = ''
    @locations.insert(0, @house_start)
    @locations.each_cons(2){ |locations|
      delivery_instructions << get_directions(from_location: locations[0], to_location: locations[1])
    }
    delivery_instructions << 'D'
  end

  Neighborhood = Struct.new(:min_x, :min_y, :max_x, :max_y, )
  Location = Struct.new(:lattitude, :longitude)
  Move = Struct.new(:compass_direction, :number_of_steps)

  private

  def get_vertical_move(from_lattitude:, to_lattitude:)
    vertical_steps = to_lattitude - from_lattitude
    move = Move.new('', 0)
    if vertical_steps < 0
      move = Move.new('S', vertical_steps.abs)
    elsif vertical_steps > 0
      move = Move.new('N', vertical_steps)
    end
    move
  end

  def get_horizontal_move(from_location:, to_location:)
    horizontal_steps = to_location.longitude - from_location.longitude
    move = Move.new('', 0)
    if horizontal_steps < 0
      move = Move.new('W', horizontal_steps.abs)
    elsif horizontal_steps > 0
      move = Move.new('E', horizontal_steps)
    end
    move
  end

  def bad_location?
    @locations.each do |location|
      if location.lattitude > (@neighborhood.max_y - 1)
        return true
      end
      if location.longitude > (@neighborhood.max_x - 1)
        return true
      end
    end
    return false
  end
end

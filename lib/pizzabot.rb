class Pizzabot
  attr_reader :neighborhood, :house_start, :locations

  def initialize(neighborhood: Neighborhood.new(0, 0, 5, 5), locations: [], house_start: Location.new(0, 0))
    @locations = locations
    @neighborhood = neighborhood
    @house_start = house_start
  end

  def get_directions(from_location:, to_location:)
    delivery_instructions = ''
    horizontal_move = get_horizontal_move(from_x_coord: from_location.x_coord, to_x_coord: to_location.x_coord)
    delivery_instructions << add_move_delivery_instructions(horizontal_move)
    vertical_move = get_vertical_move(from_y_coord: from_location.y_coord, to_y_coord: to_location.y_coord)
    delivery_instructions << add_move_delivery_instructions(vertical_move)
  end

  def deliver
    return "Sorry, bad address. No pizza for you today!" if bad_location?
    delivery_instructions = ''
    @locations.unshift(@house_start)
    @locations.each_cons(2) do |from_location, to_location|
      delivery_instructions << get_directions(from_location: from_location, to_location: to_location)
      delivery_instructions << 'D'
    end
    delivery_instructions
  end

  Neighborhood = Struct.new(:min_x, :min_y, :max_x, :max_y)
  Location = Struct.new(:x_coord, :y_coord)
  Move = Struct.new(:compass_direction, :number_of_steps)

  private

  def get_vertical_move(from_y_coord:, to_y_coord:)
    move = Move.new('', 0)
    if to_y_coord > from_y_coord
      move = move_north(to_y_coord - from_y_coord)
    elsif to_y_coord < from_y_coord
      move = move_south(from_y_coord - to_y_coord)
    end
    move
  end

  def get_horizontal_move(from_x_coord:, to_x_coord:)
    move = Move.new('', 0)
    if to_x_coord > from_x_coord
      move = move_east(to_x_coord - from_x_coord)
    elsif to_x_coord < from_x_coord
      move = move_west(from_x_coord - to_x_coord)
    end
    move
  end

  def move_north(number_of_steps)
    Move.new('N', number_of_steps)
  end

  def move_south(number_of_steps)
    Move.new('S', number_of_steps)
  end

  def move_east(number_of_steps)
    Move.new('E', number_of_steps)
  end

  def move_west(number_of_steps)
    Move.new('W', number_of_steps)
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
      if location.x_coord > (@neighborhood.max_y - 1)
        return true
      end
      if location.y_coord > (@neighborhood.max_x - 1)
        return true
      end
    end
    false
  end
end

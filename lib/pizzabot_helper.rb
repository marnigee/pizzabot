# This is a pizza robot helper
module PizzabotHelper
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
    PizzabotHelper::Move.new('N', number_of_steps)
  end

  def move_south(number_of_steps)
    PizzabotHelper::Move.new('S', number_of_steps)
  end

  def move_east(number_of_steps)
    PizzabotHelper::Move.new('E', number_of_steps)
  end

  def move_west(number_of_steps)
    PizzabotHelper::Move.new('W', number_of_steps)
  end

  def distance(from_location, to_location)
    horizontal_move = get_horizontal_move(
      from_x_coord: from_location.x_coord,
      to_x_coord: to_location.x_coord
    )
    vertical_move = get_vertical_move(
      from_y_coord: from_location.y_coord,
      to_y_coord: to_location.y_coord
    )
    horizontal_move.number_of_steps + vertical_move.number_of_steps
  end

  Neighborhood = Struct.new(:min_x, :min_y, :max_x, :max_y)
  Location = Struct.new(:x_coord, :y_coord)
  Move = Struct.new(:compass_direction, :number_of_steps)
end

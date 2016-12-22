require 'byebug'
class Board

  def initialize
    @grid = Array.new(9) {Array.new(9) }
  end

  def rows
  end

  def [](pos)
    x, y = pos
    grid[x][y]
  end

  def []=(pos, value)
    x, y = pos
    tile = grid[x][y]
    tile.value = value
  end

  def generate_bombs
    10.times do
      test_row = rand(9)
      test_col = rand(9)

      until grid[test_row][test_col].nil?
        test_row = rand(9)
        test_col = rand(9)
      end

      grid[test_row][test_col] = "b"
    end
  end

  def render
    puts "  #{(0..8).to_a.join(" ")}"
    grid.each_with_index do |row, i|
      print "#{i} "
      row.each do |square|
        if square.nil? || square == "b"
          print "* "
        else
          print "#{square} "
        end
      end

      puts ""
    end
  end

  def check_square(x, y)
    check_adjacent_squares(x, y)
    grid[x, y]
  end

  def check_adjacent_squares(x, y)
    return grid[x, y] if grid[x, y] == "F" || num_adjacent_bombs(grid[x, y]) > 0

  end

  def num_adjacent_bombs(x, y)
    count = 0
    (-1..1).each do |i|
      (-1..1).each do |j|
        next if x + i < 0 || x + i > 8
        next if y + j < 0 || y + j > 8
        next if i == 0 && j == 0
        count += 1 if grid[x + i, y + j] == "b"
      end
    end
   count
  end


  # def cols
  #   @cols = grid.transponse
  # end

  attr_reader :grid, :cols

end

b = Board.new
b.generate_bombs
p b.render

module Minesweeper
  class Grid
    def initialize(cells)
      @cells = cells
    end

    attr_reader :cells
    private     :cells

    def width
      cells.first.size
    end

    def height
      cells.size
    end

    def [](x, y)
      cells[y][x]
    end

    def neighbors(x, y)
      [ [-1, -1], [ 0, -1], [ 1, -1],
        [-1,  0],           [ 1,  0],
        [-1,  1], [ 0,  1], [ 1,  1] ].map { |x_offset, y_offset|
        neighbor_x, neighbor_y = x + x_offset, y + y_offset
        if neighbor_x.between?(0, width  - 1) &&
           neighbor_y.between?(0, height - 1)
          self[neighbor_x, neighbor_y]
        else
          nil
        end
      }.compact
    end

    def count_bombs_around(x, y)
      neighbors(x, y).count { |cell| cell == "X" }
    end

    def count_all
      Array.new(height) { |y|
        Array.new(width) { |x|
          if self[x, y] == "X"
            -1
          else
            count_bombs_around(x, y)
          end
        }
      }
    end
  end
end

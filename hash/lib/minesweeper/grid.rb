module Minesweeper
  class Grid
    def initialize(cells)
      @width  = cells.first.size
      @height = cells.size
      @cells  = Hash[ cells.flat_map.with_index { |row, y|
        row.map.with_index { |cell, x| [[x, y], cell] }
      } ]
    end

    attr_reader :width, :height

    attr_reader :cells
    private     :cells

    def [](x, y)
      cells[[x, y]]
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

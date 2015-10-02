require_relative "minesweeper/grid"

module Minesweeper
  module_function

  def count(cells)
    Grid.new(cells).count_all
  end
end

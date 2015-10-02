require_relative "../lib/minesweeper/grid"

describe Minesweeper::Grid do
  let(:grid) { Minesweeper::Grid.new(
    [ [" ", "X", " "],
      ["X", " ", " "],
      [" ", " ", " "],
      [" ", " ", " "] ]
  ) }

  it "knows the width and height" do
    expect(grid.width).to  eq(3)
    expect(grid.height).to eq(4)
  end

  it "accesses individual cells" do
    expect(grid[0, 0]).to eq(" ")
    expect(grid[1, 0]).to eq("X")
    expect(grid[0, 1]).to eq("X")
    expect(grid[1, 1]).to eq(" ")
  end

  it "lists neighbors of a cell" do
    expect(grid.neighbors(0, 0)).to eq(["X", "X", " "])
    expect(grid.neighbors(0, 1)).to eq([" ", "X", " ", " ", " "])
    expect(grid.neighbors(1, 1)).to eq([" ", "X", " ", "X", " ", " ", " ", " "])
  end

  it "counts bombs around a cell" do
    expect(grid.count_bombs_around(0, 0)).to eq(2)
    expect(grid.count_bombs_around(2, 1)).to eq(1)
    expect(grid.count_bombs_around(2, 2)).to eq(0)
  end

  it "counts all cells" do
    expect(grid.count_all).to eq(
      [ [ 2, -1,  1],
        [-1,  2,  1],
        [ 1,  1,  0],
        [ 0,  0,  0] ]
    )
  end
end

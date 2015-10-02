require_relative "../lib/minesweeper"

describe Minesweeper do
  it "counts all neighboring bombs" do
    expect(
      Minesweeper.count(
        [ [" ", " "],
          ["X", "X"] ]
      )
    ).to eq(
      [ [ 2,  2],
        [-1, -1] ]
    )
  end
end

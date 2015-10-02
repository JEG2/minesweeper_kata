module Tests where

import ElmTest.Assertion exposing (..)
import ElmTest.Test exposing (..)

import Minesweeper


grid : List (List String)
grid =
    [ [" ", "X", " "]
    , ["X", " ", " "]
    , [" ", " ", " "]
    , [" ", " ", " "]
    ]


all : Test
all =
  suite "Minesweeper"
        [ test "knows the width of a grid"
               (assertEqual 3 (Minesweeper.gridWidth grid))
        , test "knows the height of a grid"
               (assertEqual 4 (Minesweeper.gridHeight grid))
        , test "accesses a corner cell"
               (assertEqual " "
                            (Maybe.withDefault "-" (Minesweeper.cellAt 0 0 grid)))
        , test "accesses a top middle cell"
               (assertEqual "X"
                            (Maybe.withDefault "-" (Minesweeper.cellAt 1 0 grid)))
        , test "accesses a left cell on the second row"
               (assertEqual "X"
                            (Maybe.withDefault "-" (Minesweeper.cellAt 0 1 grid)))
        , test "accesses a middle cell on the second row"
               (assertEqual " "
                            (Maybe.withDefault "-" (Minesweeper.cellAt 1 1 grid)))
        , test "lists neighbors of a corner cell"
               (assertEqual ["X", "X", " "]
                            (Minesweeper.neighborsOf 0 0 grid))
        , test "lists neighbors of a side cell"
               (assertEqual [" ", "X", " ", " ", " "]
                            (Minesweeper.neighborsOf 0 1 grid))
        , test "lists neighbors of a center cell"
               (assertEqual [" ", "X", " ", "X", " ", " ", " ", " "]
                            (Minesweeper.neighborsOf 1 1 grid))
        , test "counts multiple bombs around a cell"
               (assertEqual 2 (Minesweeper.countBombsAround 0 0 grid))
        , test "counts a bomb next to a cell"
               (assertEqual 1 (Minesweeper.countBombsAround 2 1 grid))
        , test "counts no bombs around a cell"
               (assertEqual 0 (Minesweeper.countBombsAround 2 2 grid))
        , test "counts all cells"
               (assertEqual
                 [ [ 2, -1,  1]
                 , [-1,  2,  1]
                 , [ 1,  1,  0]
                 , [ 0,  0,  0]
                 ]
                 (Minesweeper.count grid))
        ]

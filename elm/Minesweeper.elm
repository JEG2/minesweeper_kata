module Minesweeper where

import Array exposing (Array)


gridWidth : List (List String) -> Int
gridWidth grid =
  List.length (Maybe.withDefault [ ] (List.head grid))


gridHeight : List (List String) -> Int
gridHeight grid =
  List.length grid


cellAt : Int -> Int -> List (List String) -> Maybe String
cellAt x y grid =
  grid
    |> gridToArrayOfArrays
    |> arrayOfArraysCellAt x y


gridToArrayOfArrays : List (List String) -> Array (Array String)
gridToArrayOfArrays grid =
  grid
    |> List.map Array.fromList
    |> Array.fromList


arrayOfArraysCellAt : Int -> Int -> Array (Array String) -> Maybe String
arrayOfArraysCellAt x y grid =
  grid
    |> Array.get y
    |> Maybe.withDefault (Array.empty)
    |> Array.get x


neighborsOf : Int -> Int -> List (List String) -> List String
neighborsOf x y grid =
  [ (-1, -1), ( 0, -1), ( 1, -1)
  , (-1,  0),           ( 1,  0)
  , (-1,  1), ( 0,  1), ( 1,  1)
  ]
    |> List.filterMap (neighborOf x y (gridToArrayOfArrays grid))


neighborOf : Int -> Int -> Array (Array String) -> (Int, Int) -> Maybe String
neighborOf x y arrayOfArrays (xOffset, yOffset) =
  let
    neighborX =
      x + xOffset
    neighborY =
      y + yOffset
    arrayOfArraysWidth arrayOfArrays =
      arrayOfArrays
        |> Array.get 0
        |> Maybe.withDefault (Array.empty)
        |> Array.length
    arrayOfArraysHeight arrayOfArrays =
      Array.length arrayOfArrays
    inArrayOfArrays x y arrayOfArrays =
      x >= 0 && x < arrayOfArraysWidth arrayOfArrays && 
      y >= 0 && y < arrayOfArraysHeight arrayOfArrays
  in
    if inArrayOfArrays neighborX neighborY arrayOfArrays then
      arrayOfArraysCellAt neighborX neighborY arrayOfArrays
    else
      Nothing


countBombsAround : Int -> Int -> List (List String) -> Int
countBombsAround x y grid =
  grid
    |> neighborsOf x y
    |> List.filter (\c -> c == "X")
    |> List.length


count : List (List String) -> List (List Int)
count grid =
  List.indexedMap
    (\y row ->
      List.indexedMap
        (\x cell ->
           if cell == "X" then -1 else countBombsAround x y grid)
        row)
    grid

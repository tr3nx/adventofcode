--- Day 4: Secure Container ---

import Data.List (group)

-- part one
hasIncreasing :: [Char] -> [Bool]
hasIncreasing []     = []
hasIncreasing (x:[]) = [True]
hasIncreasing (x:xs) = [fromEnum x <= (fromEnum $ head xs)] ++ hasIncreasing xs

-- part two
doublesNotLargerGroup :: [Char] -> Bool
doublesNotLargerGroup xs = any (\x -> (length x) == 2) $ group xs

solve :: String -> String
solve s = show $ length $
  [n | n <- map show [low .. high]
  , doublesNotLargerGroup n
  , and $ hasIncreasing n]
 where
  low  = (read $ take 6 s) :: Int
  high = (read $ drop 7 s) :: Int

main = do
 let inputs = "234208-765869"
 putStrLn $ "Answer: " ++ solve inputs

--- Day 4: Secure Container ---

import Data.List

-- part one
hasDoubles :: [Char] -> Bool
hasDoubles xs = (length
 $ head
 $ sortBy (\x y -> compare (length y) (length x))
 $ groupBy (==) xs) > 1

hasIncreasing :: [Char] -> [Bool]
hasIncreasing []     = []
hasIncreasing (x:[]) = [True]
hasIncreasing (x:xs) = [fromEnum x <= (fromEnum $ head xs)] ++ hasIncreasing xs

solve :: String -> Int
solve s = length $ [n | n <- [low .. high]
                      , hasDoubles (show n)
                      , and $ hasIncreasing (show n)]
 where
  low  = (read $ take 6 s) :: Int
  high = (read $ drop 7 s) :: Int

main = do
 let inputs = "234208-765869"
 putStrLn $ "Answer: " ++ show (solve inputs)

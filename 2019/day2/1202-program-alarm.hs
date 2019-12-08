--- Day 2: 1202 Program Alarm ---

replaceAt :: Int -> Int -> [Int] -> [Int]
replaceAt n x xs
 | length ys > 0 = init ys ++ [x] ++ zs
 | otherwise     = [x] ++ tail zs
 where
  (ys,zs) = splitAt (n + 1) xs

-- part one
intCodeInterp :: Int -> [Int] -> [Int]
intCodeInterp n xs =
 case op of
  1  -> intCodeInterp (n + 4) $ replaceAt d (v1 + v2) xs
  2  -> intCodeInterp (n + 4) $ replaceAt d (v1 * v2) xs
  99 -> xs
  where
   v1          = (xs !! s1)
   v2          = (xs !! s2)
   rest        = drop n xs
   (op:_)      = rest
   (_:s1:_)    = rest
   (_:_:s2:_)  = rest
   (_:_:_:d:_) = rest

-- part two
intCodeRun :: Int -> Int -> [Int] -> Int
intCodeRun noun verb xs = head $ intCodeInterp 0 (replaceAt 1 noun $ replaceAt 2 verb xs)

solve :: [Int] -> Int
solve xs = (100 * fst nv) + snd nv
 where
  nv = head [
   (noun, verb)
   | noun <- [0..99]
   , verb <- [0..99]
   , (intCodeRun noun verb xs) == 19690720]

main = do
 let codes = [1,0,0,3,1,1,2,3,1,3,4,3,1,5,0,3,2,6,1,19,1,5,19,23,2,6,23,27,1,27,5,31,2,9,31,35,1,5,35,39,2,6,39,43,2,6,43,47,1,5,47,51,2,9,51,55,1,5,55,59,1,10,59,63,1,63,6,67,1,9,67,71,1,71,6,75,1,75,13,79,2,79,13,83,2,9,83,87,1,87,5,91,1,9,91,95,2,10,95,99,1,5,99,103,1,103,9,107,1,13,107,111,2,111,10,115,1,115,5,119,2,13,119,123,1,9,123,127,1,5,127,131,2,131,6,135,1,135,5,139,1,139,6,143,1,143,6,147,1,2,147,151,1,151,5,0,99,2,14,0,0]
 putStrLn $ "Answer: " ++ show (solve codes)
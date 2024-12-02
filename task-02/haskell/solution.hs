digits :: Int -> [Int]
digits 0 = []
digits x = digits (div x 10) ++ [mod x 10]

digitSum :: Int -> Int
digitSum x = sum (digits x)

getPrimes :: [Int]
getPrimes = 2 : getPrimes'
    where
        getPrimes' = 3 : filter (isPrime getPrimes') [5, 7 ..]

isPrime :: [Int] -> Int -> Bool
isPrime (p : ps) x
    | p * p > x = True
    | otherwise = (mod x p /= 0) && isPrime ps x

isSpecialPrime :: (Int, Int) -> Bool
isSpecialPrime (position, prime) = digitSum position == digitSum prime

main = do
    print $ sum . take 10000 . map snd . filter isSpecialPrime $ zip [1::Int ..] getPrimes
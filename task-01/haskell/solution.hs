lineLength :: Int
lineLength = 9

xMax :: Int
xMax = 5

yMax :: Int
yMax = 30

getLinesFromFile :: String -> IO [String]
getLinesFromFile file = do
    contents <- readFile file
    let fileLines = lines contents
    return fileLines

padToLineLength :: String -> String
padToLineLength input = if length input == lineLength then input else padToLineLength (input ++ " ")

cozyScoreForLine :: String -> String -> Int
cozyScoreForLine target cover = sum $ zipWith cozyCompare target cover

cozyCompare :: Char -> Char -> Int
cozyCompare target cover = if cover == 'x' && target /= ' ' then read [target] :: Int else 0

yOffsetBlanket :: [String] -> Int -> [String]
yOffsetBlanket blanket yOffset = replicate yOffset " " ++ blanket

xOffsetBlanket :: [String] -> Int -> [String]
xOffsetBlanket blanket xOffset = map (\x -> take xOffset (cycle " ") ++ x) blanket

cozyScoreYOffset :: [String] -> [String] -> Int -> Int
cozyScoreYOffset target blanket offset = sum $ zipWith cozyScoreForLine target (yOffsetBlanket blanket offset)

cozyScoreY :: [String] -> [String] -> Int
cozyScoreY target blanket = maximum $ fmap (cozyScoreYOffset target blanket) [0..yMax]

cozyScore :: [String] -> [String] -> Int
cozyScore target blanket = maximum $ fmap (cozyScoreY target . xOffsetBlanket blanket) [0..xMax]

main = do
    rawJoe <- getLinesFromFile "../joe.txt"
    blanket <- getLinesFromFile "../teppe.txt"
    let joe = fmap padToLineLength rawJoe
    print $ cozyScore joe blanket

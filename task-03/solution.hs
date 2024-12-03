consumeRice :: Int -> Int -> Int -> Int
consumeRice tick stock take =
    let refill = [0,0,1,0,0,2]
        stock' = stock - take + (refill !! mod tick 6)
    in max stock' 0

consumePeas :: Int -> Int -> Int -> Int
consumePeas tick stock take =
    let refill = [0,3,0,0]
        stock' = stock - take + (refill !! mod tick 4)
    in max stock' 0

consumeCarrots :: Int -> Int -> Int -> Int
consumeCarrots tick stock take =
    let refill = [0,1,0,0,0,8]
        stock' = stock - take + (if tick > 30 then refill !! mod (tick-31) 6 else 0)
    in max stock' 0

consumeReindeer :: Int -> Int -> Int -> Int -> Int
consumeReindeer tick stock take cooldown =
    let refill
            | stock > 0 = 0
            | cooldown == 50 = 100
            | cooldown == 100 = 80
            | cooldown == 150 = 40
            | cooldown == 200 = 20
            | cooldown == 250 = 10
            | otherwise = 0
        stock' = stock - take + refill
    in max stock' 0

iterateLoop :: Int -> Int -> Int -> Int -> Int -> Int -> Int -> Int
iterateLoop tick rice peas carrots reindeer reindeerCooldown pretzels =
    let riceTake
            | rice > 0 = 5
            | otherwise = 0
        peasTake
            | riceTake > 0 && peas > 0 = 3
            | peas > 0 = 5
            | otherwise = 0
        carrotsTake
            | riceTake > 0 && peasTake > 0 = 0
            | ((riceTake > 0 && peasTake == 0) || (riceTake == 0 && peasTake > 0)) && carrots > 0 = 3
            | carrots > 0 = 5
            | otherwise = 0
        reindeerTake
            | riceTake == 0 && peasTake == 0 && carrotsTake == 0 && reindeer > 0 = 2
            | otherwise = 0
        pretzelTake
            | riceTake == 0 && peasTake == 0 && carrotsTake == 0 && reindeerTake == 0 = 1
            | otherwise = 0
        rice' = consumeRice tick rice riceTake
        peas' = consumePeas tick peas peasTake
        carrots' = consumeCarrots tick carrots carrotsTake
        reindeerCooldown' = if reindeer == 0 then reindeerCooldown + 1 else reindeerCooldown
        reindeer' = consumeReindeer tick reindeer reindeerTake reindeerCooldown
        pretzels' = pretzels - pretzelTake
    in if pretzels == 0 then tick else iterateLoop (tick + 1) rice' peas' carrots' reindeer' reindeerCooldown' pretzels'

main = do
    print $ iterateLoop 0 100 100 100 100 0 100
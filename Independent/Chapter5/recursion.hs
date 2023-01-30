-- FXN: max of a list
maximum' :: (Ord a) => [a] -> a
maximum' [] = error "The list is empty."
maximum' [x] = x
maximum' (x:xs)
    | x > maxTail = x
    | otherwise = maxTail
    where maxTail = maximum' xs

maximum'' :: (Ord a) => [a] -> a
maximum'' [] = error "The list is empty."
maximum'' [x] = x
maximum'' (x:xs) = max x (maximum'' xs)

-- reverse a list
reverse' :: [a] -> [a]
reverse' [] = []
reverse' (x:xs) = reverse' xs ++ [x]    
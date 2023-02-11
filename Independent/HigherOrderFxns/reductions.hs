import Prelude hiding (foldr)
-- **REDUCTIONS** --
-- EX.:
-- mySum [] = 0
-- mySum (x:xs) = x + mySum xs

foldr op n [] = n
foldr op n (x:xs) = x `op` foldr op n xs

-- Simplify mySum:
mySum xs = foldr (+) 0 xs

-- xs is merely passed through and we can adopt a point-free style:
myNewSum = foldr (+) 0

{-
alLEven [] = True
allEven (x:xs) = even x && allEven xs
-}
-- Same structure as foldr
--allEven [] = True
--allEven (x:xs) = x `allE` allEven xs
--  where allE x b = even x && b

-- thus, we can replace explicit recursion by use of foldr
    -- the local fxn definition by an inline lambda abstraction,
    -- and use point-free style to arrive at a concise definition
allEven = foldr (\x b-> even x && b) True
-- NOTE:
    -- `\x b-> even x && b` ois of type Int -> Bool -> Bool;
    -- the higher-order argument op gets the result of the
    -- recursive call to foldr as its second argument

-- TYPE OF FOLDR --
{-
foldr :: (a -> b -> b) -> b -> [a] -> b
foldr op n [] = n
foldr op n (x:xs) = x `op` foldr n op xs
-}
myConcat = foldr (++) []
myReverse = foldr (\x xs -> xs ++ [x] ) []


-- **LEFT-ASSOCIATIVE REDUCTIONS** --
-- foldr implements reduction from the right
-- foldl implements reduction from left
{-
foldl :: (b -> a -> b) -> b -> [a] -> b
foldl op acc [] = acc
foldl op acc (x:xs) = foldl op (acc `op` x) xs
-}

-- foldl is subtly different than foldr :: (a -> b -> b) -> b -> [a] -> b
-- accumulator acc, in foldl, has same type as first argument of op

reverse' xs = foldl (\xs x -> x : xs) [] xs

-- **COMBINING MULTIPLE RECURSIVE PATTERNS** --
sumOfSquareRoots xs = sum (map sqrt (filter (>0) xs))

-- **FUNCTION APPLICATION W/ LOWER PRECEDENCE** --
-- declaration `infixr 0 $` states that ($) is right associative and has
-- precedence level 0, which is the weakest level of precedence
    -- i.e., it has the weakest binding power
{-
infixr 0 $
($) :: (a -> b) -> a -> b
f $ x = f x
-}
-- EX.: 
-- `sqrt $ average 60 30`
-- equivalent to sqrt (average 60 30)

newSumOfSquareRoots xs = sum $ map sqrt $ filter (> 0) xs
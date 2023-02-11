{-
Functions abstract over values by replacing concrete values
by variables. 
Types abstract over values, separating them into classes that form the admissible
input/output values of functions.
Polymorphic definitions abstract over concrete types by enabling functions that work
uniformly for a whole range of types.
-}

-- MAPPING AND ZIPPING
{-
Recursive functions usually have the form:
recursiveFxn [] = []
recursiveFxn (x : xs) = doSomethingWith x : recursiveFxn xs

*If these fxns only differ in a constant value that they are using,
 then we would abstract over that value and pass it as additional param
 to the fxn.*
-}

-- ***MAP*** --
-- map (standard name for applying
-- a given fxn to every element of a list)
{-
map f [] = []
map f (x:xs) = f x : map f xs
-}
-- TYPE OF MAP --
-- map :: (a -> b) -> [a] -> [b]

-- HIGHER-ORDER FXNS: fxns like map, which take another fxn as an argument
    -- and also fxns that return another fxn as their result.

-- USING MAP --
{-
allSquaress xs = map square xs
    where 
        square x = x * x

allToUpper :: String -> String
allToUpper string = map toUpper string
-}
{-
distancesFromPoint :: ColourPoint -> [ColourPoint] -> [Float]
distancesFromPoint point points = map distanceP points
    where
        distanceP :: ColourPoint -> Float
        distanceP p = distance point p
--}
-- We can simplify the last definition (omit local fxn distanceP)
{-
distancesFromPoint point points = map (distance point) points
-}
    -- (distance point) results in a fxn that takes a point p as argument,
    -- then calculates the distance between point and p.
    -- the result is same as distanceP fxn.

-- ***FROM MAPPING TO ZIPPING*** --
-- zipWith: takes a binary fxn and two lists as arguments
    -- applies the binary fxn to the first element of the first
    -- and second list, then to the second elements of the two lists,
    -- and so on:
{-
zipWith :: (a -> b -> c) -> [a] -> [b] -> [c]
zipWith op [] _ = []
zipWith op _ [] = []
zipWith op (x:xs) (y:ys) = (x `op` y) : zipWith op xs ys 
-}
-- zipWith average [1,2,3] [4,5,6] 
    -- returns: [2.5,3.5,4.5]

-- **FILTERING** --
-- LOOK AT FOLLOWING CODE:
    -- both have same structure
    -- it is natural to represent filtering as
    -- a higher-order function that takes a predicate as its fxn argumnet
{-
extractDigits [] = []
extractDigits (chr:restString)
    | isDigit chr = chr : extractDigits restString
    | otherwise = extractDigits restString

inRadius point radius [] = []
inRadius point radius (p:ps)
    | distance point p <= radius = p : inRadius point radius ps
    | otherwise = inRadius point radius ps
-}
-- same structure as both above fxns
    -- abstracts the test out as a predicate p
import Prelude hiding (filter)
filter p [] = []
filter p (x:xs)
    | p x = x : filter p xs
    | otherwise = filter p xs

{-
extractDigits strings = filter isDigit strings
-}

{-
inRadius point radius points = filter inRadiusP points
    where
        inRadiusP p = distance point p <= radius
-}

-- **ANONYMOUS FUNCTIONS** --
{-
* Function definitions w/out a name that can be defined inline
Look at inRadius fxn and declaring a local function inRadiusP
    -- we only used the local fxn once
    -- to simplify this, we use anonymous functions
-}

-- EX.:
{-
inRadius point radius points filter (\p -> distance point p <= radius) points
-}
    -- Read as "lambda p to distance point p <= radius"
    -- aka a lambda abstraction

--EX. 2:
{-
allSquares xs = map (\x -> x * x) xs
-}

-- **POINT-FREE NOTATION AND PARTIAL APPLICATION** --
-- Definition of allSquares using map does not inspect the argument list anymore
    -- as the entire recursive list traversal is encapsulated in map.
{-
allSquares = map (\x -> x * x)
-}






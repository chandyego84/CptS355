-- PATTERN MATCHING
-- consists of specifying patterns to which data should conform
-- and then checking to see if it does and deconstructing
-- the data according to those patterns.

-- FXN: Checks if the number we supplied to it is a seven or not.
lucky :: (Integral a) => a -> String
lucky 7 = "LUCKY NUMBER, SEVEN!"
lucky x = "Sorry, you're out of luck, pal!"
    -- When you call `lucky`, the patterns will be checked from top to bottom.

-- FXN: The numbers from 1 to 5 and says "Not between 1 and 5" for any other number.
sayMe :: (Integral a) => a -> String
sayMe 1 = "One!"  
sayMe 2 = "Two!"  
sayMe 3 = "Three!"  
sayMe 4 = "Four!"  
sayMe 5 = "Five!"  
sayMe x = "Not between 1 and 5"

-- FXN: Factorial of a number n
factorial :: (Integral a) => a -> a
factorial 0 = 1
factorial n = n * factorial (n-1)

-- FXN: Adding two vectors
-- WITHOUT pattern matching
addVectors :: (Num a) => (a, a) -> (a, a) -> (a, a)
addVectors a b = (fst a + fst b, snd a + snd b)

-- WITH pattern matching
addVectors' :: (Num a) => (a, a) -> (a, a) -> (a, a)
addVectors' (x1, y1) (x2, y2) = (x1 + x2, y1 + y2)

-- FXN: extracting a third component 
third :: (a, b, c) -> c
third (_, _, z) = z

-- FXN: Implementation of head fxn
head' :: [a] -> a
head' [] = error "Can't call head on an empty list."
head' (x:_) = x

-- FXN: Tells us some of the first elements of the list
tell :: (Show a) => [a] -> String
tell [] = "The list is empty."
tell (x:[]) = "The list has one element " ++ show x
tell (x:y:[]) = "The list has two elements " ++ show x ++ " and " ++ show y
tell (x:y:_) = "The first two elements of this long list are " ++ show x ++ " and " ++ show y

-- FXN: Our own length fxn
length' :: (Num b) => [a] -> b
length' [] = 0
length' (_:xs) = 1 + length' xs

-- FXN: Our own sum fxn
sum' :: (Num a) => [a] -> a
sum' [] = 0
sum' (x:xs) = x + sum' xs

-- First letter from a string
--capital :: String -> String
capital "" = "There is nothing in the string!"
capital (x:xs) = "The first letter in the string is " ++ [x]

-- GUARDS: A way of testing whether some property or value (or several) are true/false
-- EX.:
bmiTell :: (RealFloat a) => a -> String
bmiTell bmi
    | bmi <= 18.5 = "You're skinny as balls."
    | bmi <= 25.0 = "You're just mid."
    | bmi <= 30.0 = "You're fat as fuck."
    | otherwise = "You're a whale!"

-- taking in multiple params
bmiTell' :: (RealFloat a) => a -> a -> String
bmiTell' weight height
    | weight / height ^ 2 <= 18.5 = "Skinny."
    | weight / height ^ 2 <= 25.0 = "Mid."
    | weight / height ^ 2 <= 30.0 = "Fat."
    | otherwise = "Whale."

-- taking in mulitple params and NOT repeating ourselves!
-- where
bmiTell'' :: (RealFloat a) => a -> a -> String
bmiTell'' weight height
    | bmi <= skinny = "Skinny!"
    | bmi <= mid = "Mid!"
    | bmi <= fat = "Fat!"
    where bmi = weight / height ^ 2
          skinny = 18.5
          mid = 25.0
          fat = 30.0

-- FXN: Max
max' :: (Ord a) => a -> a -> a
max' a b
    | a > b = a
    | otherwise = b

-- FXN: Comparing two values
myCompare :: (Ord a) => a -> a -> Ordering
a `myCompare` b
    | a > b = GT
    | a == b = EQ
    | otherwise = LT
    
-- FXN: Initials of a name
initials :: String -> String -> String  
initials firstname lastname = [f] ++ ". " ++ [l] ++ "."  
    where (f:_) = firstname  
          (l:_) = lastname    

-- FXN: calculates a list of bmi's
calcBmis :: (RealFloat a) => [(a, a)] -> [a]
calcBmis xs = [bmi w h | (w, h) <- xs]
    where bmi weight height = weight / height ^ 2

-- LET it be
-- `let` bindings are expressions themselves
-- `where` bindings are syntactic constructs
cylinder :: (RealFloat a) => a -> a -> a
cylinder r h = 
    let sideArea = 2 * pi * r * h
        topArea = pi * r ^ 2
    in sideArea + 2 * topArea

calcBmis' :: (RealFloat a) => [(a, a)] -> [a]
calcBmis' xs = [bmi | (w, h) <- xs, let bmi = w / h ^ 2] -- we can't use `bmi` name in (w, h) <- xs part
                                                            -- because that part is defined prior to the `let` binding

-- CASE EXPRESSIONS
headCase :: [a] -> a
headCase xs = case xs of [] -> error "No head for empty lists!"
                         (x:_) -> x

tailCase :: [a] -> [a]
tailCase xs = case xs of [] -> error "No tail for empty lists!"
                         [x] -> error "There is only one element in this list." 
                         (_:xp) -> xp

myTail :: [a] -> [a]
myTail [] = error "Empty List, we can't get a tail!"
myTail (_:xp) = xp
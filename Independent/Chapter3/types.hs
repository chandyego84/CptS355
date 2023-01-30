import Data.Array.Base (MArray(getNumElements))
-- FUNCTIONS ALSO HAVE TYPES
removeNonUpperCase :: [Char] -> [Char] -- fxn maps from a string to a string
-- removeNonUppercase :: String -> String
removeNonUpperCase st = [c | c <- st, c `elem` ['A'..'Z']]

-- TYPE OF A FXN THAT TAKES SEVERAL PARAMETERS
addThree :: Int -> Int -> Int -> Int
addThree x y z = x + y + z

-- COMMON TYPES
-- Int: bounded; 32-bit min/max values, more efficient than `Integer`
-- Integer: it is NOT bounded; can represent larger numbers
factorial :: Integer -> Integer
factorial n = product [1..n]

-- Float: real floating point w/ single precision.
circumference :: Float -> Float
circumference r = 2 * pi * r
    -- circumference 42
    -- returns: 263.8938

-- Double: real floating point w/ double the precision.
circumference' :: Double -> Double
circumference' r = 2 * pi * r
    -- circumference' 42
    -- returns: 263.89378290154264

-- Boolean: True or False
-- Char: character; denoted by single quotes. A list of chars is a string

-- TUPLES and types
    -- are types, dependent on their length as well as the type of their components
    -- empty tuple, (), is also a type which can only have a single value: ()

-- TYPE VARIABLES

-- head fxn: takes a list of any type and returns the first element
    -- :t head
    -- returns: head :: [a] -> a
    -- 'a' is a 'type variable'. It can be of any type
    -- Fxns that have type variables are called polymorphic functions

-- :t fst
    -- returns: fst :: (a,b) -> a

--TYPECLASSES
-- :t (==)
    -- returns: (==) :: (Eq a) => a -> a -> Bool
        -- equality fxn takes any two values that are of the same type and returns
        -- a bool. The type of those two values must be a member of the Eq class (class constraint)
-- NOTE: == is a function, and so are all other operators.
-- =>
    -- everything before '=>' is called a class constraint

-- EXAMPLE, `elem` function:
    -- (Eq a) => a -> [a] -> Bool
        -- it uses `==` over a list to check whether some value we're looking for is in it

-- `Ord` is for types that have an ordering
    -- :t (>)
        -- returns: (>) :: (Ord a) => a -> a -> Bool
    -- `compare` fxn takes two Ord members of the same type and returns an ordering
    -- Ordering is a type that can be GT, LT, or EQ
        -- 5 `compare` 3
            -- returns: GT

-- Members of `Show` can be presented as strings
    -- :t show
        -- returns: show :: Show a => a -> String

-- etc. etc. etc.


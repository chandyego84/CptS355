-- CptS 355 - Spring 2023 -- Homework2 - Haskell
-- Name: Chandler Juego
-- Collaborators: NONE, LIGHT WORKKKKKKK!!!!!! D:<

module HW2
     where

{- P1 - remove_every, remove_every_tail  -}

-- (a) remove_every – 7%
-- Takes an integer n and a list lst
-- Removes the item after every nth element in the list lst
-- If n is greater than the length of input list, no elements will be removed.
-- If n is 0, all elements in the list will be deleted.
-- May assume that n >= 0.
-- EX.:
-- remove_every 3 "123a456b789c"
     -- returns: "123456789"

-- remove_every 8  [1,2,3,4,5,6,7,8,100]
     -- returns: [1,2,3,4,5,6,7,8]

-- remove_every 9 [1,2,3,4,5,6,7,8]
     -- returns: [1,2,3,4,5,6,7,8]

{-
*FOLLOWING FXN WILL GIVE TYPE ERRORS/RUN TIME EXCEPTIONS; FIX:
remove_every n []  = [] 
remove_every n lst = remove_helper n lst n 
  where  ==> missing empty list pattern
     remove_helper 0 (x:xs) k = (remove_helper k xs) ==> need to pass three arguments
     remove_helper n (x:xs) k = x:(remove_helper (n-1) xs) ==> need to pass three arguments
----------------------------------------------------------------------
-}
remove_every _ [] = [] -- list is empty
remove_every n lst = remove_helper n lst n
  where  
     -- arg1 = tracker in lst, arg2 = curr list, arg3 = n
     remove_helper _ [] _ = []
     remove_helper 0 (x:xs) k = remove_helper k xs k -- elem is nth elem, do not include
     remove_helper n (x:xs) k = x:(remove_helper (n-1) xs k) -- elem is not nth elem, include

-- (b) remove_every_tail –  10%
-- Re-write remove_every fxn above as a tail-recursive fxn.
remove_every_tail _ [] = []
remove_every_tail n lst = remove_helper n lst n []
     where
          remove_helper _ [] _ acc = reverse acc
          remove_helper 0 (x:xs) k acc = remove_helper k xs k acc -- elem is nth elem, do not include
          remove_helper n (x:xs) k acc = remove_helper (n-1) xs k (x:acc) -- elem is not nth elem, include
          
------------------------------------------------------
{- P2  get_outof_range and count_outof_range  -}

-- (a) get_outof_range – 6%
-- Takes two values v1, v2, and a list xs
-- Returns the values in xs which are less than v1 and greater than v2
-- Using only higher order fxns
-- EX.:
     -- get_outof_range (-5) 5 [10,5,0,1,2,-5,-10]
          -- returns: [10,-10]
     
     -- get_outof_range 4 6  [1,2,3,4,5,6,7,8,9,10]
          -- returns: [1,2,3,7,8,9,10]
     
     -- get_outof_range 'A' 'z' "CptS-355" 
          -- returns: "-355"

get_outof_range _ _ [] = []
get_outof_range v1 v2 xs = filter (\x -> (x < v1) `exor` (x > v2)) xs
     where
          exor a b -- my own XOR
               | (a == b) = False -- both true -> false
               | otherwise = True

-- (b) count_outof_range – 10%
-- Using get_outof_range fxn:
-- Takes two integer values v1, v2, NESTED list "xs"
-- Returns total number of values in xs which are less than and greater than v2 (exclusive)
-- EX.:
     -- count_outof_range (-5) 5 [[10,5,0,1,2,-5,-10],[4,2,-1,3,-4,8,5,9,4,10],[-5,-6,7,8]]
          -- returns: 8
     
     -- count_outof_range 'A' 'z' ["Cpt S","-","355",":","HW2"]
          -- returns: 7
     
     -- count_outof_range 1 1 [[4,1],[2,-1,3,-4],[8,0,1,5,9,4]]
          -- returns: 10

count_outof_range _ _ [] = 0
count_outof_range v1 v2 xs = length $ foldl (\acc sublist -> acc ++ get_outof_range v1 v2 sublist) [] xs

------------------------------------------------------
{- P3  find_routes - 10% -}
-- Rewrite find_routes (HW1) using higher order fxns
-- Takes a list of bus routes and a stop name
-- Returns the list of the bus routes which stop at the given bus route
-- You MAY use 'elem' fxn.
-- EX.:
{-
routes = [ 
    ("Lentil", ["Chinook", "Orchard", "Valley", "Emerald","Providence", "Stadium",  
      "Main", "Arbor", "Sunnyside", "Fountain", "Crestview", "Wheatland", "Walmart",  
      "Bishop", "Derby", "Dilke"]),  
    ("Wheat",["Chinook", "Orchard", "Valley", "Maple","Aspen", "TerreView", "Clay",  
     "Dismores", "Martin", "Bishop", "Walmart", "PorchLight", "Campus"]),  
    ("Silver",["TransferStation", "PorchLight", "Stadium", "Bishop","Walmart",  
     "Outlet", "RockeyWay","Main"]), 
    ("Blue",["TransferStation", "State", "Larry", "TerreView","Grand", "TacoBell",  
     "Chinook", "Library"]), 
    ("Gray",["TransferStation", "Wawawai", "Main", "Sunnyside","Crestview",  
     "CityHall", "Stadium", "Colorado"]), 
    ("Coffee",["TransferStation", "Grand", "Main", "Visitor","Stadium", "Spark",  
     "CUB"]) 
   ]

   > find_routes "Walmart" routes
          ["Lentil", "Wheat", "Silver"]

   > find_routes "Rosauers" routes
          []
-}
find_routes n xs = foldl (\acc (x,y) -> if n `elem` y then (x:acc) -- if n is in y, add route to acc
                                        else acc) [] xs -- otherwise, acc remains the same

------------------------------------------------------
{- P4  add_lengths and add_nested_lengths -}
-- Consider the following datatype which represents the US customary length units:
data LengthUnit = INCH Int | FOOT Int | YARD Int
                    deriving (Show, Read, Eq)

-- (a) add_lengths - 6%
-- Takes two LengthUnit values
-- Calculates the sum of those in INCHs. (Note 1 foot = 12 inches, 1 yard = 36 inches)
-- EX.:
     -- add_lengths (INCH (-5)) (INCH 10)
          -- returns: (INCH 5)
     
     -- add_lengths (INCH 5) (FOOT 10)
          -- returns: (INCH 125)
     
     -- add lengths (YARD 1) (INCH 10)

add_lengths (INCH x) (INCH y) = (INCH) (x + y)

add_lengths (INCH x) (FOOT y) = (INCH) (x + (12 * y))
add_lengths (FOOT x) (INCH y) = (INCH) ((12 * x) + y)

add_lengths (INCH x) (YARD y) = (INCH) (x + (36 * y))
add_lengths (YARD x) (INCH y) = (INCH) ((36 * x) + y)

add_lengths (FOOT x) (YARD y) = (INCH) ((12 * x) + (36 * y))
add_lengths (YARD x) (FOOT y) = (INCH) ((36 * x) + (12 * x))

-- (b) add_nested_lengths - 10%
-- Takes a nested list of LengthUnit values
-- Calculates the sum of those in INCHs.
-- HINT: The base for fold needs to be a LengthUnit value
-- EX.:
     -- add_nested_lengths [[INCH (-5),INCH 10], [YARD (-1), YARD 2,FOOT 2], [INCH 5],[]]
          -- returns: (INCH 70)
     
     -- add_nested_lengths [[YARD 2, FOOT 1], [YARD 1, FOOT 2, INCH 10],[YARD 3]] (INCH 262)
          -- returns: (INCH 70)

add_nested_lengths xs = foldl add_lengths (INCH 0) (map (foldl add_lengths (INCH 0)) xs)
------------------------------------------------------
{- P5 sum_tree and create_sumtree -}
-- Polymorphic binary tree type with data both at leaves and interior nodes
data Tree a = NULL | LEAF a | NODE a  (Tree a)  (Tree a)  
              deriving (Show, Read, Eq) 
-- NULL represents a missing child for a node

-- (a) sum_tree - 8%
-- Takes a tree of type Tree
-- Calculates the sum of the values stored in both the leaves and interior nodes
-- EX.: 
-- sum_tree (NODE 8 (NODE 0 (LEAF 4) (NODE 4 NULL (LEAF 9))) (NODE 0 (NODE 0 (LEAF 10) (NODE 7 NULL (LEAF 13)))  NULL))
     -- returns: 55
{-
     Simple trees:
     1. NULL
     2. (LEAF v)
     3.
          (NODE v)
         /        \
     (LEAF x)    (LEAF y)
-}
sum_tree (NULL) = 0
sum_tree (LEAF v) = v
sum_tree (NODE v t1 t2) = v + (sum_tree t1) + (sum_tree t2)

-- (b) create_sumtree - 10%
-- Takes a tree value
-- Returns Tree where the interior nodes store the sum of the leaf and node values underneath them
     -- (including NODE's own values)

create_sumtree (NULL) = NULL
create_sumtree (LEAF v) = LEAF v
create_sumtree (NODE v t1 t2) = NODE  (v + sum_tree t1 + sum_tree t2) (create_sumtree t1) (create_sumtree t2)

------------------------------------------------------
{- P6 list_tree - 16% -}


-- Tree examples - 4%
-- INCLUDE YOUR TREE EXAMPLES HERE

-- Assignment rules 3%
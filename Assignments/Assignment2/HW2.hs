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

-- (b) count_outof_range – 10%

------------------------------------------------------
{- P3  find_routes - 10% -}

------------------------------------------------------
{- P4  add_lengths and add_nested_lengths -}

-- (a) add_lengths - 6%

-- (b) add_nested_lengths - 10%

------------------------------------------------------
{- P5 sum_tree and create_sumtree -}

-- (a) sum_tree - 8%

-- (b) create_sumtree - 10%

------------------------------------------------------
{- P6 list_tree - 16% -}


-- Tree examples - 4%
-- INCLUDE YOUR TREE EXAMPLES HERE

-- Assignment rules 3%
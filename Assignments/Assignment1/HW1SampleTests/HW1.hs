-- CptS 355 - Spring 2023 -- Homework1 - Haskell
-- Name: Chandler Juego
-- Collaborators: 

module HW1
     where

-- P1(a) count ;  6%
-- Description: Takes a value and a list and returns the number of occurences of that value in the input list.
-- Ex.:
    -- count '5' "355-451"
        -- result: 3
    -- count [] [[],[1,2],[3,2],[5,6,7],[8],[]] 
        -- result: 2
    -- count 0 [1,2,3,4,5,6,7,8,9] 
        -- result: 0

count v [] = 0
count v (x:xs)
    | (v == x) = 1 + (count v xs) -- current elem matches value
    | otherwise = count v xs


-- P1(b) diff ;  6%
-- Description: Takes two lists as input and returns the difference of the first list with respect
-- to the second. The input lists may have duplicate elements. If an element in the first list also appears
-- in the second one, the element--and its duplicate copies--should be excluded in the output.
     -- The elements in the resulting list may have arbitrary order.
-- Ex.:
     -- diff [1,2,2,3,3,3,4,4,4,4,5,5,5,5,5,6,6,6,6,6,6] [1,2,3,4,5,7,7]
          -- result: [6,6,6,6,6,6]
     -- diff [1,2,2,3,3,3,6,7,4,4,4,4,5,5,5,5,5,6,6] [1,1,2,2,3,3,4,4,5,6,6,6]
          -- result: [7]
     -- diff [6,2,2,3,5,3,6,7,4,4,5,4,5,5,4,5,3,1,6] [1,2,2,3,3,3,6,7,4,4,4,4,5,5,5,5,5,6,6]
          -- result: []

-- looks more like getting unique elements
diff _ [] = []
diff [] _ = []
diff (x:xs) (ys)
     | x `elem` ys = diff xs ys -- value appears in list2 -> do not add to output
     | otherwise = x:(diff xs ys) -- value does not appear in list2 -> add to output


-- P1(c) bag_diff ; 8%
-- Description: Takes two lists as inputs and returns the difference of the first list
-- with respect to the second. Input lists may have duplicate elements. If an element
-- appears in both lists and if the number of duplicate copies of the element is bigger in the first list,
-- then this element should appear in the result as many times as the difference of the number of 
-- occurences in the first list.
-- Ex.:
     -- bag_diff [1,2,2,3,3,3,4,4,4,4,5,5,5,5,5,6,6,6,6,6,6] [1,2,3,4,5,7,7]
          -- result: [2,3,3,4,4,4,5,5,5,5,6,6,6,6,6,6]
     -- bag_diff [1,2,2,3,3,3,6,7,4,4,4,4,5,5,5,5,5,6,6] [1,1,2,2,3,3,4,4,5,6,6,6]
          -- result: [3,4,4,5,5,5,5,7]
     -- bag_diff [6,2,2,3,5,3,6,7,4,4,5,4,5,5,4,5,3,1,6] [1,2,2,3,3,3,6,7,4,4,4,4,5,5,5,5,5,6,6]
          -- result: []
     -- bag_diff "testing my function" "fit "
          -- result: "testing myuncon"

bag_diff [] ys = [] -- list1 is empty
bag_diff xs [] = xs -- list2 is empty
bag_diff (x:xs) lis2
     | (0 == count x lis2) = x:bag_diff xs lis2 -- value is unique to list1 -> add to output
     | (1 + count x xs > count x lis2) = x : bag_diff xs lis2 -- value occurs more in list1; add to output
     | otherwise = bag_diff xs lis2 -- difference in occurences of the value is 0 or more for list2; do not add to output

-- P2  everyN ; 10%
-- Description: Takes a list and a number 'n' (representing a count) and returns the nth value in the input list.
-- Ex.:
     -- everyN "-hH-aA-sS-kK-eE-lL-lL" 3
          -- returns: “HASKELL"
     -- everyN [1,2,3,4,5,6,7,8,9,10,11,12,13] 3
          -- returns: [3,6,9,12]
     -- everyN [] 5
          -- []

everyN [] _ = []
everyN iL n
     | (n <= 0) = iL -- count must be positive
     | otherwise = everyNHelper iL n 1
     where 
          everyNHelper [] _ _ = [] -- list is empty
          everyNHelper (x:xs) n counter
               | (n == counter) = x:(everyNHelper xs n 1) -- we are at an nth element; add to output, reset counter
               | otherwise = everyNHelper xs n (counter + 1)


-- P3(a) make_sparse ; 15%
-- Preview: A sparse vector is a vector having a relatively small number of nonzero elements.
-- When a sparse vector is saved, it is typically put in storage w/out its zero elements.
-- A possible solution for storing sparse vector is compressing it as a list of tuples where the
-- tuples store the indices and values for non-zero elements.
-- Ex.:
     -- [0,0,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1] can be stored as: [(3,1),(20,1)]
-- Assume: indexes are 0-based.

-- Description: Write a function which takes a compressed vector value (list of tuples)
-- and returns the equivalent sparse vector (including all 0 values).
-- Ex.:
     -- make_sparse [(3,30),(10,100),(11,110)] 
          -- returns: [0,0,0,30,0,0,0,0,0,0,100,110] 

     -- make_sparse [(1,1),(2,2),(4,4),(6,6),(9,9)]
          -- returns: [0,1,2,0,4,0,6,0,0,9]

     -- make_sparse [(20,1)]
          -- returns: [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1]

make_sparse [] = [] -- list is empty, nothing to make sparse
make_sparse ((x,y):xs) = sparseHelper ((x,y):xs) 0-- pass the list of tuples

sparseHelper [] _ = [] -- list is empty
sparseHelper ((x,y):xs) counter
     | (x == counter) = y:(sparseHelper xs (counter + 1)) -- at index to place -> place value
     | otherwise = 0:(sparseHelper ((x,y):xs) (counter + 1)) -- not at index to place, add a 0

-- P3(b) compress ; 15%
-- Definition: Takes a sparse vector value (as a list) and returns the equivalent
-- compressed values as a list of tuples.
-- Ex.:
     -- compress [0,0,0,30,0,0,0,0,0,0,100,110]
          -- returns: [(3,30),(10,100),(11,110)]

     -- compress [0,1,2,0,4,0,6,0,0,9]
          -- returns: [(1,1),(2,2),(4,4),(6,6),(9,9)]

     -- compress [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1]
          -- returns: [(20,1)]

     -- compress []
          -- returns: []

compress [] = [] -- nothing to compress
compress (x:xs) = compressHelper (x:xs) 0
     where 
          compressHelper [] counter = []
          compressHelper (x:xs) counter
               | (x /= 0) = (counter, x):(compressHelper xs (counter + 1)) -- create the tuple to add to compressed list
               | otherwise = compressHelper xs (counter + 1) -- is a 0, keep moving through list


-- P4 added_sums ; 8%
-- Description: Takes a list of numbers and returns a list including the cumulative
-- partial sums of these numbers. 
-- Ex.:
     -- added_sums [1,2,3,4,5,6,7,8,9,10]
          -- returns: [1,3,6,10,15,21,28,36,45,55]

     -- added_sums [0,-2,3,4,-4,-1,2]
          -- returns: [0,-2,1,5,1,0,2]

     -- added_sums []
          -- []

added_sums [] = []
added_sums (x:xs) = addedSumsHelper (x:xs) 0
     where
          addedSumsHelper [] _ = []
          addedSumsHelper (x:xs) currSum = (x + currSum):(addedSumsHelper xs (x + currSum))

-- P5 find_routes ; 8%
-- Description: Pullman Transit offers many bus routes in Pullman. 
-- Assume that they maintain the bus stops for their 
-- routes as a list of tuples. The first element of each tuple is the bus route and the second element is the list 
-- of stops for that route (see below for an example).  
-- Ex.:

find_routes _ [] = [] -- empty list
find_routes targetStop ((route,stops):xs)
     | (targetStop `elem` stops) = route:(find_routes targetStop xs)
     | otherwise = find_routes targetStop xs 

-- P6 group_sum ; 15% 



-- Assignment rules ; 3%
-- Your own tests; please add your tests to the HW1Tests.hs file ; 6%




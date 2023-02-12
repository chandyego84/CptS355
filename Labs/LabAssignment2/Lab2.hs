-- CptS 355 - Lab 2 (Haskell) - Spring 2023
-- Name: Chandler Juego
-- Collaborated with: 
module Lab2
     where

-- 1
{- (a) merge2 -}
-- Takes two lists, l1 and l2, and returns a merged list where elements from l1
-- and l2 appear interchangably.
-- The resulting list should include the leftovers from the longer list and it
-- may include duplicates.
-- merge2 :: [a] -> [a] -> [a]
-- EX.:
     -- merge2 [3,2,1,6,5,4] [1,2,3]
          -- result: [3,1,2,2,1,3,6,5,4]

     -- merge2 "Ct S" "pS35"
          -- result: "CptS 355"

     -- merge2 [(1,2),(3,4)] [(5,6),(7,8),(9,10)]
          -- result: [(1,2),(5,6),(3,4),(7,8),(9,10)]
     
     -- merge2 [1,2,3] []
          -- result: [1,2,3]

merge2 [] [] = []
merge2 xs [] = xs
merge2 [] ys = ys
merge2 (x:xs) (y:ys) = x : y : (merge2 (xs) (ys))
                         
{- (b) merge2Tail -}
-- Rewrite the merge2 fxn above as a tail-recursive fxn.
-- You can use reverse or revAppend in your solution.
merge2Tail xs ys = reverse (merge2TailHelper xs ys [])
  where
    merge2TailHelper xs [] acc = reverse xs ++ acc
    merge2TailHelper [] ys acc = reverse ys ++ acc
    -- neither list is empty yet
    merge2TailHelper (x:xs) (y:ys) acc = merge2TailHelper xs ys (y:x:acc)


{- (c) mergeN -}
-- Using merge2 fxn defined above and foldl fxn,
-- mergeN: takes a list of lists
-- returns: a new list containing all the elements in the sublists
-- The sublists should be merged left to right
-- i.e., the first two lists should be merged first and the merged list should
-- further be merged with the third list, etc.
-- DO NOT USE EXPLICIT RECURSION.
-- type can be defiend as mergeN :: [[a]] -> [a]
-- EX.:
     -- mergeN ["ABCDEF","abcd","123456789","+=?$"] 
          -- returns: "A+1=a?2$B3b4C5c6D7d8E9F"
     
     -- mergeN [[3,4],[-3,-2,-1],[1,2,5,8,9],[10,20,30]]
          -- returns: [3,10,1,20,-3,30,2,4,5,-2,8,-1,9] 
     
     -- mergeN [[],[],[1,2,3]] 
          -- returns: [1,2,3]
mergeN xs = foldl (merge2) [] xs


-- 2
{- (a) count -}
-- Takes a value and a list
-- Counts the number of occurrences of the value in the input list
-- You MAY use length function.
-- DO NOT USE EXPLICIT RECURSION.
-- type should be count :: Eq a => a -> [a] -> Int 
-- EX.:
-- count [] [[],[1],[1,2],[]]
     -- returns: 2

-- count (-5) [1,2,3,4,5,6,7]
     -- returns: 0

-- count 'i' "incomprehensibilities"
     -- returns: 5 
count val xs = length (filter (==val) xs)

{- (b) histogram  -}
-- Creates a histogram from a given list
-- Historgram will be a list of tuples (pairs)
     -- first elem: item from input list
     -- second elem: number of occurrences of that item in the list
-- You MAY use the count function you defined above
-- You MAY use eliminateDuplicates fxn you defined in HW1
-- DO NOT USE EXPLICIT RECURSION.
-- Orer of the tuples in the histogram can be arbitrary.
-- type should be histogram :: Eq a => [a] -> [(a, Int)] 
-- EX.:
-- histogram [[],[1],[1,2],[1],[],[]]
     -- returns: [([1,2],1),([1],2),([],3)]

-- histogram "macadamia"
     -- returns: [('c',1),('d',1),('m',2),('i',1),('a',4)]

-- histogram (show 122333444455555)
     -- returns: [('1',1),('2',2),('3',3),('4',4),('5',5)]

-- ONE WAY:
-- look at an element in the list
-- has it been counted before?:
     -- no: get the count of that element in the list, move on in input list
     -- yes: move on in the input list
-- SECOND WAY: 
-- look at an element in the input list
-- get count of that element and add (x, count of x) in list
-- remove that element's duplicates from the input list
-- move on in the input list

-- IMPLEMENTED USING FIRST WAY
-- reverse because it will show each element in order of appearance!
histogram xs = reverse (foldl (\acc x -> 
                         if x `elem` (map fst acc) then acc -- is the elem already counted for?
                         else (x, count x xs):acc)  -- no, it has not been counted
                    [] xs)

-- 3                
{- (a) concatAll -}
-- Given a nested list of strings
-- Returns the concatenation of all strings in all sublists of the input list
-- Should not need recursion
-- Should use "map" and "foldr"
-- type should be concatAll :: [[String]] --> String
-- EX.:
-- concatAll [["enrolled"," ","in"," "],["CptS","-","355"],[" ","and"," "],["CptS","-","322"]]
     -- returns: "enrolled in CptS-355 and CptS-322"

-- concatAll [[],[]]
     -- returns: ""

{-
concatAll xs = foldr (\x acc -> (concatAllHelper x) ++ acc) "" xs -- concatenates all concatenated substrings
     where
          concatAllHelper xs = foldr (++) "" xs -- concatenates each element in each sublist
-}
concatAll xs = foldr (++) "" (map (foldr (++) "") xs)

{- (b) concat2Either -}
-- Takes a nested list of AnEither values
-- It returns an AString which is the concat of all values in all sublists of input list.(*)
-- You may use the 'show' function to convert an integer value to a string
-- Should not need recursion: use functions 'map' and 'foldr'
-- type should be concat2Either :: [[AnEither]] -> AnEither
-- NOTE: to implement this, change concatAll fxn and helper fxn in order to handle AnEither values instead of strings
-- EX.:
     -- concat2Either [[AString "enrolled", AString " ", AString "in", AString " "],[AString 
          --"CptS", AString "-", AnInt 355], [AString " ", AString "and", AString " "], [AString 
          --"CptS", AString "-", AnInt 322]]
     -- returns: AString "enrolled in CptS-355 and CptS-322"

     -- concat2Either [[AString "", AnInt 0],[]]
          -- returns: AString "0"

     -- concat2Either []
          -- returns: AString ""

data AnEither  = AString String | AnInt Int
                deriving (Show, Read, Eq)




-- 4      
{-  concat2Str -}               




data Op = Add | Sub | Mul | Pow
          deriving (Show, Read, Eq)

evaluate:: Op -> Int -> Int -> Int
evaluate Add x y =  x+y
evaluate Sub   x y =  x-y
evaluate Mul x y =  x*y
evaluate Pow x y = x^y

data ExprTree a = ELEAF a | ENODE Op (ExprTree a) (ExprTree a)
                  deriving (Show, Read, Eq)


-- 5 
{- evaluateTree -}



-- 6
{- printInfix -}



--7
{- createRTree -}
data ResultTree a  = RLEAF a | RNODE a (ResultTree a) (ResultTree a)
                     deriving (Show, Read, Eq)







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




{- (c) mergeN -}




-- 2
{- (a) count -}




{- (b) histogram  -}




-- 3                
{- (a) concatAll -}




{- (b) concat2Either -}               
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







-- **DATA TYPES MAY BE RECURSIVE** --
{-
Recursive datatypes allow linked structures w/out explicit pointers.
EX.: data MyList a = EMPTY | CONS a (MyList a) deriving (Show, Eq)

Type of `:`
> :t
returns: (:) :: a -> [a] -> [a]

Type of CONS
:t CONS
CONS :: a -> MyList a -> MyList a
-}
import Data.Char

data MyList a = EMPTY | CONS a (MyList a) deriving (Show, Eq)

list1 = 1:2:3:4:[]
(x:xs) = list1

myList1 = CONS 1 (CONS 2 (CONS 3 (CONS 4 EMPTY)))
(CONS y ys) = myList1

-- GET LENGTH OF MYLIST VALUE
length' [] = 0
length' (x:xs) = 1 + length' xs

mylength' EMPTY = 0
mylength' (CONS y ys) = 1 + mylength' ys

-- MAP
mymap op EMPTY = EMPTY
mymap op (CONS y ys) = CONS (op y) (mymap op ys)

-- TREES!!! --
-- let's keep it POLYMORPHIC
data MyTree a = LEAF a | NODE a (MyTree a) (MyTree a) deriving (Show, Eq)

--data IntTree = Leaf Int | Node (IntTree) (IntTree) deriving (Show, Eq)

-- IntTree
-- CREATE STEP-BY-STEP --
{-
l1 = Leaf 3
l2 = Leaf 4
tree1 = Node l1 l2
-- OR --
tree2 = Node (Node (Leaf 5) (Leaf 6)) (Leaf 4)

-- FXN TO COUNT THE NUMBER OF LEAVES IN A TREE
nLeaves :: Num p => MyTree a -> p
nLeaves (LEAF _) = 1 -- base case
nLeaves (NODE v t1 t2) = (nLeaves t1) + (nLeaves t2)
-}

myTreeToCount = NODE "zero" (NODE "one" (LEAF "three") (LEAF "four")) (NODE "two" (LEAF "five") (LEAF "six"))

-- FXN TO COPY A TREE
copyTree :: MyTree a -> MyTree a
copyTree (LEAF x) = LEAF x
copyTree (NODE v t1 t2) = NODE v (copyTree t1) (copyTree t2)

myTreeToCopy = NODE "zero" (NODE "one" (LEAF "one") (LEAF "two")) (NODE "two" (LEAF "three") (LEAF "four"))

-- FXN TREE MAP
data NewTree a = Leaf a | Node (NewTree a) (NewTree a) deriving (Show, Eq)

myNewTree = Node (Node (Leaf "one") (Leaf "two")) (Node (Leaf "three") (Leaf "four"))

treeMap :: (t -> a) -> NewTree t -> NewTree a
treeMap op (Leaf x) = Leaf (op x)
treeMap op (Node t1 t2) = Node (treeMap op t1) (treeMap op t2)

strUpper s = map toUpper s -- uppercase every char in string s

-- > treeMap strUpper myNewTree 
-- returns: Node (Node (Leaf "ONE") (Leaf "TWO")) (Node (Leaf "THREE") (Leaf "FOUR"))

-- PREORDER TRAVERSAL OF A TRITREE
data TriTree a = TriLEAF a | 
                 TriNODE a (TriTree a) (TriTree a) (TriTree a)
                 deriving (Show, Eq)

-- PREORDER TRAVERSAL
preOrderTri :: TriTree a -> [a]
preOrderTri (TriLEAF x) = [x]
preOrderTri (TriNODE x t1 t2 t3) = [x] ++ (preOrderTri t1) ++ (preOrderTri t2) ++ (preOrderTri t3) 

myTriTree = TriNODE 0 (TriNODE 9 (TriLEAF 1) (TriLEAF 2) (TriLEAF 6) ) 
            (TriNODE 8 (TriLEAF 3) (TriLEAF 4) (TriLEAF 7) ) 
            (TriLEAF 5) 
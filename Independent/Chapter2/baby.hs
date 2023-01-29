doubleMe x = x + x

-- doubleUs x y = x*2 + y*2
doubleUs x y = doubleMe x + doubleMe y

-- double a number if it is smaller than 100
doubleSmallNumber x = if x > 100
                        then x
                        else x*2

-- same fxn as above, +1 to the result
doubleSmallNumber' x = (if x > 100 then x else x*2) + 1

-- LISTS: are a homogenous data structure; all elements must be of the same type
-- [1, 2, 3] is just syntactic sugar for 1:2:3:[]
-- cons operator
-- 'A' : " SMALL CAT."

-- LIST RANGES (ENUMERATION)
oneToTwenty = [1..20]

-- INFINITE LISS; HASKELL IS LAZY
multiplesOfThirteen = [13, 26..]
-- take 24 multiplesOfThirteen -- although it is "infinite", haskell will only evaluate up to the 13th multiple

-- FXNS PRODUCING INFINITE LISTS:
-- take 10 (cycle [1,2,3])
    -- returns: [1,2,3,1,2,3,1,2,3,1]
    -- will go on forever if you don't slice it

-- take 10 (repeat 5)
    -- returns: [5,5,5,5,5,5,5,5,5,5]

-- replicate 3 10
    -- returns: [10, 10, 10]

-- LIST COMPREHENSION
-- [x*2 | x <- [1..10]]
    -- returns: [2,4,6,8,10,12,14,16,18,20]

-- [x*2 | x <- [1..10], x*2 >= 12]
    -- returns: [12,14,16,18,20]

-- all numbers from 50 to 100 whose remainder when
-- divided by 7 is 3
-- [x | x <- [50..100], x `mod` 7 == 3]
    -- returns: [52,59,66,73,80,87,94]

-- replaces each odd number > 10 w/ "BANG!"
-- replaces each odd number < 10 w/ "BOOM!"
-- if not odd, throw out of the list
boomBang xs = [ if x < 10 then "BOOM!" else "BANG" | x <- xs, odd x]
    -- boomBangs [7..13]
    -- function odd returns True on an odd # and False on an even #
    -- the element is included in the list only if all predicates evaluate to True
        -- returns: ["BOOM!","BOOM!","BANG!","BANG!"]

-- OUR OWN VERSION OF LENGTH
-- length' xs = sum [1 | x <- xs]
lenth' xs = sum [1 | _ <- xs]
    -- `_` means we don't care what we draw from the list
    -- replaces every element of a list with 1 and then sums taht up

-- removes lowercase characters from a string
removeNonUpperase st = [c | c <- st, c `elem` ['A'..'Z']]

-- TUPLES
    -- used when you know EXACTLY how many values you want to combine
    -- type depends on how many components it has and the types of components
    -- do NOT have to be homogenous, unlike Lists

-- fst takes a pair and returns its first component
    -- fst (8, 11)
        -- returns: 8

-- snd takes a pair and returns its second component
    -- snd (8, 11)
        -- returns: 11

-- NOTE: fst and snd only operate on pairs

-- zip: produces a list of pairs
    -- takes two lists and then zips them together into one list
    -- by joining matching elements into pairs
    -- zip [1,2,3,4,5] [5,5,5,5,5]
        -- returns: [(1,5), (2,5), (3,5), (4,5), (5,5)]
    
    -- haskell is lazy: we can zip finite lists w/ infinite lists
    -- zip [1..] ["meg", "jo", "amy", "beth"]
    -- [(1, "meg"), (2, "jo"), (3, "amy"), (4, "beth")]

-- PROBLEM: which right triangle that has integers for all sides 
    -- and all sides <= 10 has a perimeter of 24?

triangles = [ (a,b,c) | c <- [1..10], b <- [1..10], a <- [1..10], a+b+c == 24]
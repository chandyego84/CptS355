-- CptS 355 - Lab 1 (Haskell) - Spring 2023
-- Name: Chandler Juego

module Lab1
     where

-- 1.insert 
-- Description: takes an integer 'n', a value 'item', and a list 'iL'
-- inserts the 'item' at index 'n' in the list 'iL'.
-- 'n' is a 1-based index, i.e., 'item' should be inserted after the nth element in the list.
-- NOTES:
     -- if 'n' is > the length of the input list, the 'item' will not be inserted.
     -- if 'n' is 0, 'item' will be inserted to the beginning of the list.
     -- assume that n >= 0.
insert :: (Ord t1, Num t1) => t1 -> t2 -> [t2] -> [t2] -- n index, item, list iL
insert n item iL
     | n == 0 = item:iL -- place item @ front and copy rest of the list
     | n > length' iL = iL -- do not insert into list if n > length of original list
     | otherwise = head iL : insert (n-1) item (tail iL)
     -- get the length of a list
     where length' :: (Num b) => [a] -> b
           length' [] = 0
           length' (_:xs) = 1 + length' xs

-- 2. insertEvery
-- Description: takes an integer 'n', a value 'item', and a list 'iL'.
-- inserts the 'item' at every nth index in 'iL'.
-- 'n' is a 1-based index, i.e., 'item' should be inserted after nth, 2nth, 3nth, etc. elements in the list.
-- NOTES:
     -- if 'n' is > than the length of the input list, the 'item' will not be inserted. 
     -- if 'n' == 0, 'item' will be inserted to the beginning of the list. 
     -- you may assume that n >= 0.  
insertEvery :: (Eq t, Num t) => t -> a -> [a] -> [a] -- n index, item, list iL
insertEvery n item [] = [] -- empty list case
insertEvery n item (x:xs)
          | n == 0 = item:(x:xs) -- item inserted at beginning of the list
          | otherwise = everyHelper n item (x:xs) 1 -- list is filled, we start at index 1
          where everyHelper :: (Eq t, Num t) => t -> a -> [a] -> t -> [a]
                everyHelper _ _ [] _ = [] -- list is empty
                everyHelper n item (x:xs) count
                    | n == count =  x : item : everyHelper n item xs 1 -- at a x-nth index in the list; insert the item
                    | otherwise = x : everyHelper n item xs (count + 1) -- continue moving on with the list

-- 3. getSales
-- Description: 
-- Params: Takes a "day" abbreviation (e.g., "Mon", "Tue", etc.), sales log
-- Returns: Total sales in that store for a given day
-- Example:
     -- storelog = [("Mon",50),("Fri",20), ("Tue",20),("Fri",10),("Wed",25),("Fri",30)]
     -- ghci >> getSales "Fri" storelog
          -- returns: 60
     -- ghci >> getSales "Mon" storelog
          -- returns: 50
     -- ghci >> getSales "Sat" storelog
          -- returns: 0
getSales :: (Num p, Eq t) => t -> [(t, p)] -> p
getSales _ [] = 0 -- no more tuples to check
getSales d (x:xs) -- tuples exist
          | d == fst x = snd x + getSales d xs -- the "day" matches the current tuple's day
          | otherwise = getSales d xs -- the "day" does not match the tuple -> keep moving through list
-- for myself: another way to do it without using fst and snd?

-- 4. sumSales: combining sales logs into one list
-- Params: store name, a day-of-week, and a sales log list
-- Returns: total sales of that store on that day-of-week
-- (Hint): you can use getSales function above 
-- Ex.: sales = [("Amazon",[("Mon",30),("Wed",100),("Sat",200)]), 
--          ("Etsy",[("Mon",50),("Tue",20),("Wed",25),("Fri",30)]), 
--          ("Ebay",[("Tue",60),("Wed",100),("Thu",30)]), 
--          ("Etsy",[("Tue",100),("Thu",50),("Sat",20),("Tue",10)])]
     -- A list of tuples: ('store name', [(day, sale amount)])

     -- >> sumSales "Etsy" "Tue" mySales
          -- returns: 130
     -- >> sumSales "Amazon" "Mon" mySales
          -- returns: 30
sumSales :: (Num p) => String -> String -> [(String, [(String, p)])] -> p
sumSales _ _ [] = 0 -- no more stores to check
sumSales s d (x:xs) -- still stores to check (list is filled)
          | s == fst x = getSales d (snd x) + sumSales s d xs -- current tuple matches the store -> check each day in current tuple
          | otherwise = sumSales s d xs

-- 5. split
split :: Eq a => a -> [a] -> [[a]]
split c iL = sHelper c iL [] -- delimeter, input list, buffer
     where
          sHelper c [] buf -- empty input list
                    | buf == [] = []
                    | otherwise = (reverse buf):[]
          sHelper c (x:xs) buf 
                    | c == x = (reverse buf):(sHelper c xs []) -- matching delimeter, reset the buf
                    | otherwise = sHelper c xs (x:buf) -- not matching, add the element to the buf

-- 6. nSplit

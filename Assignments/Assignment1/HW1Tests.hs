{- Example of using the HUnit unit test framework.  See  http://hackage.haskell.org/package/HUnit for additional documentation.
To run the tests type "run" at the Haskell prompt.  -} 

module HW1Tests
    where

import Test.HUnit
import Data.Char
import Data.List (sort)
import HW1

-- P1(a) count tests  

-- P1(b) diff tests


-- P1(c) bag_diff tests


-- P2  everyN tests


-- P3(a) make_sparse tests


-- P3(b) compress tests


-- P4 added_sums tests


-- P5 find_routes tests


-- P6 group_sum tests


-- add the test cases you created to the below list. 
tests = TestList [ 
                 ] 
                  
-- shortcut to run the tests
run = runTestTT  tests
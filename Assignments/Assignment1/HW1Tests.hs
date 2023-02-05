{- Example of using the HUnit unit test framework.  See  http://hackage.haskell.org/package/HUnit for additional documentation.
To run the tests type "run" at the Haskell prompt.  -} 

module HW1Tests
    where

import Test.HUnit
import Data.Char
import Data.List (sort)
import HW1

-- P1(a) count tests
p1a_test4 = TestCase (assertEqual "count-test4"
                                 0
                                 (count '5' []) )

p1a_test5 = TestCase (assertEqual "count-test5"
                                 1
                                 (count True [False, True]) )

p1a_test6 = TestCase (assertEqual "count-test6"
                                 1
                                 (count [] ["iLoveAudra", []]) )

-- P1(b) diff tests
p1b_test4 = TestCase (assertEqual "diff-test4"
                                 "Will you be my valentine?"
                                 (diff "Will you be my valentine?" []) )

p1b_test5 = TestCase (assertEqual "diff-test5"
                                 "drBaby"
                                 (diff "druhBaby" "uh") )


p1b_test6 = TestCase (assertEqual "diff-test6"
                                 []
                                 (diff [] [3,13,42,69]) )


-- P1(c) bag_diff tests
p1c_test5 = TestCase (assertEqual "bag_diff-test6"
                                 "audraBby"
                                 (bag_diff "audraBaby" "a") )

p1c_test6 = TestCase (assertEqual "bag_diff-test6"
                                 []
                                 (bag_diff [2] [1,2,3,2,2,2,2,2,2,2,2,2]) )

-- P2  everyN tests
p2_test5 = TestCase (assertEqual "everyN-test5"
                                 ""
                                 (everyN "" 100) )

p2_test6 = TestCase (assertEqual "everyN-test6"
                                 [(6,9),(6,9)]
                                 (everyN [(4,2),(6,9),(4,2),(6,9),(4,2)] 2) )

-- P3(a) make_sparse tests
p3a_test5 = TestCase (assertEqual "make_sparse-test5"
                                 [-69,69]
                                 (make_sparse [(0,-69), (1,69)]) )

p3a_test6 = TestCase (assertEqual "make_sparse-test5"
                                 [69]
                                 (make_sparse [(0, 69)]) )

-- P3(b) compress tests
p3b_test5 = TestCase (assertEqual "compress-test5"
                                 []
                                 (compress [0]) )

p3b_test6 = TestCase (assertEqual "compress-test6"
                                 [(69,42)]
                                 (compress (replicate 61 0 ++ [69])) )

-- P4 added_sums tests
p4_test4 = TestCase (assertEqual "added_sums-test4"
                                 [-1]
                                 (added_sums [-1]) )

p4_test5 = TestCase (assertEqual "added_sums-test5"
                                 [0, 1, 1, 0.5]
                                 (added_sums [0, 1, 0, -0.5]) )

-- P5 find_routes tests
myRoutes1 = [("ToStLouis",["Audra's Crib", "The Gym", "The Big Church"])]

p5_test4 = TestCase (assertEqual "find_routes-test4"
                                 []
                                 (find_routes "Home" myRoutes1) )

myRoutes2 = [("ToChicago",["The Bean", "Color Factory", "The Bean"]),
            ("ToStLouis", ["The Bean", "The Bean", "Mr. Bean"])
            ]
p5_test5 = TestCase (assertEqual "find_routes-test5"
                                 ["ToChicago", "ToStLouis"]
                                 (find_routes "The Bean" myRoutes2) )

-- P6 group_sum tests
p6_test4 = TestCase (assertEqual "group_sum-test4"
                                 [[1]]
                                 (group_sum [1] 69) )

p6_test5 = TestCase (assertEqual "group_sum-test5"
                                 [[-1,0,1],[2]]
                                 (group_sum [-1, 0, 1, 2] 1) )



-- add the test cases you created to the below list. 
tests = TestList [ TestLabel "Problem 1a- test4 " p1a_test4,
                   TestLabel "Problem 1a- test5 " p1a_test5,
                   TestLabel "Problem 1a- test6 " p1a_test6,

                   TestLabel "Problem 1b- test4 " p1b_test4,
                   TestLabel "Problem 1b- test5 " p1b_test5,
                   TestLabel "Problem 1b- test6 " p1b_test6,

                   TestLabel "Problem 1c- test5 " p1c_test5,
                   TestLabel "Problem 1c- test6 " p1c_test6,

                   TestLabel "Problem 2- test5 " p2_test5,
                   TestLabel "Problem 2- test5 " p2_test6,

                   TestLabel "Problem 3a- test5 " p3a_test5,
                   TestLabel "Problem 3a- test6 " p3a_test6,

                   TestLabel "Problem 3b- test5 " p3a_test5,
                   TestLabel "Problem 3b- test6 " p3a_test6,

                   TestLabel "Problem 4- test4 " p4_test4,
                   TestLabel "Problem 4- test5 " p4_test5,

                   TestLabel "Problem 5- test4 " p5_test4,
                   TestLabel "Problem 5- test5 " p5_test5,

                   TestLabel "Problem 6- test4 " p6_test4,
                   TestLabel "Problem 6- test5 " p6_test5
                 ] 
                  
-- shortcut to run the tests
run = runTestTT  tests
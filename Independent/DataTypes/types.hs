{-
All the types we have used so far are provided by std. lib. Prelude
Sometimes, we need entirely new types to be able to model data properly.
-}
{-**EXPORTING FXNS AND TYPES WE DEFINED IN THIS MODULE**-}
module Shapes   
( Point(..)  
, Shape(..)  
, surface  
, nudge  
, baseCircle  
, baseRect  
) where
data Bool = False | True
-- parts after '=' are called value constructors
    -- specify the different values that this type can have

-- Circle value constructor: three fields (floats); coordinates of center, radius
-- Rectangle value constructor: four fields (floats); coordinates to its upper left corner and coordinates to lower right one
--data Shape = Circle Float Float Float | 
             --Rectangle Float Float Float Float
             --deriving (Show)

-- ghci> :t Circle
    -- Circle :: Float -> Float -> Float -> Shape

-- FXN: Takes a shape and returns its surface
-- NOTE: Circle is not a type, Shape is a type
--surface :: Shape -> Float
--surface (Circle _ _ r) = pi * r ^ 2
--surface (Rectangle x1 y1 x2 y2) = (abs $ x2 - x1) * (abs $ y2 - y1)

-- ghci> surface $ Circle 10 20 10
    -- 314.15927
-- NOTE: 'Circle 10 20 10' would fail
    -- need to make our Shape type part of the Show typeclass

-- LET'S IMPROVE OUR DATA TYPE
data Point = Point Float Float deriving (Show)  
data Shape = Circle Point Float | Rectangle Point Point deriving (Show)  

surface :: Shape -> Float  
surface (Circle _ r) = pi * r ^ 2  
surface (Rectangle (Point x1 y1) (Point x2 y2)) = (abs $ x2 - x1) * (abs $ y2 - y1)  

-- ghci> surface (Rectangle (Point 0 0) (Point 100 100))
    -- 10000.0
-- ghci> surface (Circle (Point 0 0) 24)  
    -- 1809.5574

baseCircle :: Float -> Shape
baseCircle r = Circle (Point 0 0 ) r

baseRect :: Float -> Float -> Shape
baseRect width height = Rectangle (Point 0 0) (Point width height)

nudge :: Shape -> Float -> Float -> Shape
nudge (Circle (Point x y) r) a b = Circle (Point (x+a) (y+b)) r  
nudge (Rectangle (Point x1 y1) (Point x2 y2)) a b = Rectangle (Point (x1+a) (y1+b)) (Point (x2+a) (y2+b))  
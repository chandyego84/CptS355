## Parameterized types
```
equal :: Eq a => a -> a-> Bool
equal x y = (x == y)
```
```
bigger :: Ord a => a -> a -> Bool
bigger x y = (x > y)
```
```
myNum :: Num p => p
myNum = 3
```
- Num, Eq, Ord are all type classes; p and a are type variables

## Haskell Tuples
A tuple combines multiple components into one compound value
- Values in a tuple can be of different types.
- Values in a tuple has a specific order.
```
myTuple :: (Bool, Integer, String)
myTuple = (True, 1, "one")

nestedTuple :: (Bool, (Integer, String), Double)
nestedTuple = (True, (2,"two"), 2.0)
```

Decomposing values of a pair (2-tuple):
```
fst (True, (2,"two")) -- returns the first element : True
snd (True, (2,"two")) -- returns the second element (2,"two")
```

EXAMPLE functions taking tuple as argument:
```
swap :: (Integer, String) -> (String, Integer)
swap (x,y) = (y,x)

swap (2, "two")      -- will return ("two", 2) 
swap ("2","two")    -- will give a type error (see the type signature)
```

```
strPair :: Integer -> (Integer, String)
strPair x = (x, show x)

strPair 5  -- will return (5,"5") 
```

## Haskell Lists
- Haskell lists can be of arbitrary size. They can have values of various types, but all elements must be the same type.
```
tenPrimes :: [Integer]
tenPrimes = [2, 3, 5, 7, 11, 13, 17, 19, 23, 27]
```

- We don't need to explitcitly write every single element if our lists elements are a sequence of consecutive numbers--or any type whose values can be enumerated
```
oneToTwenty :: [Integer]
oneToTwenty = [1..20]
```
```
-- return all positive odd numbers up to maxNumber
oddNumbers :: Integer -> [Integer]
oddNumbers maxNumber = [1,3..maxNumber]

oddNumbers 10 – will return [1, 3, 5, 7, 9]
```

- The difference between tuples and lists can be seen:
```
(1, 2, "green") :: (Integer, Integer, String)
```
```
[1, 2, 3, 4] :: [Integer]
```
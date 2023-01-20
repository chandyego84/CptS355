## Building Blocks: Functions

A function has two components:
- Input: arguments passed to fxn
- Output: result of running fxn

Functions are first class: treated like any other value
- can be passed into other functions
- can be returned from other functions

In Haskell, every value, expression, and function has a type

Some basic types:
- Bool - True or False
- Char - a unicode code point (i.e., a character)
- Int - fixed-size integer
- Integer - arbitrary-size integer
- Double - IEEE double-precision floating-point number
- String - an alias for [Char]
- type1->type2 - a function from type1 to type2
- (type1, type2, ..., typeN) - a tuple
- [type1] - a list

## Bindings
Haskell uses the "=" sign to declare bindings:
```
x = 2
y = 3
main = let z = x + y    -- let introduces local bindings
    in print z  -- program will print 5
```
- Bound names cannot start w/ upper-case letters
- Bindings are separated by ";"

A binding may declare a function of one or more arguments
- Function and arguments are separated by spaces (when defining or invoking them)

Paraentheses can wrap compound expressions, must do so for arguments
```
bad = print add 2 3 -- views add as an argument
main = print (add 2 3)
```

## Functions
Map input values to output values
```
add arg1 arg2 = arg1 + arg2 -- defines function add

five = add 2 3 -- invokes function add

exclaim sentence = sentence ++ "!" -- defines function exclaim

s = exclaim "Hello" -- invokes function exclaim
```

## Type Signatures (of functions)
- A complete function definition (w/ type signature) appears as follows:
```
double ::(Integer -> Integer) -- type signature
double x = 2*x -- function expression
```

## More on Functions
```
average :: Float -> Float -> Float
average a b = (a + b) / 2.0
a = average 3.0 4.0
```
- The type of a function w/ more than one argument eparates the arguments with an arrow
- Function application happens one argument at a time ("currying")

## Parameterized Types
Types can have parameters sort of the way functions do!
```
myNum :: Num p => p
myNum = 3
```
```
pi :: Floating a => a
pi = 3.141592653
```
Num, Ed, Ord are all types classes; p and a are variables
```
concat x y = x ++ y
```
```
first a b = a
```

## Haskell List Processing
The : operator appends an item to the head of an already existing list.
- ":" is pronounced "cons"
- Takes a value and a list and returns a list where the value is added to the beginning of the list.
- ":" is right-associative

Examples:
- `"blue" : [] ⇒ ["blue"]`
- `"yellow":["red","green","blue"] ⇒ ["yellow","red","green","blue"]`
- `"yellow":"red":"green":"blue":[] ⇒ ["yellow","red","green","blue"]`
- `["red", "green", "blue"] : "yellow" ⇒ Error!`

The cons-operator is another example of a polymprhic function, as it works on lists of any type.
- Only restriction is that the element we are adding is of the same type as the
`(:) :: a -> [a] -> [a]`

## Some basic list functions
- Appending two lists
```
(++) :: [a] -> [a] -> [a]
[1,2,3] ++ [4,5,6,7] ⇒ [1,2,3,4,5,6,7]
["red","green","blue"] ++ ["yellow"] ⇒["red","green","blue“,"yellow"]
```

- Extract the element at a specific index position out of a list
```
(!!) :: [a] -> Int -> a
["zero","one","two","three","four","five","six"] !! 5 ⇒"five"
"CptS355“ !! 4 ⇒'3'
```

## Conditionals: if/else
- Examples of if/else statements:
```
max' :: Ord a => a -> a -> a
max' x y = if x >= y then x else y
```
```
signum' :: (Ord a, Num a) => a -> Integer
signum' x = if x < 0 then -1 else if x == 0 then 0 else 1
```

## Conditionals: guards
- Cascading conditional expressions are difficult to read; guards provide an easier syntax
```
signum :: (Ord a, Num a) => a -> Int
signum x = if x < 0 then -1 else if x == 0 then 0 else 1
```
```
signum :: (Ord a, Num a) => a -> Int
signum x | x < 0 = -1
         | x == 0 = 0
         | x > 0 = 1
```
- Guards are checked in the order they are listed
- Usually, last guard should catch all cases not covered before.
(We use the special guard _otherwise_, which always evaluates to True)
```
signum :: (Ord a, Num a) => a -> Int
signum x | x < 0 = -1
         | x == 0 = 0
         | otherwise = 1
```

## Patterns
We can access components of lists (or tuples) directly by using patterns. The context in which the identifier appears tells us the part of the structure it references.

Examples:
```
x::(Integer,Integer)
x = (1,2)
(h,t) = x           --h will be assigned to 1 and t will be assigned to 2

myList::[Integer]
myList = [1,2,3]
[v1,v2,v3] = myList --v1, v2, and v3 will be assigned to 1,2, and 3, respectively. 
[1,v4,3] = myList --v4 will be assigned to 2

[1,ys] = myList -- This won’t work. Why? 
(x:ys) = myList --x will be assigned to 1 and ys will be assigned to [2,3]
```

An underscore (_) may be used as a “wildcard” or “don’t care” 
symbol. It matches part of a structure without defining a new 
binding. 
```
y:_  = ['c','a','t'] -- y will be assigned to 'c’

_:xs = ['c','a','t'] -- xs will be assigned to ['a','t'] or 'at'
```

- Patterns can be nested too
```
x :: ((Integer,Double),Integer) 
nestedTuple = ((1,3.0),5) 

((_,y),_) = nestedTuple -- y will be assigned to 3.0
```
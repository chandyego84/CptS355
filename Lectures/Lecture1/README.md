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
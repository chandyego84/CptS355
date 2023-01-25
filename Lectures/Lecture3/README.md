## Patterns
In Haskell we can access components of lists (or tuples) directly by using patterns. The context in which the identifier appears tells us the part of the structure it references.

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

An underscore may be used as a "wildcard" or "don't care" symbol. It matches part of a structure without defining a new binding.
```
y:_  = ['c','a','t'] -- y will be assigned to 'c’
_:xs = ['c','a','t'] -- xs will be assigned to ['a','t'] or 'at'
```

Patterns can be nested too:
```
x :: ((Integer,Double),Integer) 
nestedTuple = ((1,3.0),5) 

((_,y),_) = nestedTuple -- y will be assigned to 3.0
```

```
How can I extract the class, grade value from the first tuple of the below list?

courses  = [("CptS355",3), ("CptS322",4), ("CptS360",2), ("CptS321",3)]
```

## Pattern matching in functions: cons
- We use pattern matching to decompose lists into their first element and the rest of the list.

Head of a list (head in Prelude):
```
-- Partial function
head':: [a] -> a
head' (x:xs) = x
```
```
head' :: [a] -> a
head' [] = error "head: empty list"
head' (x:_) = x
```

Tail of a list (tail in Prelude)
```
-- Partial function
tail' :: [a] -> [a]
tail' (x:xs) = xs
```
```
tail' :: [a] -> [a]
tail' [] = error "tail: empty list"
tail' (_:xs) = xs
```

Check if a list is empty (null in Prelude):
```
isNull :: Eq a => [a] -> Bool
isNull x = if x==[] then True else False
```
vs
```
isNull :: [a] -> Bool
isNull [] = True
isNull (x:xs) = False
```

## Haskell is a pure functional language
Unlike variables in imperative languages, Haskell bindings are:
- immutable - can only bind a symbol once in a given scope (We still call bound symbols "variables" though)
```
x = 5
x = 6 -- error, cannot re-bind x
```

- order-independent - order of bindings in source code does not matter
- lazy - definitions of symbols are evaluated only when needed
```
safeDiv x y =
    let q = div x y            -- safe as q never evaluated if y == 0
     in if y == 0 then 0 else q
main = print (safeDiv 1 0)     -- prints 0
```

## Role of variable
- variables are immutable
- just maps  to a value that it is bound to
- no "Assignment statement" for changing what a variable maps to

## How to program w/out mutable variables?
In C, ex.:
```
long factorial (int n)
{
    long result = 1;
    while (n > 1)
        result *= n--;
    return result;
}
```

In Haskell:
We use recursion to "re-bind" argument symbols in new scope.
```
factorial n = if n > 1
            then n * factorial (n-1)
            else 1
```
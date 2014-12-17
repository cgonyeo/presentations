% How to Haskell
% Derek Gonyeo

## Haskell!

Haskell is:

> "...a general-purpose purely functional programming language, with non-strict
> semantics and strong static typing."

~ Wikipedia

# Functional Programming and Haskell

## Purity

> "...purely functional programming language..."

In Haskell, the only thing a pure function can do is return a value. All pure
functions are incapable of causing __side effects__. A side effect is anything
that modifies some global state, does IO, or impacts anything outside of the
function itself.

Functions that have side effects (the impure ones) need to be marked as such.

## Laziness

> "...with non-strict semantics..."

Haskell is Lazy. It doesn't do anything until the last possible second. If we
have some expression:

```haskell
let x = 2 + 2
```

Haskell will write down that x is equal to the function `+` applied to `2` and
`2`. It doesn't figure out that it equals 4 until you ask it to do something
that requires the value of x.

We'll see how this is useful in a bit.

## Types

> "...and strong static typing."

Haskell has an awesome type system. It moves a lot of errors from run time to
compile time, and often makes problems easier to reason about once you get used
to it. 

For example `NullPointerException`s are completely impossible, and if a function
is going to do something like interact with the network or disk they're marked
as doing `IO`, and you have to handle them as such.

## Immutable data

In Haskell the goal is to always operate on _immutable_ data. If we are ever
modifying the value of a variable, something has gone horribly wrong.

When we need to change something, instead of modifying a variable we create a
copy with different values. Unchanged parts between the two can be shared, to
help with efficiency.

## Referential Transparency

Functions in Haskell are purely mathematical, and can't have some internal
state. If you call a function multiple times with the same parameters, it has to
return the same value every time.

_Referential transparency_ is the property that any call of a function can be
replaced with its body, without altering the behavior of the program (ignoring
efficiency).

## Higher Order Functions

A higher order function is a function that takes other functions as arguments.
These are key to easily and succinctly building very powerful abstractions to
work with our data.

# Using The Language

## Functions

Example function:

```haskell
example :: String -> String
example str = str ++ " says hello, World!"
```

Would be called like:

```haskell
example "JD"
```

## A Note on Functions

All the operators made of symbols are actually functions (so `+`,`-`,`/`,`*`).
When a function is made of non-alphanumeric symbols, by default it's called in
infix notation. To call it like a normal function, wrap it in parenthesis.

Normal functions can also be called using infix notation, just wrap them in
back ticks.

```haskell
let add = (+)

5 + 3
(+) 5 3

add 5 3
5 `add` 3
```

## If Statement

Evaluates the boolean expression, and then one or the other of the expressions
is evaluated and returned.

```haskell
example2 :: String -> String
example2 n = if n == "JD"
                then "JD says Hello, World!"
                else n ++ " says Haskell is neat."
```

## Case Statement

```haskell
example3 :: String -> String
example3 n = case n of
                "JD"     -> "JD says Hello, World!"
                "Travis" -> "Travis says What's up, trumper?"
                _        -> n ++ " says 38 sure was great."
```

## Pattern matching

```haskell
example4 :: String -> String
example4 "JD"     = "JD says Hello, World!"
example4 "Travis" = "Travis says What's up, trumper?"
example4 n        = n ++ " says 38 sure was great."
```

## Lists

```haskell
eboard = ["Sauce","Jeff","Lynch","Tal","Jackie","Travis","Gambogi","Derek"]
```

You can also define ranges over enumerable types.

```haskell
examplelist = [1..10]
```

## Recursion

```haskell
example5 :: [String] -> [String]
example5 [] = []
example5 (h:t) = (h ++ " is dumb!"):(example5 t)
```

# Laziness

## Expressions

In Haskell, nothing is evaluated until you do something that requires its value.
You can view this in `ghci` with the `:sprint` command

_(for some reason the types on things must be specified for this to work)_

## Lists

With laziness, infinite lists become trivial.

```haskell
let x = [0..]
```

Just don't ask for the entire list, ask for pieces of it.

```haskell
take 20 x
```

## Infinite other things

You can also use laziness to build infinite trees/graphs/whatever.

## Be aware of laziness

If you set a variable to something that in your program doesn't make sense:

```haskell
let x = [0..]
```

Your program can (and will) not blow up until you try to use the value.

```haskell
print x
```

And you'll spend hours staring at your print statement instead of looking at
where x was assigned.

# Types

## Common Types

- `Int`
- `Double`
- `String`
- `Char`
- `Bool`

There are an absurd number of types in Haskell, and there's no such thing as a
"primitive".

## Lists

Lists are just a type wrapped in `[]`s. A list can be made of any type.

Under the hood, [] notation is actually just a wrapper for a less convenient
syntax:

```haskell
[1,2,3] == 1:2:3:[]
```

Accessing the first element has a lookup time of O(1), the last element is O(n).
Removing the first and last element have the same respective efficiencies.

## Aliasing Types

You can make type synonyms to make your program clearer. This is done with the
`type` keyword.

For example:

```haskell
type Speed = Int

isSpeeding :: Speed -> Bool
isSpeeding s = s > 55
```

Also here's a little secret. This is the definition for `String` in the standard
library:

```haskell
type String = [Char]
```

## Making Types

A type is declared with the `Data` keyword. Ignore the `deriving` bit, I'll
cover that next.

```haskell
data Bool = False | True deriving(Show,Eq)
```

This is the definition for `Bool` in the standard library. Type `Bool` has two
different values it can be, `False` and `True`.

You could likewise define other things like the months.

```haskell
data Month = January | February | March | April | May | June | July | August
             | September | October | November | December deriving (Show)
```

## Types From Other Types

Types can also have fields on them.

```haskell
data Rectangle = Rectangle Int Int deriving (Show)
```

Here we define the type `Rectangle`, and a constructor with the same name that
takes two `Int`s.

Or alternatively:

```haskell
type Height = Int
type Width = Int
data Rectangle' = Rectangle' Height Width deriving (Show)
```

## Record Syntax

Let's say we have an application that keeps track of people. In cases where a
type will have a lot of fields, there's record syntax:

```haskell
data Person = Person { firstName :: String
                     , lastName  :: String
                     , age       :: Int
                     , weight    :: Double
                     } deriving(Show)
```

This also makes getters for each field. With this you can make a person in two ways:

```haskell
let bobby = Person "Rob" "Glossop" 20 354.2
let julien = Person { firstName = "Julien"
                    , lastName  = "Eid"
                    , age       = 20
                    , weight    = 160.5
                    }
```

## Type Parameters

Type definitions can also take other types as parameters. As an example, here's
the `Maybe` type:

```haskell
data Maybe a = Nothing | Just a
```

In `Maybe`, `a` can be any type. It can be `Int`, or `String`, or the `Person`
we defined. A thing of type `Maybe` can be either `Nothing`, or `Just a`. So for
example, we could have a lookup function:

```haskell
lookup :: [(String,String)] -> String -> Maybe String
lookup [] _ = Nothing
lookup [(k,v):lst] k' = if k == k'
                            then Just v
                            else lookup lst k'
```

# Typeclasses

## Not OOP-like Classes

Typeclasses are not classes in the sense of OOP, they're actually closer to
interfaces (but a lot better). Typeclasses define functions that must be
implemented whenever a type wants to be a member of the typeclass.

For example, let's look at the typeclass `Eq`.

```haskell
class Eq a where
    (==) :: a -> a -> Bool
    (/=) :: a -> a -> Bool
```

So any types that are a member of `Eq` must implement `==` and `/=`. `Int` and
`String` are both members of `Eq`, this is why we can do `if s == "JD"`.

## Type constraints

If we look at the type of `==` we see:

```haskell
(==) :: (Eq a) => a -> a -> Bool
```

This is called a _type constraint_, and means that `==` can only be called on
types that are members of `Eq`.

## Other useful typeclasses

`Ord` is for elements that can be ordered.

```haskell
class Eq a => Ord a where
    compare :: a -> a -> Ordering
    (<)     :: a -> a -> Bool
    (>=)    :: a -> a -> Bool
    (>)     :: a -> a -> Bool
    (<=)    :: a -> a -> Bool
    min     :: a -> a -> a
    max     :: a -> a -> a
```

`Enum` is for elements that can be enumerated. Allows for `..` syntax in lists.

```haskell
class Enum a where
    toEnum   :: Int -> a
    fromEnum :: a -> Int
    (other ommitted stuff)
```

## Show and Read

`Show` and `Read` are for converting types to and from strings, respectively.

```haskell
class Show a where
    show :: a -> String
```

```haskell
class Read a where
    read :: String -> a
```

## Deriving Typeclasses

In a lot of cases, the implementations required to make a type a member of a
typeclass are obvious. In our `Rectangle` type, two `Rectangles` are equal if
both of their dimensions are equal. In cases like this, Haskell can figure out
these implementations on it's own, all that's required is to tell it which
typeclasses to add our type to. That was the `deriving` bit from before.

```haskell
data Rectangle = Rectangle { height :: Int
                           , width  :: Int
                           } deriving (Show,Read,Eq)
let x = show (Rectangle 1 4)
let r = read "Rectangle 4 10"
let b = r == (Rectangle 4 10)
```

# Higher Order Functions

## Currying

Currying is the act of partially applying functions. In Haskell, when you give a
function fewer arguments than it can take, it returns a function that takes the
remaining arguments and applies them.

For example:

```haskell
let add3 = (+ 3)
add3 10
let emphasize = (++ "!")
emphasize "Haskell is awesome"
```

## Lambdas

Lambdas are little unnamed functions. They're really useful for passing around
on things, which we'll see in a bit. You define them like:

```haskell
(\x -> x + 2)
```

This returns a function that takes a number and adds 2 to it.

## Map

```haskell
map :: (a -> b) -> [a] -> [b]
```

`map` takes two things, a function and a list, and returns a list with that
function applied to every element in the list.

```haskell
let lst = [1..12]
let lst' = map (\x -> 10^x) lst
print lst'
```

## Filter

```haskell
filter :: (a -> Bool) -> [a] -> [a]
```

`filter` takes a function that returns a boolean value and a list, and returns
all the elements in the list that the function returns true for.

```haskell
filter even [1..10]
```

## Fold

```haskell
foldl :: (b -> a -> b) -> b -> [a] -> b
```

Fold is used to accumulate up all the values in a list. It takes a function, a
starting value, and a list.

```haskell
foldl (\accum x -> accum + x) 0 [1..10]
```

`foldl` accumulates the values starting at the left and working right, and
`foldr` does the same thing in the other direction.

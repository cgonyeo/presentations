% How to Haskell
% Derek Gonyeo

## Haskell!

Haskell is:

> "...a general-purpose purely functional programming language, with non-strict
> semantics and strong static typing."

~ Wikipedia

# Functional Programming

## Purity

> "...purely functional programming language..."

In Haskell, the only thing a pure function can do is return a value. All pure
functions are incapable of causing __side effects__. A side effect is anything
that modifies some global state, does IO, or impacts anything outside of the
function itself.

Functions that have side effects (the impure ones) need to be marked as such.


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
replaced with it's body, without altering the behavior of the program (ignoring
efficiency).

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

## Types

> "...and strong static typing."

Haskell has an awesome type system. It can catch a lot of common errors at
compile time, and it moves a lot of errors from run time to compile time.
`NullPointerException`s are completely impossible. If a function is going to do
something like interact with the network or disk they're marked as doing `IO`,
and you have to handle them as such. We'll see more on this later.

# Using The Language

## Functions

Example function:

```haskell
Function name
  ||  Is of type
  ||    || Takes a String
  ||    ||   ||    Returns a String
  ||    ||   ||        ||  
  \/    \/   \/        \/  
example :: String -> String
example str = str ++ " says hello, World!"
        /\          /\  
        ||          ||  
     Argument       ||  
               Function body
```

Would be called like:

```haskell
example "JD"
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
example3 :: Sring -> String
example3 n = case n of
                "JD"     -> "JD says Hello, World!"
                "Travis" -> "Travis says しんでください"
                _        -> n ++ " says 38 sure was great."
```

## Pattern matching

```haskell
example4 :: String -> String
example4 "JD"     = "JD says Hello, World!"
example4 "Travis" = "Travis says Goodbye, World!"
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
example5 (h:t) = (h ++ " is dumb!"):(isDumb2 t)
```

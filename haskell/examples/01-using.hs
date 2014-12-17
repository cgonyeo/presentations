example :: String -> String
example str = str ++ " says hello, World!"

example2 :: String -> String
example2 n = if n == "JD"
                 then "JD says Hello, World!"
                 else n ++ " says Haskell is neat."

example3 :: String -> String
example3 n = case n of
                "JD"     -> "JD says Hello, World!"
                "Travis" -> "Travis says What's up, trumper?"
                _        -> n ++ " says 38 sure was great."

example4 :: String -> String
example4 "JD"     = "JD says Hello, World!"
example4 "Travis" = "Travis says What's up, trumper?"
example4 n        = n ++ " says 38 sure was great."

eboard = ["Sauce","Jeff","Lynch","Tal","Jackie","Travis","Gambogi","Derek"]

examplelist = [1..10]

example5 :: [String] -> [String]
example5 [] = []
example5 (h:t) = (h ++ " is dumb!"):(example5 t)

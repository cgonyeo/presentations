type Speed = Int

isSpeeding :: Speed -> Bool
isSpeeding s = s > 55

data Month = January | February | March | April | May | June | July | August
             | September | October | November | December deriving(Show)

data Rectangle = Rectangle Int Int deriving(Show)

type Height = Int
type Width = Int
data Rectangle' = Rectangle' Height Width deriving(Show)

data Person = Person { firstName :: String
                     , lastName  :: String
                     , age       :: Int
                     , weight    :: Double
                     } deriving(Show)

bobby = Person "Rob" "Glossop" 20 354.2

julien = Person { firstName = "Julien"
                , lastName  = "Eid"
                , age       = 20
                , weight    = 160.5
                }

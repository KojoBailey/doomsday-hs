# Doomsday Haskell
[Doomsday.hs](/blob/main/Doomsday.hs) contains the function `dayOf` that calculates the day for any Gregorian calendar date via John Conway's [Doomsday algorithm](https://en.wikipedia.org/wiki/Doomsday_rule).

For example, `dayOf 2006 July 17` will give `Monday`, which is indeed the day that the 17th of July, 2006 falls on. You can run the script with GHCi.

I learned how to do this in my head, so I figured it'd be a little bit of fun to implement the algorithm in Haskell.

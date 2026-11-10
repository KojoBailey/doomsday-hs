type IsLeapYear = Bool

data Day
  = Sunday
  | Monday
  | Tuesday
  | Wednesday
  | Thursday
  | Friday
  | Saturday
  deriving (Show, Read, Eq, Ord)

toDay :: Integer -> Day
toDay 0 = Sunday
toDay 1 = Monday
toDay 2 = Tuesday
toDay 3 = Wednesday
toDay 4 = Thursday
toDay 5 = Friday
toDay 6 = Saturday

fromDay :: Day -> Integer
fromDay Sunday    = 0
fromDay Monday    = 1
fromDay Tuesday   = 2
fromDay Wednesday = 3
fromDay Thursday  = 4
fromDay Friday    = 5
fromDay Saturday  = 6

data Month
  = January 
  | February
  | March
  | April
  | May
  | June
  | July
  | August
  | September
  | October
  | November
  | December
  deriving (Show, Read, Eq, Ord)

toMonth :: Integer -> Month
toMonth 01 = January
toMonth 02 = February
toMonth 03 = March
toMonth 04 = April
toMonth 05 = May
toMonth 06 = June
toMonth 07 = July
toMonth 08 = August
toMonth 09 = September
toMonth 10 = October
toMonth 11 = November
toMonth 12 = December

fromMonth :: Month -> Integer
fromMonth January   = 01 
fromMonth February  = 02 
fromMonth March     = 03 
fromMonth April     = 04 
fromMonth May       = 05 
fromMonth June      = 06 
fromMonth July      = 07 
fromMonth August    = 08 
fromMonth September = 09 
fromMonth October   = 10 
fromMonth November  = 11 
fromMonth December  = 12 

monthDoomsday :: Month -> IsLeapYear -> Integer
monthDoomsday January   False = 03
monthDoomsday January   True  = 04
monthDoomsday February  False = 28
monthDoomsday February  True  = 29
monthDoomsday March     _     = 14
monthDoomsday April     _     = 04
monthDoomsday May       _     = 09
monthDoomsday June      _     = 06
monthDoomsday July      _     = 11
monthDoomsday August    _     = 08
monthDoomsday September _     = 05
monthDoomsday October   _     = 10
monthDoomsday November  _     = 07
monthDoomsday December  _     = 12

-- Gregorian only
-- 21 = 2000s
centuryAnchor :: Integer -> Day
centuryAnchor 3 = Friday
centuryAnchor 0 = Wednesday
centuryAnchor 2 = Sunday
centuryAnchor 1 = Tuesday
centuryAnchor century = centuryAnchor $ century `mod` 4

yearAnchor :: Integer -> Day
yearAnchor year = centuryAnchor $ ((year - (year `mod` 100)) `div` 100) + 1

yearDoomsday :: Integer -> Day
yearDoomsday year = toDay $ (`mod` 7) $ sum [last2digits `div` 12, remainder, remainder `div` 4, fromDay (yearAnchor year)]
  where
    last2digits = year `mod` 100
    remainder = last2digits `rem` 12

dayOf :: Integer -> Month -> Integer -> Day
dayOf year month dd = toDay $ (dd - (monthDoomsday month isLeapYear) + fromDay (yearDoomsday year)) `mod` 7
  where isLeapYear = year `mod` 4 == 0

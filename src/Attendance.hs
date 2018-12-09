module Attendance
  (createAttendant,
  deleteAttendant,
  listAttendants,
  attend,
  hide,
  listAttendancies)
where

import Attendant
import AttendanceMark
import Data.Time.Calendar
import ValidationError
import qualified Domain

createAttendant :: String -> String -> Either ValidationError Attendant
createAttendant = Domain.saveAttendant

listAttendants :: [Attendant]
listAttendants = [Attendant "Test" "User"]

deleteAttendant :: Attendant -> Maybe Attendant
deleteAttendant = Domain.deleteAttendant

attend :: Attendant -> Day -> Either ValidationError AttendanceMark
attend = Domain.attend

hide :: AttendanceMark -> Maybe AttendanceMark
hide = Domain.hide

listAttendancies :: a -> a
listAttendancies a = a

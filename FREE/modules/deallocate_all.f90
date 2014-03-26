!
! Copyright (C) 2013 A. Dal Corso 
! This file is distributed under the terms of the
! GNU General Public License. See the file `License'
! in the root directory of the present distribution,
! or http://www.gnu.org/copyleft/gpl.txt .
!
SUBROUTINE deallocate_all
USE freemod, ONLY : g, et, xk, wk
IMPLICIT NONE

DEALLOCATE(g)
DEALLOCATE(et)
DEALLOCATE(xk)
DEALLOCATE(wk)

RETURN
END SUBROUTINE deallocate_all

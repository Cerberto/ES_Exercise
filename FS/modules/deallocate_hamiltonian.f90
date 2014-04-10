!
! Copyright (C) 2013 A. Dal Corso 
! This file is distributed under the terms of the
! GNU General Public License. See the file `License'
! in the root directory of the present distribution,
! or http://www.gnu.org/copyleft/gpl.txt .
!
SUBROUTINE deallocate_hamiltonian
USE fsmod, ONLY : h, evc, et
IMPLICIT NONE

DEALLOCATE(h)
DEALLOCATE(evc)
DEALLOCATE(et)

RETURN
END SUBROUTINE deallocate_hamiltonian

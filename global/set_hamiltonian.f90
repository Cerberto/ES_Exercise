!
! Copyright (C) 2013 A. Dal Corso 
! This file is distributed under the terms of the
! GNU General Public License. See the file `License'
! in the root directory of the present distribution,
! or http://www.gnu.org/copyleft/gpl.txt .
!
SUBROUTINE set_hamiltonian(xk,ecut,npw)
!
!  This routine sets the free electron Hamiltonian. 
!
USE kinds, ONLY   : dp
USE freemod, ONLY   : g, et, ngm, nbnd

IMPLICIT NONE

REAL(DP), INTENT(IN) :: xk(3), ecut
INTEGER, INTENT(OUT) :: npw

INTEGER      :: ibnd, ig
REAL(DP)     :: t(3), tt
REAL(DP), ALLOCATABLE :: xkpg2(:)
INTEGER,  ALLOCATABLE :: igk(:)

ALLOCATE(xkpg2(ngm))
ALLOCATE(igk(ngm))
!
!  Compute all k+G within a sphere of radius sqrt(ecut) 
!
npw=0
DO ig=1,ngm
   t(:) = xk(:) + g(:,ig) 
   tt   = t(1) * t(1) + t(2) * t(2) + t(3) * t(3)
   IF (tt <= ecut ) THEN
      npw = npw + 1
      xkpg2 (npw) = tt 
      igk (npw) = npw
   END IF
END DO
IF (npw < nbnd) THEN
   write(6,*) "Too few plane waves, increase cut-off"
   stop 1
ENDIF 
!
!  Order the k+G vectors 
!
CALL hpsort(npw, xkpg2, igk )
!
!  The matrix is already diagonal, so take the lowest nbnd eigenvalues
!
et(1:nbnd)=xkpg2(1:nbnd)

DEALLOCATE(xkpg2)
DEALLOCATE(igk)

RETURN
END SUBROUTINE set_hamiltonian


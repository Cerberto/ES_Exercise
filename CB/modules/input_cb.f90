!
! Copyright (C) 2013 A. Dal Corso 
! This file is distributed under the terms of the
! GNU General Public License. See the file `License'
! in the root directory of the present distribution,
! or http://www.gnu.org/copyleft/gpl.txt .
!
SUBROUTINE input_cb()
USE kinds, ONLY : dp
USE cbmod, ONLY : xk, wk, nks, nbnd, ecut
USE cbmod, ONLY : crystal_name

IMPLICIT NONE
INTEGER :: nks_dum
REAL(DP), ALLOCATABLE :: xk_dum(:,:)
INTEGER, ALLOCATABLE :: nk_dum(:)
REAL(DP) :: xkmod
REAL(DP) :: delta_k(3)

INTEGER :: ik, jk

WRITE(6,'("Crystal name?")') 
READ(5,*) crystal_name

WRITE(6,'("Cut-off energy (units Ry / (2\pi /a )^2) ?")')
READ(5,*) ecut

WRITE(6,'("Number of bands?")') 
READ(5,*) nbnd

WRITE(6,'("Number of k points?")') 
READ(5,*) nks_dum

ALLOCATE(xk_dum(3,nks_dum))
ALLOCATE(nk_dum(nks_dum))

DO ik=1, nks_dum
   READ(5,*) xk_dum(1,ik), xk_dum(2,ik), xk_dum(3,ik), nk_dum(ik)
ENDDO

IF (nks_dum==1) THEN
   nks=nks_dum
ELSEIF (nks_dum>1) THEN
   nks=SUM(nk_dum(1:nks_dum-1))+1
   DO ik=1,nks_dum-1
      IF (nk_dum(ik)==0) nks=nks+1
   ENDDO
ELSE
   WRITE(6,*) 'input_cb'
   WRITE(6,*) 'wrong number of k points'
   STOP 1
ENDIF
ALLOCATE(xk(3,nks))
ALLOCATE(wk(nks))

IF (nks_dum==1) THEN
   xk(:,1) = xk_dum(:,1)
   wk(1) = nk_dum(1)    ! it can be any number (in the plot it does not matter)
ELSE
   ! set the first point in the plot of the energy bands
   nks=1
   xk(:,nks)=xk_dum(:,1)   ! it is the one specified at first line of input file
   wk(nks)= 0.0_DP         ! this is the ascissa of first point in the plot
   DO ik=1,nks_dum-1
      IF (nk_dum(ik) > 0 ) THEN
         ! if in the input file it is specified a positive number of k-points to
         ! get to the next one, then I partition the line between the current
         ! k-point and the next one in such a number of sub-intervals;
         ! the spacing between two successive points on the plot is the length
         ! of delta_k (or, the width of the sub-intervals)
         delta_k(:) = (xk_dum(:,ik+1)-xk_dum(:,ik))/nk_dum(ik)
         xkmod=SQRT(delta_k(1)**2+delta_k(2)**2+delta_k(3)**2)
         DO jk=1, nk_dum(ik)
            nks=nks+1
            xk(:,nks) = xk_dum(:,ik) + delta_k(:) * jk
            wk(nks) = wk(nks-1) + xkmod
         ENDDO
      ELSE
         ! if the specified # of steps to get to the next k-point is 0 (actually
         ! non-sense) then I make the two k-points (the current and the next)
         ! coincide
         nks=nks+1
         xk(:,nks) = xk_dum(:,ik+1)
         wk(nks) = wk(nks-1)
      ENDIF
   ENDDO
ENDIF

DEALLOCATE(xk_dum)
DEALLOCATE(nk_dum)

RETURN
END SUBROUTINE input_cb

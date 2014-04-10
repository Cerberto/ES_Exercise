!
! Copyright (C) 2013 A. Dal Corso 
! This file is distributed under the terms of the
! GNU General Public License. See the file `License'
! in the root directory of the present distribution,
! or http://www.gnu.org/copyleft/gpl.txt .
!
SUBROUTINE accumulate_charge(evc, rho)
!
!  This routine uses the wavefunctions at a given k to calculate
!  the contribution to the charge density.
!
USE kinds, ONLY  : dp
USE constants, ONLY : pi
USE cbmod, ONLY  : g, npw, nbnd_occ, igk, nir, r

IMPLICIT NONE

COMPLEX(DP), INTENT(IN)  :: evc(npw,nbnd_occ) 
REAL(DP),    INTENT(OUT) :: rho(nir) 

INTEGER      :: ig, jg, ir, ibnd
COMPLEX(DP) :: phase
REAL(DP) :: cur_g(3), arg, tpi
COMPLEX(DP), ALLOCATABLE :: psic(:)

ALLOCATE(psic(nir))

tpi=2.0_DP * pi

DO ibnd=1,nbnd_occ
   psic=(0.0_DP,0.0_DP)
   DO ig = 1, npw
      cur_g(:) = g(:,igk(ig)) 
      DO ir=1, nir
         arg = (cur_g(1)*r(1,ir)+cur_g(2)*r(2,ir)+cur_g(3)*r(3,ir)) * tpi
         phase=CMPLX(cos(arg), sin(arg))
         psic(ir)=psic(ir) + evc(ig,ibnd)*phase
      ENDDO
   ENDDO

!
!   2.0 accounts for spin degeneracy
!
   DO ir=1, nir
      rho(ir)=rho(ir) + 2.0_DP*CONJG(psic(ir))*psic(ir)
   ENDDO
ENDDO

DEALLOCATE(psic)

RETURN
END SUBROUTINE accumulate_charge


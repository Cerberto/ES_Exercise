!
! Copyright (C) 2013 A. Dal Corso 
! This file is distributed under the terms of the
! GNU General Public License. See the file `License'
! in the root directory of the present distribution,
! or http://www.gnu.org/copyleft/gpl.txt .
!
SUBROUTINE set_hamiltonian(xk,ecut)
!
!  This routine sets the CB Hamiltonian.
!
USE kinds, ONLY   : dp
USE constants, ONLY : pi
USE fsmod, ONLY   : g, h, evc, et, ngm, npw, nbnd, tpiba2, &
                    cbr_parameters, cbi_parameters, crystal_name, gcutm2

IMPLICIT NONE

REAL(DP), INTENT(IN) :: xk(3), ecut

INTEGER      :: i, j, indx, ig
REAL(DP)     :: dg(3), g_dot_tau, ssg, ssn, t(3), tt, dgsq
REAL(DP), ALLOCATABLE :: xkpg2(:)
INTEGER,  ALLOCATABLE :: igk(:)
REAL(DP), EXTERNAL :: form_factor

ALLOCATE(xkpg2(ngm))
ALLOCATE(igk(ngm))

npw=0
DO ig=1,ngm
   t(:) = xk(:) + g(:,ig)
   tt   = t(1) * t(1) + t(2) * t(2) + t(3) * t(3)
   IF (tt < ecut) THEN
      npw = npw + 1
      xkpg2 (npw) = tt * tpiba2
      igk (npw) = ig
   END IF
END DO

ALLOCATE( h(npw,npw) )
ALLOCATE( evc(npw,nbnd) )
ALLOCATE( et(nbnd) )

h(:,:)  = (0.0_DP,0.0_DP)
!
! Only one atomic position is needed. The origin is in the center of the
! bond.
!
IF (crystal_name == "bSn") THEN
    t(1) = 1.0_DP/4.0_DP
    t(2) = 0.0_DP
    t(3) = 0.55_DP/8.0_DP
ELSE
    t(:) = 1.0_DP/8.0_DP
END IF
!
!  Loop over G:
DO i=1, npw
!
!  The diagonal term: kinetic energy.
!
   h(i,i) = CMPLX(xkpg2(i),0.0_DP)
!
!  There is a double loop, on G and G', but we can use the hermiticity of H.
!
DO j=i+1,npw
    IF (crystal_name=="bSn") THEN
        dg(:) = g(:,igk(i)) - g(:,igk(j))
        dgsq  = dg(1)**2 + dg(2)**2 + dg(3)**2
        g_dot_tau = DOT_PRODUCT(dg(:),t(:)) * pi * 2.0_DP
        ssg       = COS(g_dot_tau)
        ssn       = SIN(g_dot_tau)
        h(i,j)    = CMPLX(ssg*form_factor(dgsq),0.0_DP)
        ! h(j,i)    = CONJG(h(i,j))
    ELSE
        !
        ! We have non vanishing terms only if |G-G'|^2 is not higher 
        ! than 11 (in units (2\pi/a)^2).
        !
        dg(:) = g(:,igk(i)) - g(:,igk(j))
        indx  = nint( dg(1)**2 + dg(2)**2 + dg(3)**2 )
        IF ( indx <= 11 ) THEN
            !
            !  tau is in units of a=alat, dg is in units (2\pi/a), 
            !  their scalar product is adimensional, but we must multiply by 2\pi before
            !  calculating the cosine and sine.
            !
            g_dot_tau = DOT_PRODUCT(dg(:),t(:)) * pi * 2.0_DP
            ssg       = COS(g_dot_tau)
            ssn       = SIN(g_dot_tau)
            !
            !    Here we set the Hamiltonian
            !
            h(i,j)   = CMPLX(ssg*cbr_parameters(indx),ssn*cbi_parameters(indx))
            !
            !  H is an hermitean operator, but the diagonalization routine does not
            !  need the lower part
            !
            !   h(j,i)   = CONJG(h(i,j))
        END IF
    END IF
END DO
END DO

DEALLOCATE(xkpg2)
DEALLOCATE(igk)


RETURN

END SUBROUTINE set_hamiltonian

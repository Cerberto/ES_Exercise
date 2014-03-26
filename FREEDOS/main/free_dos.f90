PROGRAM free_dos
!
!  This program reads from input the name of a Bravais lattice (SC, FCC, BCC) 
!  and a path of k points, and writes on output the free electron bands of 
!  that lattice along the path. Output is in units of  Ry / (2 \pi /a )^2 
!  where a is the cubic lattice constant and it is stored in the file output.
!
USE kinds,   ONLY : dp
USE freemod, ONLY : lattice_name, at, bg, ecut, gcutm2,  &
                    nks, xk, wk, ngm, et, nbnd, ldos, emin, emax, nenergy, &
                    sigma, nk1, nk2, nk3, dos
IMPLICIT NONE
INTEGER :: ik, npw, iener, ibnd, ios
REAL(DP) :: ener, deltae
REAL(DP), EXTERNAL :: gaussian
!
!  Read the input
!
CALL input_free()
!
! set the direct and reciprocal lattice vectors of the lattice
!
CALL set_lattice(at, bg, lattice_name)
!
! generate the mesh of k point for dos
!
IF (ldos) CALL kgen(nk1, nk2, nk3, bg)
!
! given ecut and the k-points, calculate the radius of the sphere in
! reciprocal space that contains all the necessary G vectors.
!
CALL calculate_radius(ecut, xk, nks, gcutm2)
!
! compute all the reciprocal lattice vectors within a sphere of radius 
! sqrt(gcutm2)
!
CALL ggen(gcutm2)
!
! open the output file
!
IF (ldos) THEN
   ALLOCATE(dos(nenergy))
   dos=0.0_DP
   IF (nenergy > 1) THEN 
      deltae=(emax-emin)/(nenergy-1)
   ELSE
      deltae=0.0_DP
      nenergy=1
   ENDIF
ELSE
   OPEN(unit=26,file='output',status='unknown',err=100,iostat=ios)
   100 IF (ios /= 0) STOP 'opening output'
ENDIF
ALLOCATE(et(1:nbnd))
DO ik=1, nks
!
!   set the band structure
!
   CALL set_hamiltonian(xk(:,ik), ecut, npw)
   IF (ldos) THEN
!
!  in this case accumulate the dos due to this band. The factor 2.0 accounts
!  for spin
!
      DO iener=1,nenergy
         ener=emin+deltae*(iener-1)
         DO ibnd=1, nbnd
            dos(iener)=dos(iener)+ 2.0_DP*gaussian(ener-et(ibnd),sigma)
         ENDDO
      ENDDO
   ELSE
!
! or write on output the eigenvalues
!
      WRITE(26,'(50f10.4)') wk(ik), et(1:nbnd)
   ENDIF
!
ENDDO
IF (nks==1) THEN
   WRITE(6,'("Number of G vectors:  ", i7)') ngm     
   WRITE(6,'("Number of plane waves:", i7)') npw
ENDIF

IF (ldos) THEN
   OPEN(unit=26,file='output',status='unknown',err=200,iostat=ios)
   200 IF (ios /= 0) STOP 'opening output'
   dos=dos/nks
   DO iener=1,nenergy
      ener=emin+deltae*(iener-1)
      WRITE(26,'(50f10.4)') ener, dos(iener)
   ENDDO
ENDIF

CALL deallocate_all()
CLOSE(26)
END PROGRAM free_dos

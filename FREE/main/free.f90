!
! Copyright (C) 2013 A. Dal Corso 
! This file is distributed under the terms of the
! GNU General Public License. See the file `License'
! in the root directory of the present distribution,
! or http://www.gnu.org/copyleft/gpl.txt .
!
PROGRAM free
!
!  This program reads from input the name of a Bravais lattice (SC, FCC, BCC) 
!  and a path of k points, and writes on output the free electron bands of 
!  that lattice along the path. Output is in units of  Ry / (2 \pi /a )^2 
!  where a is the cubic lattice constant and it is stored in the file output.
!
USE freemod, ONLY : lattice_name, at, bg, ecut, gcutm2,  &
                    nks, xk, wk, ngm, et, nbnd
IMPLICIT NONE
INTEGER :: ik, npw, ios
!
!  Read the input
!
CALL input_free()
!
! set the direct and reciprocal lattice vectors of the lattice
!
CALL set_lattice(at, bg, lattice_name)
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
OPEN(unit=26,file='output',status='unknown',err=100,iostat=ios)
100 IF (ios /= 0) STOP 'opening output'
ALLOCATE(et(1:nbnd))
DO ik=1, nks
!
!   set the band structure
!
   CALL set_hamiltonian(xk(:,ik), ecut, npw)
!
!   write on output the eigenvalues
!
   WRITE(26,'(50f10.4)') wk(ik), et(1:nbnd)
!
ENDDO
IF (nks==1) THEN
   WRITE(6,'("Number of G vectors:  ", i7)') ngm     
   WRITE(6,'("Number of plane waves:", i7)') npw
ENDIF
CALL deallocate_all()
CLOSE(26)
END PROGRAM free


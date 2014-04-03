!
! Copyright (C) 2013 A. Dal Corso 
! This file is distributed under the terms of the
! GNU General Public License. See the file `License'
! in the root directory of the present distribution,
! or http://www.gnu.org/copyleft/gpl.txt .
!
PROGRAM cb
!
!  This program reads from input the name of a crystal (Si, Ge, Sn, GaAs,
!  or InSb) and a path of k points in the fcc Brillouin zone, and writes 
!  on output the Cohen-Bergstresser bands of the crystal along that path. 
!  Output is in Ry.
!  Reference: Phys. Rev. 141, 789 (1966).
!
USE cbmod, ONLY : crystal_name, at, bg, ecut, gcutm2, nks, xk, wk, npw, &
                  ngm, nbnd, h, evc, et
IMPLICIT NONE
INTEGER :: ik, ios
!
!  Read the input
!
CALL input_cb()
!
! set the cb parameters and the size of the unit cell
!
CALL set_cb_parameters(crystal_name)
!
! set the direct and reciprocal lattice vectors of the fcc lattice
!
!CALL set_lattice(at, bg, 'fcc')

!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
! Set lattice for the centered tetragonal Beta-tin
CALL set_lattice(at, bg, 'ct')
!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!

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
OPEN(unit=26,file='outputs/output',status='unknown',err=100,iostat=ios)
100 IF (ios /= 0) STOP 'opening output'
!
!  For all k points compute and diagonalize the Hamiltonian
!
DO ik=1, nks
!
!   set the Hamiltonian 
!
   CALL set_hamiltonian(xk(:,ik), ecut)
!
!   and diagonalize it. nbnd bands are calculated.
!
   CALL diagonalize(npw, nbnd, h, et, evc)
!
!   write on output the eigenvalues
!
   WRITE(26,'(50f10.4)') wk(ik), et(1:nbnd)
!
!  deallocate the Hamiltonian variables
!
   CALL deallocate_hamiltonian()
ENDDO

CALL deallocate_all()
CLOSE(26)
END PROGRAM cb

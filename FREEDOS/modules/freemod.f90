!
! Copyright (C) 2013 A. Dal Corso 
! This file is distributed under the terms of the
! GNU General Public License. See the file `License'
! in the root directory of the present distribution,
! or http://www.gnu.org/copyleft/gpl.txt .
!
MODULE freemod
USE kinds, ONLY : DP

IMPLICIT NONE
SAVE
PUBLIC 

CHARACTER(LEN=10) :: lattice_name ! The name of the crystal

REAL(DP) :: ecut      ! Kinetic energy cut-off
REAL(DP) :: gcutm2    ! Square of the radius of the sphere in G space 

REAL(DP) :: at(3,3)   ! Direct lattice vectors
REAL(DP) :: bg(3,3)   ! Reciprocal lattice vectors

INTEGER :: ngm                   ! How many G vector we have
REAL(DP), ALLOCATABLE :: g(:,:)  ! Reciprocal lattice vectors

INTEGER  :: nbnd                 ! The number of bands
REAL(DP), ALLOCATABLE :: et(:)   ! The eigenvalues of the Hamiltonian

INTEGER :: nks                   ! The number of k points
REAL(DP), ALLOCATABLE :: xk(:,:) ! The coordinates of the k points
REAL(DP), ALLOCATABLE :: wk(:)   ! The xcoordinate of the k point for output

LOGICAL :: ldos                  ! true if compute dos
INTEGER :: nk1, nk2, nk3         ! the mesh of k points
INTEGER :: nenergy               ! number of energy points

REAL(DP) :: sigma, emin, emax    ! a real number
REAL(DP), ALLOCATABLE :: dos(:)  ! The density of states


END MODULE freemod

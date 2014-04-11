!
! Copyright (C) 2013 A. Dal Corso 
! This file is distributed under the terms of the
! GNU General Public License. See the file `License'
! in the root directory of the present distribution,
! or http://www.gnu.org/copyleft/gpl.txt .
!
MODULE cbmod
USE kinds, ONLY : DP

IMPLICIT NONE
SAVE
PUBLIC 

CHARACTER(LEN=10) :: crystal_name ! The name of the crystal

INTEGER :: check      ! Decide whether accumulating charge or not

REAL(DP) :: alat      ! Size of the unit cell
REAL(DP) :: ecut      ! Kinetic energy cut-off
REAL(DP) :: gcutm2    ! Square of the radius of the G sphere
REAL(DP) :: tpiba2    ! Two pi divided a_0

REAL(DP) :: at(3,3)   ! Direct lattice vectors
REAL(DP) :: bg(3,3)   ! Reciprocal lattice vectors

INTEGER :: ngm                   ! How many G vector we have
REAL(DP), ALLOCATABLE :: g(:,:)  ! Reciprocal lattice vectors

REAL(DP) :: cbr_parameters(11), cbi_parameters(11) ! CB parameters
INTEGER  :: npw                      ! The dimension of the Hamiltonian
INTEGER  :: nbnd                     ! The number of calculated bands
INTEGER  :: nbnd_occ                 ! number of occupated bands
INTEGER, ALLOCATABLE :: igk(:)       ! index of k+g on the G list
COMPLEX(DP), ALLOCATABLE :: h(:,:)   ! The Hamiltonian matrix
COMPLEX(DP), ALLOCATABLE :: evc(:,:) ! The wavefunctions
REAL(DP), ALLOCATABLE :: et(:)       ! The eigenvalues of the Hamiltonian

INTEGER :: nk1, nk2, nk3             ! The k points mesh
INTEGER :: nks                       ! The number of k points
REAL(DP), ALLOCATABLE :: xk(:,:)     ! The coordinates of the k points

INTEGER :: nir                        ! number of points
REAL(DP), ALLOCATABLE :: rho(:)       ! The charge density
REAL(DP), ALLOCATABLE :: r(:,:)       ! r coordinates
REAL(DP), ALLOCATABLE :: rx(:)        ! r coordinates of the plot

INTEGER :: nir_x, nir_y               ! two dimensional number of points
REAL(DP), ALLOCATABLE :: ry(:)        ! ry coordinates of the plot

INTEGER :: dimen                      ! dimensionality of the plot

REAL(DP) :: sigma       ! width of the gaussian, smearing of the theta function

END MODULE cbmod

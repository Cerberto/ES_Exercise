!
! Copyright (C) 2013 A. Dal Corso 
! This file is distributed under the terms of the
! GNU General Public License. See the file `License'
! in the root directory of the present distribution,
! or http://www.gnu.org/copyleft/gpl.txt .
!
PROGRAM fs
!
!  This program reads from input the name of a crystal (Si, Ge, Sn, GaAs,
!  or InSb) and a path of k points in the fcc Brillouin zone, and writes 
!  on output the Cohen-Bergstresser bands of the crystal along that path. 
!  Output is in Ry.
!  Reference: Phys. Rev. 141, 789 (1966).
!
USE kinds, ONLY : dp
USE fsmod, ONLY : crystal_name, at, bg, ecut, gcutm2, nks, npw, &
                  ngm, nbnd, h, evc, et, k_mesh
IMPLICIT NONE
INTEGER :: ik, ios

real(dp) :: emin, emax, f_en
real(dp), external :: fermi_level
emin = 0.0_dp
emax = 3.0_dp

!
!  Read the input
!
CALL input_fs()
!
! set the cb parameters and the size of the unit cell
!
CALL set_cb_parameters(crystal_name)
!
! set the direct and reciprocal lattice vectors of the fcc lattice
!
IF (crystal_name == "bSn") THEN
    CALL set_lattice(at, bg, 'ct')
ELSE
    CALL set_lattice(at, bg, 'fcc')
END IF

!
! given ecut and the k-points, calculate the radius of the sphere in
! reciprocal space that contains all the necessary G vectors.
!
CALL calculate_radius(ecut, k_mesh, nks, gcutm2)

!
! compute all the reciprocal lattice vectors within a sphere of radius
! sqrt(gcutm2)
!
CALL ggen(gcutm2)

!
!   print occupied bands on separate files
!
CALL print_bands()

CALL deallocate_all()
CLOSE(26)
END PROGRAM fs

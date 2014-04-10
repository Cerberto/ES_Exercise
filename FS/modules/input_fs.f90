!
! Copyright (C) 2013 A. Dal Corso 
! This file is distributed under the terms of the
! GNU General Public License. See the file `License'
! in the root directory of the present distribution,
! or http://www.gnu.org/copyleft/gpl.txt .
!
SUBROUTINE input_fs()
    USE kinds, ONLY : dp
    USE fsmod, ONLY : kx, ky, k_mesh, nks, nks_x, nks_y, nbnd, ecut
    USE fsmod, ONLY : crystal_name
    
    IMPLICIT NONE
    INTEGER :: i, j, ij
    REAL(DP) :: kin(3,3)
    REAL(DP) :: dkx, dky
    REAL(DP) :: delta_kx(3), delta_ky(3)
    
    WRITE(6,'("Crystal name?")') 
    READ(5,*) crystal_name
    
    WRITE(6,'("Cut-off energy (units Ry / (2\pi /a )^2) ?")')
    READ(5,*) ecut
    
    WRITE(6,'("Number of bands?")') 
    READ(5,*) nbnd
    
    !
    !   read origin, vectors spanning the plane and # of points of the mesh
    !
    WRITE(6,'("Number of points along the two lines?")')
    READ(5,*) nks_x, nks_y
    nks = nks_x * nks_y
    
    WRITE(6,'("Coordinates of the origin")')
    READ(5,*) kin(1,1), kin(2,1), kin(3,1)
    
    WRITE(6,'("Coordinates of the fist line")')
    READ(5,*) kin(1,2), kin(2,2), kin(3,2)
    
    WRITE(6,'("Coordinates of the second line")')
    READ(5,*) kin(1,3), kin(2,3), kin(3,3)
    
    !
    !   generate the 2-D mesk of k-points
    !
    allocate ( k_mesh(3,nks) )
    
    allocate ( kx(nks_x) )
    allocate ( ky(nks_y) )
    
    delta_kx(:) =  kin(:,2) / ( nks_x - 1 )
    delta_ky(:) =  kin(:,3) / ( nks_y - 1 )
    dkx=sqrt( delta_kx(1)**2 + delta_kx(2)**2 + delta_kx(3)**2 )
    dky=sqrt( delta_ky(1)**2 + delta_ky(2)**2 + delta_ky(3)**2 )
    
    !  mesh in the two directions
    kx(1)=0.0_DP
    do i=2, nks_x
        kx(i) = kx(i-1) + dkx
    end do
    ky(1)=0.0_DP
    do j=2, nks_y
        ky(j) = ky(j-1) + dky 
    end do
    
    ij=0
    do i=1, nks_x
        do j =1, nks_y
            ij = ij + 1
            k_mesh(:,ij) = kin(:,1) + delta_kx(:)*(i - 1) + delta_ky(:)*(j - 1)
        end do
    end do
    
    RETURN
END SUBROUTINE input_fs

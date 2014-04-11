!
! Copyright (C) 2013 A. Dal Corso 
! This file is distributed under the terms of the
! GNU General Public License. See the file `License'
! in the root directory of the present distribution,
! or http://www.gnu.org/copyleft/gpl.txt .
!
SUBROUTINE input_cb()
USE kinds, ONLY : dp
USE cbmod, ONLY : nbnd, ecut, nk1, nk2, nk3
USE cbmod, ONLY : nir, r, rx, ry, nir_x, nir_y, dimen
USE cbmod, ONLY : crystal_name, check, sigma

IMPLICIT NONE

INTEGER :: ik, jk, ir, jr, ijr
REAL(DP) :: rin(3,3), delta_r(3), delta_rx(3), delta_ry(3), dx, dy

WRITE(6,'("Crystal name?")') 
READ(5,*) crystal_name

WRITE(6,'("Accumulate charge? 0 -> No,  1 -> Yes")') 
READ(5,*) check

WRITE(6,'("Cut-off energy (units Ry / (2\pi /a )^2) ?")')
READ(5,*) ecut

WRITE(6,'("Number of bands?")') 
READ(5,*) nbnd

WRITE(6,'("Number of k points?")')
READ(5,*) nk1, nk2, nk3

WRITE(6,'("Sigma?")')
READ(5,*) sigma

WRITE(6,'("Dimension of the plot?")')
READ(5,*) dimen

IF (dimen==1) THEN
        
    WRITE(6,'("Number of points along the line?")')
    READ(5,*) nir
            
    WRITE(6,'("Coordinates of the first r point")')
    READ(5,*) rin(1,1), rin(2,1), rin(3,1)
    
    WRITE(6,'("Coordinates of the second r point")')
    READ(5,*) rin(1,2), rin(2,2), rin(3,2)

ELSE IF (dimen==2) THEN
    
    WRITE(6,'("Number of points along the two lines?")')
    READ(5,*) nir_x, nir_y
    nir = nir_x * nir_y
    
    WRITE(6,'("Coordinates of the origin")')
    READ(5,*) rin(1,1), rin(2,1), rin(3,1)
    
    WRITE(6,'("Coordinates of the first line")')
    READ(5,*) rin(1,2), rin(2,2), rin(3,2)
    
    WRITE(6,'("Coordinates of the second line")')
    READ(5,*) rin(1,3), rin(2,3), rin(3,3)
ELSE
    WRITE(6,'("Unknown dimension")')
ENDIF

IF (check == 1) THEN
    ALLOCATE ( r(3,nir) )

    IF (dimen==1) THEN
    
        ALLOCATE ( rx(nir) )
        delta_r(:) = rin(:,2) / ( nir - 1 )
        dx = sqrt( delta_r(1)**2 + delta_r(2)**2 +  delta_r(3)**2 )
        rx(1)=0.0_DP
        DO ir=1, nir
            r(:,ir) = rin(:,1) + delta_r(:) * ( ir - 1 )
            IF (ir > 1) rx(ir) = rx(ir-1) + dx
        ENDDO
    ELSE
        !
        ALLOCATE ( rx(nir_x) )
        ALLOCATE ( ry(nir_y) )

        delta_rx(:) =  rin(:,2) / ( nir_x - 1 )
        delta_ry(:) =  rin(:,3) / ( nir_y - 1 )
        dx=sqrt( delta_rx(1)**2 + delta_rx(2)**2 + delta_rx(3)**2 )
        dy=sqrt( delta_ry(1)**2 + delta_ry(2)**2 + delta_ry(3)**2 )
        rx(1)=0.0_DP
        DO ir=2, nir_x
            rx(ir) = rx(ir-1) + dx
        ENDDO
        ry(1)=0.0_DP
        DO jr=2, nir_y
            ry(jr) = ry(jr-1) + dy 
        ENDDO
        
        ijr=0
        DO ir=1, nir_x
            DO jr =1, nir_y
                ijr = ijr + 1
                r(:,ijr) = rin(:,1) + delta_rx(:) * ( ir - 1 ) + delta_ry(:) * ( jr - 1 )
            ENDDO
        ENDDO
    
    ENDIF
ENDIF


RETURN
END SUBROUTINE input_cb

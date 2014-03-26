!
! Copyright (C) 2013 A. Dal Corso 
! This file is distributed under the terms of the
! GNU General Public License. See the file `License'
! in the root directory of the present distribution,
! or http://www.gnu.org/copyleft/gpl.txt .
!
SUBROUTINE set_cb_parameters (crystal_name)
!
! This routine sets the form factors and the size of the conventional 
! cubic cell of the fcc crystal.
!
USE kinds, ONLY : dp
USE constants, ONLY : aa_to_au, pi
USE cbmod, ONLY : cbr_parameters, cbi_parameters, tpiba2, alat
IMPLICIT NONE
CHARACTER (LEN=*), INTENT(IN)  :: crystal_name
REAL(DP) :: tpiba

cbr_parameters=0.0_DP   ! symmetric
cbi_parameters=0.0_DP   ! anti-symmetric
SELECT CASE (crystal_name)
CASE ('Si')
   cbr_parameters(3)  = -0.21_DP
   cbr_parameters(8)  =  0.04_DP
   cbr_parameters(11) =  0.08_DP
   alat = 5.43_DP * aa_to_au
CASE ('Ge')
   cbr_parameters(3)  = -0.23_DP
   cbr_parameters(8)  =  0.01_DP
   cbr_parameters(11) =  0.06_DP
   alat = 5.66_DP * aa_to_au
CASE ('Sn') 
   cbr_parameters(3) = -0.20_DP
   cbr_parameters(8) =  0.00_DP
   cbr_parameters(11)=  0.04_DP
   alat =  6.49_DP * aa_to_au
CASE ('GaAs') 
   cbr_parameters(3) = -0.23_DP
   cbr_parameters(8) =  0.01_DP
   cbr_parameters(11)=  0.06_DP
   cbi_parameters(3) =  0.07_DP
   cbi_parameters(4) =  0.05_DP
   cbi_parameters(11)=  0.01_DP
   alat = 5.64_DP * aa_to_au
CASE ('InSb') 
   cbr_parameters(3) = -0.20_DP
   cbr_parameters(8) =  0.00_DP
   cbr_parameters(11)=  0.04_DP
   cbi_parameters(3) =  0.06_DP
   cbi_parameters(4) =  0.05_DP
   cbi_parameters(11)=  0.01_DP
   alat = 6.48_DP * aa_to_au
! Needed for Beta-tin ?!
CASE ('bSn')
   WRITE(6,*) 'here?'
   alat = 5.80_DP * aa_to_au
CASE DEFAULT
   WRITE(6,*) 'set_cb_parameters'
   WRITE(6,*) 'crystal name not known'
   STOP 1
END SELECT
!
tpiba  = 2.0_DP * pi / alat
tpiba2 = tpiba**2
!
RETURN
END SUBROUTINE set_cb_parameters

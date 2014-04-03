!
! Copyright (C) 2013 A. Dal Corso 
! This file is distributed under the terms of the
! GNU General Public License. See the file `License'
! in the root directory of the present distribution,
! or http://www.gnu.org/copyleft/gpl.txt .
!
!
MODULE constants
    USE kinds, ONLY : dp
    IMPLICIT NONE
    SAVE
    PUBLIC 
    REAL(DP), PARAMETER :: pi=3.14159265358979323846_DP
    REAL(DP), PARAMETER :: aa_to_au=1.0_DP/0.52917720859_DP

    ! tab characters (horizontal and vertical respectively)
    character, parameter :: htab = char(9)
    character, parameter :: vtab = char(11)

END MODULE constants

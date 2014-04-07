!-------------------------------------------------------------------------------
!
!   Routines to calculate the Fermi energy of a given material for a certain
!   number of valence electrons per unit cell
!
!-------------------------------------------------------------------------------


function fermi_level (xmin, xmax, acc, npw, Nk) result (fl)
    use kinds
    use freemod
    implicit none
    
    ! actual variables
    real(dp) :: erg, fl
    
    ! parameters
    integer  :: npw, Nk
    
    ! where to look for the fermi level (extremes of the interval)
    real(dp) :: xmin, xmax     ! extremes within which look for the fermi level
    real(dp) :: acc            ! accuracy in determining the fermi level
    
    ! local variables
    real(dp) :: z1, z2, z
    real(dp), external :: tobezero
    integer :: i
    
    z1 = tobezero(xmin, npw, Nk)
    z2 = tobezero(xmax, npw, Nk)
    
    if ((z1 == z2) .or. (z1*z2>0)) then
        ! error message and exit program
        write (6,*) "Error : not possible to apply bisection method"
        stop 1
    endif
	
    do
        i = i+1
        fl = (xmin+xmax)/2.0_dp
        z = tobezero(fl, npw, Nk)
    
        if((z1*z)<0) then
            xmin=fl
            z2 = z
        else if((z1*z)>0) then
            xmin=fl
            z1 = z
        else
            exit
        end if
			
        if (i==200) then
            ! error message (no convergence) and exit program
            write (6,*) "Error : not possible to converge with bisection method"
            stop 1
        end if

        if (abs(xmin-xmax) < acc) then
            return
        endif
    end do
    
end function fermi_level


function tobezero (erg, npw, Nk)
    use kinds
    use freemod
    implicit none
    
    ! actual variables
    real(dp) :: erg, tobezero
    
    ! parameters
    integer  :: npw, Nk
    
    ! local variables
    integer :: ik, ibnd     ! sum indices
    real(dp) :: ekn         ! eigenvalue
    
    tobezero = 0.0_dp
    do ik=1, Nk
        !
        !   set the band structure
        !
        call set_hamiltonian(xk(:,ik), ecut, npw)
        !
        !  in this case accumulate the dos due to this band. The factor 2.0 accounts
        !  for spin
        !
        do ibnd=1, nbnd
            ekn = et(ibnd)
            if (erg > ekn) then
                tobezero = tobezero + 2.0_dp/Nk
            else if (erg == ekn) then
                tobezero = tobezero + 1.0_dp/Nk
            end if
        end do
    end do
    tobezero = tobezero - 8.0_dp
    
end function tobezero

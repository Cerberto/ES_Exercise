
function fermi_level (xmin, xmax, acc) result (fl)
    use kinds
    use constants
    use cbmod
    implicit none
    
    ! actual variables
    real(dp) :: fl
    real(dp) :: xmin, xmax     ! extremes within which look for the fermi level
    real(dp) :: acc            ! accuracy in determining the fermi level
    
    ! local variables
    real(dp) :: z1, z2, z
    real(dp), external :: tobezero
    integer :: i, nat, nval, N
    
    write(6,'("Number of atoms per unit cell")')
    read(5,*) nat
    
    write(6,'("Number of valence electrons per atom")')
    read(5,*) nval
    
    i = 0
    N = nat*nval
    
    write(6,'("Valence electrons per unit cell", i3)') N
    
    z1 = tobezero(xmin, N)
    z2 = tobezero(xmax, N)
    
    !write (6,*), htab, htab, " x_min", htab, htab, " x_max", htab, htab, "f(x_min)", htab, "f(x_max)"
    !write (6,*), "Bisection ", i, " ", htab, xmin, htab, xmax, htab, z1, htab, z2
    
    if ((z1 == z2) .or. (z1*z2>0)) then
        ! error message and exit program
        write (6,*) "Error : not possible to apply bisection method"
        stop 1
    endif
	
    do
        i = i+1
        fl = (xmin+xmax)/2.0_dp
        z = tobezero(fl, N)
    
        if((z1*z)<0) then
            xmax=fl
            z2 = z
        else if((z1*z)>0) then
            xmin=fl
            z1 = z
        else
            exit
        end if
        
        !write (6,*), htab, htab, " x_min", htab, htab, " x_max", htab, htab, "f(x_min)", htab, "f(x_max)"
        !write (6,*), "Bisection ", i, " ", htab, xmin, htab, xmax, htab, z1, htab, z2
			
        if (i==1000) then
            ! error message (no convergence) and exit program
            write (6,*) "Error : not possible to converge with bisection method"
            stop 1
        end if

        if (abs(xmin-xmax) < acc) then
            return
        endif
    end do
    
end function fermi_level


function tobezero (erg, N)
    use kinds
    use constants
    use cbmod
    implicit none
    
    ! actual variables
    real(dp) :: erg, tobezero
    integer  :: N
    
    ! local variables
    integer :: ik, ibnd     ! sum indices
    real(dp) :: ekn         ! eigenvalue
    
    tobezero = 0.0_dp
    do ik=1, nks
        
        call set_hamiltonian(xk(:,ik), ecut)
        
        call diagonalize(npw, nbnd, h, et, evc)
        
        do ibnd=1, nbnd
            ekn = et(ibnd)
            !if (erg > ekn) then
            !    tobezero = tobezero + 2.0_dp/nks
            !else if (erg == ekn) then
            !    tobezero = tobezero + 1.0_dp/nks
            !end if
            tobezero = tobezero + (erf((erg - ekn)/sqrt2/sigma) + 1.0_dp)/nks
        end do
        
        call deallocate_hamiltonian()
        
    end do
    tobezero = tobezero - 1.0_dp*N
    
end function tobezero

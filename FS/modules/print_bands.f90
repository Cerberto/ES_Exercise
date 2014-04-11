!-------------------------------------------------------------------------------
!
!   Routines to calculate the Fermi energy of a given material for a certain
!   number of valence electrons per unit cell.
!   The file contains also a routine to print the 
!
!-------------------------------------------------------------------------------


subroutine print_bands ()
    use kinds
    use fsmod, only : k_mesh, nks_x, nks_y, nbnd, nbnd_occ, npw, kx, ky, &
                        ecut, evc, h, et
    implicit none
    
    integer :: ibnd, i, j, ij
    character(len=100) :: output_filename
    integer :: output_channel
    !
    !   open output files
    !
    do ibnd=1, nbnd
        write(output_filename,200) ibnd
        200  format('outputs/band_',i1)
        output_filename = trim(output_filename)
        output_channel  = 60 + ibnd
        open (unit=output_channel, file=output_filename, &
            access='append', action='write')
    end do
    
    !----
    
    !
    !   calculate and print bands in the plane
    !
    ij=0
    do i=1, nks_x
        do j=1, nks_y
            ij = ij+1
            call set_hamiltonian(k_mesh(:,ij), ecut)
            call diagonalize(npw, nbnd, h, et, evc)
            
            !
            !   print bands for the current k-point
            !
            do ibnd=1, nbnd
                output_channel = 60 + ibnd
                write (output_channel,'(3f16.9)') kx(i)-1.0_DP, ky(j), et(ibnd)
            end do
            call deallocate_hamiltonian()
        end do
    end do
    
    !
    !   close output files
    !
    do ibnd=1, nbnd_occ
        output_channel = 60 + ibnd
        close(output_channel)
    end do

end subroutine print_bands

SUBROUTINE hpsort(n,ra,ind) 
USE kinds, ONLY : dp
    !>
    !> This routine sorts an array {\tt ra(1:n)} into ascending order using 
    !> the {\sl heapsort} algorithm. {\tt ra} is replaced on output by its 
    !> sorted rearrangement. It also creates an index table, {\tt ind}, by 
    !> making an exchange in the index array whenever an exchange is made 
    !> on the sorted data array, {\tt ra}. In case of equal values in the 
    !> input data array, {\tt ra} the values in the index array, {\tt ind} 
    !> are used to order the entries. If on input $\tt ind(1)  = 0$ then 
    !> indices are initialized in the routine; if on input 
    !> $\tt ind(1) \ne  0$, then indices are assumed to have been 
    !> initialized before entering the routine and these indices are 
    !> carried around during the sorting process.
    !>
    !> No work space is needed!
    !>
    !> Adapted from Numerical Recipes pg. 329 (new edition) and ported to 
    !> f90 on Nov 11 2002 by SB
    !>
    implicit none 
    integer, intent(in) :: n
    integer, intent(inout)    :: ind(n)    ! in-out variables  
    real(DP), intent(inout) :: ra(n)     !
  
    integer                               :: i, ir, j, l, iind ! local
    real(DP)                              :: rra                  ! variables

    if ( ind(1) == 0 ) ind(1:n) = (/ (i, i=1,n) /) ! initialize index array

    if (n < 2) return                              ! nothing to order

    ! initialize indices for hiring and retirement-promotion phase

    l  = n/2 + 1
    ir = n
    outer: do
       if (l > 1) then    ! still in hiring phase
          l    = l-1
          rra  = ra(l)
          iind = ind(l)
       else                  ! in retirement-promotion phase.
          rra     = ra(ir)   ! clear a space at the end of the array
          iind    = ind(ir)  !  
          ra(ir)  = ra(1)    ! retire the top of the heap into it
          ind(ir) = ind(1)   !
          ir      = ir -1    ! decrease the size of the corporation
          if (ir == 1) then  ! done with the last promotion
             ra(1) = rra     ! the least competent worker at all !
             ind(1)= iind    !
             exit outer
          end if
       end if
       i = l               ! wheter in hiring or promotion phase, we 
       j = l + l           ! set up to place rra in its proper level
       
       do while (j <= ir) 
          if (j < ir) then
             if (ra(j) < ra(j+1)) then ! compare to better underling
                j = j+1 
             else if (ra(j) == ra(j+1)) then
                if (ind(j) < ind(j+1)) j = j+1
             end if
          end if
          if (rra < ra(j)) then ! demote rra
             ra(i) = ra(j)
             ind(i)= ind(j)
             i = j
             j = j + j
          else if (rra == ra(j)) then
             if (iind < ind(j)) then ! demote rra
                ra(i) = ra(j)
                ind(i)= ind(j)
                i = j
                j = j + j
             else
                j = ir + 1       ! set j to terminate do-while loop
             end if
          else                   ! this is the right place for rra
             j = ir + 1          ! set j to terminate do-while loop
          end if
       end do
       ra(i) = rra
       ind(i)= iind
       
    end do outer

    return
END SUBROUTINE hpsort


function form_factor (gsq)
    use kinds
    use constants
    use cbmod, only : tpiba2
    
    real(dp) :: form_factor, gsq, x
    
    real :: A1 = 0.0765
    real :: A2 = 2.0997
    real :: A3 = 2.9779
    real :: A4 = 2.6524
    
    x = gsq*tpiba2
    form_factor = 2.0_DP*A1*(x - A2)/(exp(A3*(x - A4)) + 1.0_DP)
    
end function form_factor

set encoding iso_8859_15
set terminal postscript enhanced solid color "Helvetica" 20
set output "dos_0.0.ps"
set key off

plot '0.05.0.0' u 1:2 w l lw 2
replot '0.01.0.0' u 1:2 w l lw 2 
replot '0.005.0.0' u 1:2 w l lw 2 
replot '0.001.0.0' u 1:2 w l lw 2 

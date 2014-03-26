set encoding iso_8859_15
set terminal postscript enhanced solid color "Helvetica" 20
set output "dos_1.5.ps"
set key off

set yrange [15:16]
set arrow from 0,15.39 to 100,15.39 lw 2 nohead
plot '0.05.1.5' u 1:2 w l lw 2
replot '0.01.1.5' u 1:2 w l lw 2 
replot '0.005.1.5' u 1:2 w l lw 2 
replot '0.001.1.5' u 1:2 w l lw 2 

set encoding iso_8859_15
set terminal postscript enhanced solid color "Helvetica" 20
set output "dos_3.0.ps"
set key off

set yrange [21:22]
set arrow from 0,21.76 to 100,21.76 lw 2 nohead
plot '0.05.3.0' u 1:2 w l lw 2
replot '0.01.3.0' u 1:2 w l lw 2 
replot '0.005.3.0' u 1:2 w l lw 2 
replot '0.001.3.0' u 1:2 w l lw 2 

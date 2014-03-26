#!/usr/bin/gnuplot

set encoding iso_8859_15
set terminal postscript enhanced solid color "Helvetica" 20
set output "charge_si_111.ps"
set key off

alat=10.26
sqrt3=sqrt(3.0)
set xrange [-sqrt3*alat/8.:sqrt3*alat-sqrt3*alat/8.]
set xlabel '|r| (a.u.)'
set ylabel 'n(r) * {/Symbol W}'
set arrow from sqrt3*alat/8.,15 to sqrt3*alat/8.,13  lw 2
set label 'Si' at sqrt3*alat/8.,16.5 center
set arrow from -sqrt3*alat/8.,15 to -sqrt3*alat/8.,13  lw 2
set label 'Si' at -sqrt3*alat/8.,16.5 left
set label '[111]' at 1.2*alat,25
plot 'output' u (($1-sqrt3/8.)*alat):2 w l lw 3

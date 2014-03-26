#!/usr/bin/gnuplot
#
#  define here the size of the mesh
#
nxp=80
nyp=50
#
#  set three levels red, three levels blue, three levels green. Set them
#  equal or outside the range for the levels that you do not need
#
levr1=26
levr2=22
levr3=18

levb1=14
levb2=10
levb3=6

levg1=4
levg2=200
levg3=200
#
#  Set here the lattice constant if you want the output in a.u.
#
alat=10.66
#
#  define here the ratio between the size along y and x of the picture
#
sqrt2=sqrt(2.0)
ratiopicture=1.0/sqrt2
#
#  put here labels
#
set label "Ga" at 0.3,0.3 center
set label "As" at 0.25*alat*sqrt2,0.25*alat center
set label "As" at 0.75*alat*sqrt2,0.25*alat center
set label "Ga" at 0.5*alat*sqrt2,0.3 center
#
#  This is the name of the file that will contain the postscript file of the
#  plot
#
plot_label='charge_gaas_2d_110.ps'
#
# --------------------------------------------------------------------------
#   Do not change anything below this line
#
set view map
set size square
unset surface
unset clabel
set contour
set dgrid3d nyp,nxp
set cntrparam cubicspline
set table
#
#  Define here the countour values. Each set of countours will have the same
#  color and is written in a different file
#
set cntrparam levels discrete levr1,levr2,levr3
set output "table.dat"
splot 'output' using 1:2:3 w l 

set cntrparam levels discrete levb1,levb2,levb3
set output "table1.dat"
splot 'output' using 1:2:3 w l 

set cntrparam levels discrete levg1,levg2,levg3
set output "table2.dat"
splot 'output' using 1:2:3 w l 
#
unset table
#
#  Now define a postcript terminal called label_plot
#
set encoding iso_8859_15
set terminal postscript enhanced solid color "Helvetica" 20
set output plot_label

set size ratio ratiopicture
set key off
set border lw 3
set xrange [0:alat/ratiopicture]
set yrange [0:alat]
set xlabel "r (a.u.)"
set ylabel "r (a.u.)"
#
# Print the countour
#
plot "table.dat" u ($1*alat):($2*alat) w l lw 3 lc rgb "red", \
"table1.dat" u ($1*alat):($2*alat) w l lw 3 lc rgb "blue", \
"table2.dat" u ($1*alat):($2*alat) w l lw 3 lc rgb "green"


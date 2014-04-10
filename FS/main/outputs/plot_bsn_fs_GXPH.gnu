#!/usr/bin/gnuplot
#
#  define here the size of the mesh
#
nxp=50
nyp=50
#
#  set three levels red, three levels blue, three levels green. Set them
#  equal or outside the range for the levels that you do not need
#
levr1=0.685
levr2=200
levr3=200

levb1=0.685
levb2=200
levb3=200

levg1=0.685
levg2=200
levg3=200
#
#  Set here the lattice constant if you want the output in a.u.
#
alat=10.95
tpalat=2*pi/alat
#
#  define here the ratio between the size along y and x of the picture
#

#
#  This is the name of the file that will contain the postscript file of the
#  plot
#
plot_label='charge_bsn_2d_GXPH.eps'
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
splot 'band_1' using 1:2:3 w l 

set cntrparam levels discrete levb1,levb2,levb3
set output "table1.dat"
splot 'band_2' using 1:2:3 w l 

set cntrparam levels discrete levg1,levg2,levg3
set output "table2.dat"
splot 'band_3' using 1:2:3 w l 
#
unset table
#
#  Now define a postcript terminal called label_plot
#
set encoding iso_8859_15
set terminal postscript eps enhanced solid color "Helvetica" 20
set output plot_label

#set size ratio ratiopicture
set key off
set border lw 3
#set xrange [0:alat/ratiopicture]
#set yrange [0:alat]
#set xlabel "r (a.u.)"
#set ylabel "r (a.u.)"
#
# Print the countour
#
plot "table.dat" u ($1*alat):($2*alat) w l lw 3 lc rgb "red", \
"table1.dat" u ($1*alat):($2*alat) w l lw 3 lc rgb "blue", \
"table2.dat" u ($1*alat):($2*alat) w l lw 3 lc rgb "green"


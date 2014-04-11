#!/usr/bin/gnuplot
#
#  define here the size of the mesh
#
nxp=70
nyp=120
#
#  set three levels red, three levels blue, three levels green. Set them
#  equal or outside the range for the levels that you do not need
#
levr1=0.6756
levr2=200
levr3=200

levb1=0.6756
levb2=200
levb3=200

levg1=0.6756
levg2=200
levg3=200

levp1=0.6756
levp2=200
levp3=200

ratiopicture=1.7

#
#  This is the name of the file that will contain the postscript file of the
#  plot
#
plot_label='fs_bsn_GXH1H.eps'
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
set output "table_GLH1H.dat"
splot 'band_3' using 1:2:3 w l 

set cntrparam levels discrete levb1,levb2,levb3
set output "table1_GLH1H.dat"
splot 'band_4' using 1:2:3 w l 

set cntrparam levels discrete levg1,levg2,levg3
set output "table2_GLH1H.dat"
splot 'band_5' using 1:2:3 w l 

set cntrparam levels discrete levp1,levp2,levp3
set output "table3_GLH1H.dat"
splot 'band_6' using 1:2:3 w l 

#
unset table
#
#  Now define a postcript terminal called label_plot
#
set encoding iso_8859_15
set terminal postscript eps enhanced solid color "Helvetica" 20
set output plot_label

set size ratio ratiopicture
set key off
set border lw 3
#set xrange [0:alat/ratiopicture]
#set yrange [0:alat]
set xrange [-1.0:0]
set yrange [0:1.7]
#set xlabel "r (a.u.)"
#set ylabel "r (a.u.)"

#
# Print the countour
#
plot "table_GLH1H.dat" u 1:2 w l lw 3 lc rgb "#00A31E", \
"table1_GLH1H.dat" u 1:2 w l lw 3 lc rgb "#68A300", \
"table2_GLH1H.dat" u 1:2 w l lw 3 lc rgb "#A38400", \
"table3_GLH1H.dat" u 1:2 w l lw 3 lc rgb "#C06B09"


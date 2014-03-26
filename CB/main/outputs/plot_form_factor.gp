set encoding iso_8859_15
set terminal postscript eps enhanced color font 'Helvetica,20'
set output "form_factors.eps"
set key off

set xrange[1:11]
set grid

A1 = 0.0765
A2 = 2.0997
A3 = 2.9779
A4 = 2.6524

f(x) = A1*(x - A2)/(exp(A3*(x - A4)) + 1)

plot f(x) w l , \
	'form_factors' w p
#!/bin/bash
#
# we do a small test of convergence of the DOS 
#

for sigma in 0.05 0.01 0.005 0.001 ; do
    for nk in 8 16 32 48 64 100 ; do

cat > input.$nk.$sigma << EOF
sc
10.0
30
dos
$nk $nk $nk
0.0 3.0
3
$sigma
EOF

     ../../src/free_dos.x < input.$nk.$sigma > /dev/null
     mv output output.$nk.$sigma
     dos1=`head -1 output.$nk.$sigma | cut -c 12-`
     dos2=`head -2 output.$nk.$sigma | tail -1 | cut -c 12-`
     dos3=`tail -1 output.$nk.$sigma | cut -c 12-`

    echo $nk $dos1 >> $sigma.0.0
    echo $nk $dos2 >> $sigma.1.5
    echo $nk $dos3 >> $sigma.3.0

    done
done

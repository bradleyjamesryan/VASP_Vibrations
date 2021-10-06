#!/bin/bash

read -p 'Number of Atoms: ' natom
number=$((natom +2))

sed -n -e '/Eigenvectors after division by SQRT(mass)/,$p' OUTCAR > dummy

grep -A$number 'f  = ' dummy > dummy2
sed -i 's/X         Y         Z           dx          dy          dz/data{zz} = [/' dummy2
sed 's/.*PiTHz/]; zz = zz+1; freq(zz) = /' dummy2 > dummy3
sed 's/cm-1.*/;/' dummy3 | sed 's/--/];/' |sed '0,/ zz = zz+1;/s///' > dummy4

echo '];' >> dummy4

sed '0,/];/s// /' dummy4 > extractedForMatlab.m


rm dummy dummy2 dummy3 dummy4



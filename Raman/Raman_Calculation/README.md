################################# Step 1 #################################

Perform Relaxation

################################# Step 2 #################################

cp CONTCAR POSCAR

echo 'NWRITE = 3
ENCUT = 550
IBRION = 5
POTIM = 0.015
ICHARG = 2
ISMEAR = 0
SIGMA = 0.1
KPAR=8' > INCAR

sub driver.sh


################################# Step 3 #################################

cp CONTCAR POSCAR

mkdir PHONON

mv * PHONON/.

cp PHONON/KPOINTS .
cp PHONON/OUTCAR .
cp PHONON/POTCAR .

ln -s PHONON/OUTCAR OUTCAR.phon
ln -s PHONON/POSCAR POSCAR.phon
ln -s PHONON/POTCAR POTCAR.phon

echo 'ISTART = 0
LEPSILON = .TRUE.

NWRITE = 3
ENCUT = 550
IBRION = 5
POTIM =1
ICHARG = 2
ISIF = 3
ISMEAR = 0
NELM = 200
NSW = 2000
SIGMA = 0.1
KPAR=8' > INCAR

cp ~/Templates/raman_driver.sh .

sub raman_driver.sh


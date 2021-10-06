## This is a work in progress. I will remove this line when it is fully published.
https://github.com/raman-sc/VASP


1. Run a relaxation calculation. See provided example in "Step1_Relax".
2. After the relaxation has completed, copy the Step1_Relax folder to a new folder (Step2_FiniteDiff), copy CONTCAR to POSCAR, and run a finite difference calculation. See provided example in "Step2_FiniteDiff".
3. After the finite difference calculation has completed, copy the Step2_FiniteDiff folder to a new folder (Step3_Raman), navigate to the Step3_Raman folder, issue the following commands:

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
4) Run the vasp_raman.py script


4. Navigate to your vibrational calculation folder (e.g., Step2_Relax), and run intensities.sh
	1. A new folder will be made called "intensities". In this folder will be your FTIR data.
5. To generate GIF files of each vibrational mode, see the "GIF_Generation" folder in this repository.

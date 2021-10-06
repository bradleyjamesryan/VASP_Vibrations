## This is a work in progress. I will remove this line when it is fully published.

1. Download the vasp_raman code from the following URL: https://github.com/raman-sc/VASP/. In this repository, there are instructions on how to setup your global variables in your Linux environment. You must follow these instructions, otherwise the vasp_raman.py script will not work. One of these global variables will be system dependent, and as such, I cannot give an accurate description of how to set this up.
2. Run a relaxation calculation. See provided example in "Step1_Relax".
3. After the relaxation has completed, copy the "Step1_Relax" folder to a new folder (Step2_FiniteDiff), copy CONTCAR to POSCAR, and run a finite difference calculation. See provided example in "Step2_FiniteDiff".
3. After the finite difference calculation has completed, copy the "Step2_FiniteDiff" folder to a new folder (Step3_Raman), navigate to the Step3_Raman folder, issue the commands below, and then run the vasp_raman.py script. See provided example in "Step3_Raman".

     cp CONTCAR POSCAR  
     mkdir PHONON  
     mv * PHONON/. <br />
     cp PHONON/KPOINTS . <br />
     cp PHONON/OUTCAR . <br />
     cp PHONON/POTCAR .  <br />
     ln -s PHONON/OUTCAR OUTCAR.phon  <br />
     ln -s PHONON/POSCAR POSCAR.phon  <br />
     ln -s PHONON/POTCAR POTCAR.phon  <br />
     echo 'ISTART = 0  <br />
     LEPSILON = .TRUE.  <br />
     NWRITE = 3  <br />
     ENCUT = 550  <br />
     IBRION = 5  <br />
     POTIM =1  <br />
     ICHARG = 2  <br />
     ISIF = 3  <br />
     ISMEAR = 0  <br />
     NELM = 200  <br />
     NSW = 2000  <br />
     SIGMA = 0.1  <br />
     KPAR=8' > INCAR  <br />

5. To generate GIF files of each vibrational mode, see the "GIF_Generation" folder in this repository.

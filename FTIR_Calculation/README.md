1. Run a relaxation calculation. See provided example in "Step1_Relax".
2. Copy relaxation folder to a new folder, copy CONTCAR to POSCAR, and run a vibrational calculation. See provided example in "Step2_FTIR".
3. Download intensities.sh if you havent already from https://github.com/dakarhanek/VASP-infrared-intensities.
4. Navigate to your vibrational calcualtion folder (e.g., Step2_Relax), and run intensities.sh
	1. A new folder will be made called "intensities". In this folder will be your FTIR data.
5. To generate GIF files of each vibrational mode, see the "GIF_Generation" folder in this repository.

## This is a work in progress. I will remove this line when it is fully published.
## Prerequisites
1. Software needed:
    1. Matlab
    2. Linux OS for running bash (.sh) scripts
    3. gifsicle
2. Files needed:
    1. OUTCAR
    2. CONTCAR
    3) Intensities 
	i)  For FTIR: /intensities/results/results.txt
	ii) For Raman: vasp_raman.dat
	

## Instructions
0. Perform the appropriate calculations to obtain vibrational data. See either VASP_Vibrations/FTIR_Calculation or VASP_Vibrations/Raman_Calculation for examples.

1. Extract vibrational modes from OUTCAR (located in Step2_FTIR) or OUTCAR.phon (located in Step3_Raman) with the Step1_ExtractModes_FromOUTCAR.sh script
    1. Determine total number of atoms in the CONTCAR file.
    2. Navigate to where the location of the OUTCAR (Step2_FTIR) or OUTCAR.phon (Step3_Raman) file.
    3. Run Step1_ExtractModes_FromOUTCAR.sh, then enter the total number of atoms in the CONTCAR file from step 1i.
       - This will create a "extractedForMatlab.m" file in the directory from which you ran "Step1_ExtractModes_FromOUTCAR.sh"

2. Generate images with Matlab
    1. Open the "Step2_CreateImagesForGIF.m" file in matlab and change the CONTCARPATH at top of the script to the appropriate paths (i.e., Step2_FTIR or Step3_Raman).
    2. Run MATLAB code (Step2_CreateImagesForGIF.m).

3. Generate GIFs
    1. Navigate to the new folder Matlab made "GIFImages"
    2. Run the "Step3_CreateGIFs.sh" script.





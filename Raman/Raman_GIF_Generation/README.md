## This is a work in progress. I will remove this line when it is fully published.
## Prerequisites
1. Software needed:
    1. Matlab
    2. Linux OS for running bash (.sh) scripts
    3. gifsicle
2. Files needed:
    1. OUTCAR
    2. CONTCAR
    3. /intensities/results/results.txt
   

## Instructions
0. Perform the three steps outline in _____
1. 
2. Extract vibrational modes from OUTCAR.phon with the 01_ExtractFTIRModes_FromOUTCAR.sh script
    1. Determine total number of atoms in the CONTCAR file.
    2. Navigate to where the location of the OUTCAR (FTIR) or OUTCAR.phon (Raman) file.
    3. Run 01_ExtractFTIRModes_FromOUTCAR.sh, then enter the total number of atoms in the CONTCAR file from step 1i.
       - This will create a "extractedForMatlab.m" file in the directory from which you ran "01_ExtractFTIRModes_FromOUTCAR.sh"

2. Generate images with Matlab
    1. Open the "CreateImagesForGIF_FTIR_Raman.m" file in matlab and change the CONTCARPATH at top of the script to the appropriate paths.
    2. Run MATLAB code (CreateImagesForGIF_FTIR_Raman.m).

3. Generate GIFs
    1. Navigate to the new folder Matlab made "GIFImages"
    2. Run the "03_CreateGIFs.sh" script.


   



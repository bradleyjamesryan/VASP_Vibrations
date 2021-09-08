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
1. Extract vibrational modes from OUTCAR with the ExtractFTIRModes_FromOUTCAR.sh script
    1. Determine total number of atoms in the CONTCAR file.
    2. Navigate to where the location of the  OUTCAR file.
    3. Run ExtractFTIRModes_FromOUTCAR.sh, then enter the total number of atoms in the CONTCAR file from step 1i.
    4. This will create "extractedForMatlab" file in the directory from which you ran "ExtractFTIRModes_FromOUTCAR.sh"


2. Generate images with Matlab
    1. Open the "CreateImagesForGIF_FTIR_Raman.m" file in matlab and change the top of the script to the appropriate paths.
       - This will make a new .m file called "extractedForMatlab.m" in the directory defined in step 2i.
    2. Run MATLAB code (CreateImagesForGIF_FTIR_Raman.m).


3. Generate GIFs
    1. Navigate to the new folder Matlab made "GIFImages"
    2. Run the "CreateGIFs.sh" script.


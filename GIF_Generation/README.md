## Prerequisites
1. Software needed:
    1. Matlab
    2. Linux OS for running bash (.sh) scripts
    3. gifsicle
2. Files needed
    1. OUTCAR
    2. CONTCAR
    3. /intensities/results/results.txt
   
   
## Instructions
1. Extract vibrational modes from OUTCAR with the ExtractFTIRModes_V2.sh script
    1. Determine total number of atoms in CONTCAR
    2. Navigate to where your OUTCAR file is
    3. Run ExtractFTIRModes_FromOUTCAR.sh, then enter the total number of atoms in CONTCAR from step 2a
    4. This will create "extractedForMatlab" file in the directory from which you ran 

2. Generate images with Matlab
    1. Open the "extractedForMatlab" file from step 1
    1. Copy and paste the contents of this document into "plotImagesForGIF_FTIR_Raman_V3.m" after line 8
    1. Change the top of the script to the appropriate paths
    1. Run MATLAB code

3. Generate GIFs
    1. Navigate to the new folder Matlab made "GIFImages"
    1. Run the "CreateGIFs.sh" script.


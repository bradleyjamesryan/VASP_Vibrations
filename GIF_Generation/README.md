Prerequisites
Software needed:
    a) Matlab
    b) Linux OS for running bash (.sh) scripts
    c) gifsicle

Files needed:
    a) OUTCAR
    b) CONTCAR
    c) /intensities/results/results.txt

1) Extraction vibrational modes from OUTCAR with the ExtractFTIRModes_V2.sh script 
2) - test
3)  
a) Determine total number of atoms in CONTCAR
b) Navigate to where your OUTCAR file is
c) Run ExtractFTIRModes_V2.sh, then enter the total number of atoms in CONTCAR from step 2a
a) This will create "extractedForMatlab" file in the directory from which you ran 

2) Generate images with Matlab
    a) Open the "extractedForMatlab" file from step 1
    b) Copy and paste the contents of this document into "plotImagesForGIF_FTIR_Raman_V3.m" after line 8
    c) Change the top of the script to the appropriate paths
    d) Run MATLAB code

3) Generate GIFs
    a) Navigate to the new folder Matlab made "GIFImages"
    b) Run the "CreateGIFs.sh" script.
    
    
    
1. A numbered list
              1. A nested numbered list
              2. Which is numbered
          2. Which is numbered

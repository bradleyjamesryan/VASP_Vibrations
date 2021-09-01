
1. Software needed:
    1. Matlab
    2. Linux OS for running bash (.sh) scripts
    3. gifsicle
2. Files needed
    1. Matlab
3. test
5. Test
    1. test 23
~~~



Files needed:
- OUTCAR
- CONTCAR
- /intensities/results/results.txt

1) Extraction vibrational modes from OUTCAR with the ExtractFTIRModes_V2.sh script
- Determine total number of atoms in CONTCAR
- Navigate to where your OUTCAR file is
- Run ExtractFTIRModes_V2.sh, then enter the total number of atoms in CONTCAR from step 2a
- This will create "extractedForMatlab" file in the directory from which you ran 

2) Generate images with Matlab
- Open the "extractedForMatlab" file from step 1
- Copy and paste the contents of this document into "plotImagesForGIF_FTIR_Raman_V3.m" after line 8
- Change the top of the script to the appropriate paths
- Run MATLAB code

3) Generate GIFs
- Navigate to the new folder Matlab made "GIFImages"
- Run the "CreateGIFs.sh" script.


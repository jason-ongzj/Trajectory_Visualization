# ASTOS Pre- and Postprocessing
The workflows outlined involve Bash and Python scripting. An installation of WSL (on Windows) with the following Python libraries are required:
- Numpy
- Scipy
- Matplotlib

## Preprocessing
Navigate to the Pre/ folder to get the batch file for Monte-Carlo simulations started. Run the following commands:
> ./Monte_Carlo_Input.sh <FILENAME> <No. of Iterations>

Example:
> ./Monte_Carlo_Input.sh Monte_Carlo_Variables.txt 600

You should see a Monte_Carlo_Input_600.gabc file appear. The output file depends on how many parameters there are within the input file provided by you. An example input file (Monte_Carlo_Variables.txt) is provided for your reference.

## Postprocessing
Trajectory postprocessing workflow requires the following 2 items:
1. Nominal trajectory in "LAT,LONG,ALT" form written into Nominal_Trajectory.csv
2. Dispersion point data in "LONG LAT <etc>" form from the ASTOS Monte-Carlo simulation written into MC_Results.txt

Nominal_Trajectory.csv file is placed in Postprocessing/Input, while MC_Results.txt is placed in Postprocessing/Input/Monte Carlo/ folder.

Run ./Nominal_Output.sh to generate output data. The output is given in the form of .kml data. PNG file for confidence ellipses are generated as well for validation.

<p align="middle">
  <img src="Post/KML_Visualization.jpg" width="450">
  <img src="Post/Postprocessing/Data/Ellipse_MC.png" width="300"> 
</p>

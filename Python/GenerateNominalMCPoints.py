import numpy as np
import sys

dispersion_file = "Monte Carlo/MC_Results_Copy.txt"

lat_dispersion_data = np.loadtxt(dispersion_file, usecols=[1], skiprows=2)
long_dispersion_data = np.loadtxt(dispersion_file, usecols=[0], skiprows=2)

new_dispersion_file = "Nominal_Dispersions.txt"
new_dispersion_file_obj = open(new_dispersion_file, "w+")
new_dispersion_file_obj.write("Long Lat Alt\n\n")
for i in range(0, len(lat_dispersion_data)):
	new_dispersion_file_obj.write(str(long_dispersion_data[i]) + " " + str(lat_dispersion_data[i]) + " 0\n")

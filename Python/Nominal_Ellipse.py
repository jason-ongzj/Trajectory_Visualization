import numpy as np
import sys
import matplotlib.pyplot as plt
from EllipseGeneration import generateEllipseData

summary = str(sys.argv[1])
annotation = str(sys.argv[2])
lat_data = np.loadtxt(summary, usecols=[1], skiprows=2)
long_data = np.loadtxt(summary, usecols=[0], skiprows=2)

lat_nom = 0
long_nom = 0
file='Postprocessing/Input/Nominal_Trajectory.csv'
with open(file) as f:
    for line in f:
        pass
    lat_nom = float(line.split(',')[0])
    long_nom = float(line.split(',')[1])

mean_vector = np.array([long_nom, lat_nom])
generateEllipseData(mean_vector, lat_data, long_data, annotation)

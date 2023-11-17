import numpy as np
import matplotlib.pyplot as plt
from BivarNormDistFunctions import confidenceEllipse, writeEllipseToFile

def generateEllipseData(mean_vector, lat_data, long_data, annotation):
    fi, ax_nstd = plt.subplots(figsize=(8, 7))
    plt.scatter(long_data, lat_data, s=1, color='black', label='Dispersion Point')
    plt.grid(b=True)

    ellipse_png_file = 'Ellipse_' + annotation

    confidenceEllipse(mean_vector, long_data, lat_data, ax_nstd, 1,
                       label=r'$1\sigma$ Ellipse', edgecolor='firebrick')
    confidenceEllipse(mean_vector, long_data, lat_data, ax_nstd, 2,
                       label=r'$2\sigma$ Ellipse', edgecolor='fuchsia', linestyle='--')
    confidenceEllipse(mean_vector, long_data, lat_data, ax_nstd, 3,
                       label=r'$3\sigma$ Ellipse', edgecolor='darkorange', linestyle='-')

    writeEllipseToFile(mean_vector, long_data, lat_data, 1, annotation)
    writeEllipseToFile(mean_vector, long_data, lat_data, 2, annotation)
    writeEllipseToFile(mean_vector, long_data, lat_data, 3, annotation)

    plt.scatter(np.array([mean_vector[0]]), np.array([mean_vector[1]]), s=40, \
        color='red', label='Nominal Point')
    plt.xlabel('Longitude (\N{DEGREE SIGN})')
    plt.ylabel('Latitude (\N{DEGREE SIGN})')
    plt.legend()
    plt.savefig(ellipse_png_file)

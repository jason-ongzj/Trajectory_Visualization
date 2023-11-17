# Calculate variance from mean point by taking the sum of the squares of the differences
# between the mean vector and each point, then divide by the number of points.

# Calculate the PDF using the formula from this web:
# https://docs.scipy.org/doc/scipy/reference/generated/scipy.stats.multivariate_normal.html

# Calculating confidence ellipses: https://matplotlib.org/stable/gallery/statistics/confidence_ellipse.html

import numpy as np
from math import pi, cos, sin, atan, sqrt
import sys
import matplotlib.pyplot as plt
from matplotlib.patches import Ellipse
from scipy.stats import multivariate_normal
from numpy import linalg as LA
import matplotlib.transforms as transforms

def confidenceEllipse(mean_vector, x, y, ax, n_std, facecolor='none', **kwargs):
    if x.size != y.size:
        raise ValueError("x and y must be the same size")

    cov = np.cov(x, y)
    pearson = cov[0, 1]/np.sqrt(cov[0, 0] * cov[1, 1])
    eigenval, eigenvec = LA.eig(cov)

    ell_radius_x = np.sqrt(1 + pearson)
    ell_radius_y = np.sqrt(1 - pearson)
    ellipse = Ellipse((0, 0), width=ell_radius_x * 2, height=ell_radius_y * 2,
                      facecolor=facecolor, **kwargs)

    # Calculating the stdandard deviation of x from
    # the squareroot of the variance and multiplying
    # with the given number of standard deviations.
    scale_x = np.sqrt(cov[0, 0]) * n_std

    # calculating the stdandard deviation of y ...
    scale_y = np.sqrt(cov[1, 1]) * n_std
    print(str(n_std) + "-sigma deviations -- ", "Sigma_x: ", scale_x, ", Sigma_y: ", scale_y)
    # Rotate 45 degrees since values have been normalized
    transf = transforms.Affine2D() \
        .rotate_deg(45) \
        .scale(scale_x, scale_y) \
        .translate(mean_vector[0], mean_vector[1])

    ellipse.set_transform(transf + ax.transData)

    return ax.add_patch(ellipse)

def writeEllipseToFile(mean, x, y, n_std, annotation):
    cov = np.cov(x, y)
    sigma_x = np.sqrt(cov[0, 0])
    sigma_y = np.sqrt(cov[1, 1])

    p= cov[0, 1]/np.sqrt(cov[0, 0] * cov[1, 1])
    eigenval, eigenvec = LA.eig(cov)

    t = np.linspace(0, 2*pi, 1000)

    lambda1 = 1 + p
    lambda2 = 1 - p

    theta = pi/4

    scale_x = n_std * sigma_x
    scale_y = n_std * sigma_y

    x = np.zeros(len(t))
    y = np.zeros(len(t))
    for i in range(len(x)):
        x[i] = sqrt(lambda1)*cos(theta)*cos(t[i]) - sqrt(lambda2)*sin(theta)*sin(t[i])
        y[i] = sqrt(lambda1)*sin(theta)*cos(t[i]) + sqrt(lambda2)*cos(theta)*sin(t[i])

    plt.plot(x*scale_x + mean[0], y*scale_y + mean[1], 'orange')

    output_file = "Ellipse_" + str(n_std) + "Sigma_" + annotation + ".txt"
    file_object = open(output_file, "w+")
    file_object.write("Lat Long Alt\n")

    for i in range(len(x)):
        file_object.write(str(y[i]*scale_y + mean[1]) + "," +  str(x[i]*scale_x + mean[0]) + ",0\n")

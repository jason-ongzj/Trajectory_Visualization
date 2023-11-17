#!/bin/bash
source Bash/KML_Functions.sh

./ClearData.sh

cd Postprocessing/Input/Monte\ Carlo/
[ -f MC_Results_Copy.txt ] && rm MC_Results_Copy.txt
cp -r MC_Results.txt MC_Results_Copy.txt

echo ""
cd ..
[ -f Nominal_Dispersions.txt ] && rm Nominal_Dispersions.txt
python3 ../../Python/GenerateNominalMCPoints.py

cd ../..

python3 Python/Nominal_Ellipse.py Postprocessing/Input/Nominal_Dispersions.txt MC
mv *_MC.txt Postprocessing/Data
mv Ellipse_MC.png Postprocessing/Data
echo ""

cd Postprocessing/Output
[ -f Nominal_Trajectory.kml ] && rm Nominal_Trajectory.kml
[ -f Nominal_Dispersion.kml ] && rm Nominal_Dispersion.kml

echo "Writing KML file for nominal trajectory and Monte-Carlo ellipses..."
# Build trajectory kml file including dispersion ellipses
KML_Opening Nominal_Trajectory.kml

# For KML color ordering, 8-digit hex code goes from aabbggrr (alpha-blue-green-red)
# White
KML_LinestringStyle Nominal_Trajectory.kml 5 ffffffff
KML_Linestring ../Input/Nominal_Trajectory.csv Nominal_Trajectory.kml Nominal_Trajectory

# Blue
KML_LinestringStyle Nominal_Trajectory.kml 5 ffff5500
KML_Linestring ../Data/Ellipse_1Sigma_MC.txt Nominal_Trajectory.kml Ellipse_1Sigma

# Turqoise
KML_LinestringStyle Nominal_Trajectory.kml 5 ffd9a201
KML_Linestring ../Data/Ellipse_2Sigma_MC.txt Nominal_Trajectory.kml Ellipse_2Sigma

# Light Blue
KML_LinestringStyle Nominal_Trajectory.kml 5 fffcd355
KML_Linestring ../Data/Ellipse_3Sigma_MC.txt Nominal_Trajectory.kml Ellipse_3Sigma
KML_Closing Nominal_Trajectory.kml
echo "Done."
echo ""

echo "Writing KML file for Monte-Carlo dispersion points..."
# Build kml file for Monte Carlo dispersion points
KML_Opening Nominal_Dispersion.kml
KML_Points ../Input/Nominal_Dispersions.txt Nominal_Dispersion.kml 0.3 ylw
KML_Closing Nominal_Dispersion.kml
echo "Done."

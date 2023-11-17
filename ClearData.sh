#!/bin/bash

if [ -z "$(ls -A Postprocessing/Data)" ]; then
	echo "Ellipse data folder is empty."
else
	echo "Not empty, clearing ellipse data folder."
	rm Postprocessing/Data/*
fi

if [ -z "$(ls -A Postprocessing/Output)" ]; then
	echo "KML output folder is empty."
else
	echo "Not empty, clearing KML output folder."
	rm Postprocessing/Output/*.kml
fi
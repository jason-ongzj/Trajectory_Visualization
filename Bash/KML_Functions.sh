#!/bin/bash

# Run e.g.: KMLOpening OutputFile.kml
KML_Opening() {
    echo -e "\
<?xml version='"'1.0'"' encoding='"'UTF-8'"'?>\n\
<kml xmlns='"'http://www.opengis.net/kml/2.2'"'>\n\
<Document>" >> $1
}

# Run e.g. KMLClosing OutputFile.kml
KML_Closing() {
    echo -e "\
</Document>\n\
</kml>\n\
" >> $1
}

# 1st input - File output
# 2nd input - Scale
# 3rd input - Color 
# Run e.g. KML_LinestringStyle OutputFile.kml 5
KML_LinestringStyle() {
    echo -e "\
    <Style id='"'line'"'>\n\
        <LineStyle>\n\
            <width>"$2"</width>\n\
            <color>"$3"</color>\n\
        </LineStyle>\n\
    </Style>\n\
    <StyleMap id='"'linestring_stylemap'"'>\n\
        <Pair>\n\
            <key>normal</key>\n\
            <styleUrl>#line</styleUrl>\n\
        </Pair>\n\
    </StyleMap>" >> $1
}

# 1st input - file output
# 2nd input - scale
# 3rd input - color
KML_PointsStyle() {
    echo -e "\
    <StyleMap id='m_$3-pushpin'>
        <Pair>
            <key>normal</key>
            <styleUrl>#s_$3-pushpin</styleUrl>
        </Pair>
    </StyleMap>
    <Style id='s_$3-pushpin'>
        <IconStyle>
            <scale>$2</scale>
            <Icon>
            	  <href>http://maps.google.com/mapfiles/kml/pushpin/$3-pushpin.png</href>
            </Icon>
            <hotSpot x='20' y='2' xunits='pixels' yunits='pixels'/>
        </IconStyle>
    </Style>" >> $1
}

# 1st input - file input
# 2nd input - file output
# 3rd input - scale
# 4th input - color (Red - "red", Green - "grn", Yellow - "ylw", Blue - "blue")
# Run e.g.: KML_Linestring Filename.txt OutputFile.kml Ellipse_1-Sigma
## File input must have LONG,LAT,ALT sequence
KML_Points() {
    KML_PointsStyle $2 $3 $4

    # Remove 1st and 2nd lines from points file
    sed '1,2d' $1 > IntermediateFile.txt
    while read -r f1 f2 f3 f4
    do
      echo -e "\
    <Placemark>\n\
        <styleUrl>#m_$4-pushpin</styleUrl>\n\
        <Point>\n\
            <coordinates>"$f1","$f2",0</coordinates>\n\
        </Point>\n\
    </Placemark>" >> $2
    done < IntermediateFile.txt
    rm IntermediateFile.txt
}

# Alternate (LAT LONG ALT sequence)
KML_Points_Alt() {
    KML_PointsStyle $2 $3 $4

    # Remove 1st and 2nd lines from points file
    sed '1,2d' $1 > IntermediateFile.txt
    while read -r f1 f2 f3 f4
    do
      echo -e "\
    <Placemark>\n\
        <styleUrl>#m_$4-pushpin</styleUrl>\n\
        <Point>\n\
            <coordinates>"$f2","$f1",0</coordinates>\n\
        </Point>\n\
    </Placemark>" >> $2
    done < IntermediateFile.txt
    rm IntermediateFile.txt
}

# 1st input - file input
# 2nd input - file output
# 3rd input - feature name
# Run e.g.: KML_Linestring Filename.txt OutputFile.kml Ellipse_1-Sigma
## File input must have LAT,LONG,ALT sequence
KML_Linestring() {
    echo -e "\
    <Placemark>\n\
        <name>"$3"</name>\n\
        <styleUrl>#linestring_stylemap</styleUrl>\n\
        <LineString>\n\
            <extrude>0</extrude>\n\
            <tessellate>0</tessellate>\n\
            <altitudeMode>relativeToGround</altitudeMode>\n\
            <coordinates>\
    " >> $2

    awk -F "," '{ getline; print "                " $2 "," $1 "," $3*1000}' $1 >> $2
    echo -e "\
            </coordinates>\n\
        </LineString>\n\
    </Placemark>" >> $2
}

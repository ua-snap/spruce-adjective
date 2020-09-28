#!/bin/bash -l
#Needs to be run with conda activate python36_geo for gdal
# 2020/07 Chris Waigl cwaigl@alaska.edu

set -x

TODAY=`date -j +%Y%m%d`

cd $TARGETDIR_JOIN
rm spruceadj_latest.*
echo "Merging CA data"
ogr2ogr spruceadj_latest.shp -update -append ../../${TARGETDIR_CA}/spruceadj_latestCA.shp
echo "Merging AK data"
ogr2ogr spruceadj_latest.shp -update -append ../../${TARGETDIR_AK}/spruceadj_latestAK.shp
zip spruceadj_latest.zip spruceadj_latest.*

cd ../..
cp $TARGETDIR_JOIN/spruceadj_latest.zip ${DEPLOYSUB}/spruceadj_latest${TODAY}.zip
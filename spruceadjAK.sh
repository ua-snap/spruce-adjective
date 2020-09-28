#!/bin/bash -l
#Needs to be run with conda activate python36_geo for gdal
# 2020/07 Chris Waigl cwaigl@alaska.edu

TODAY=`date -j +%Y%m%d`
YEAR=${TODAY:0:4}
MONTH=${TODAY:4:2}
DAY=${TODAY:6:2}
GISLAYER=spruce_${TODAY}

cd $TARGETDIR_AK
echo "*** Working in ${TARGETDIR_AK}"
wget -nc ${URLBASE_AK}${TODAY}_spruce.tiff
if [[ $? -eq 8 ]]; then
    {echo "wget could not retrieve remote file ${URLBASE_AK}${TODAY}_spruce.tiff"; exit 1}
fi

gdalwarp -t_srs EPSG:3338 ${TODAY}_spruce.tiff ${GISLAYER}_AKAlbers.tiff
gdal_polygonize.py ${GISLAYER}_AKAlbers.tiff  -8 -b 1 -f "ESRI Shapefile" $GISLAYER.shp $GISLAYER firedanger
ogrinfo $GISLAYER.shp -sql "ALTER TABLE $GISLAYER ADD COLUMN chardate character(10)"
ogrinfo $GISLAYER.shp -dialect SQLite -sql "UPDATE $GISLAYER SET chardate = '${YEAR}-${MONTH}-${DAY}'"
ogr2ogr spruceadj_latestAK.shp $GISLAYER.shp

# mv ${GISLAYER}_AKAlbers.tiff ${TODAY}_spruce.tiff ${GTARCHIVESUB}/
# mv ${GISLAYER}.* ${SHPARCHIVESUB}/
cd ..

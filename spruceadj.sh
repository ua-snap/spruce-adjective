#!/bin/bash -l
#Needs to be run with conda activate python36_geo for gdal
# 2020/06 Chris Waigl cwaigl@alaska.edu

set -x
rm -rf ./scratch

mkdir -p ./scratch/canada
export TARGETDIR_CA=./scratch/canada

mkdir -p ./scratch/alaska
export TARGETDIR_AK=./scratch/alaska

mkdir -p ./scratch/merged
export TARGETDIR_JOIN=./scratch/merged

mkdir -p ./output
export DEPLOYSUB=./output

export URLBASE_CA="https://cwfis.cfs.nrcan.gc.ca/downloads/fire_danger/"

export URLBASE_AK="https://akff.mesowest.org/static/grids/tiff/"

bash ./spruceadjAK.sh
bash ./spruceadjCA.sh
bash ./spruceadjmerge.sh
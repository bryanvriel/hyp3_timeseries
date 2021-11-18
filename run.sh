#!/bin/bash

set -e
set -x

SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"
source ${SCRIPT_DIR}/configs

if [ ! -f "${DOCKER_SHAPEFILE_PATH}" ]; then
    SHAPEFILE_PATH="${SCRIPT_DIR}/shapefiles/test.shp"
else
    SHAPEFILE_PATH="$DOCKER_SHAPEFILE_PATH"
fi

${SCRIPT_DIR}/retrieve_data.py --shapefile ${SHAPEFILE_PATH} --start ${START_DATE} --end ${END_DATE} --relativeorbit ${RELATIVE_ORBIT}
${SCRIPT_DIR}/move.py
${SCRIPT_DIR}/project_and_crop.sh
${SCRIPT_DIR}/mean_and_match.py
${SCRIPT_DIR}/generate_timelapse.py

#rm -rf /products/matched
#rm -rf /products/timelapse
#rm -rf /products/corrected
#rm -rf /products/warped

echo "finished!"

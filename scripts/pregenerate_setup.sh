#!/bin/bash

# This is the folder where we copy the code
CODE_VERSION="/var/www/codeversion"

# We keep a history of the releases on this folder
RELEASE_DIR="/var/www/code_release"

# Project folder name
PROJECT_FOLDER="/var/www/html"

# See this for a list of possible values:
# https://en.wikipedia.org/wiki/List_of_tz_database_time_zones
#TIMEZONE=America/New_York
TIMEZONE="UTC"

#######################################
###### NOT EDIT BEYOND THIS LINE ######
#######################################

# Exporting paths
export PATH=$PATH:/bin:/usr/bin:/usr/local/bin

# Get THIS_RELEASE folder name
THIS_RELEASE=$(TZ=$TIMEZONE date +%Y%m%d%H%M%S)

# Create release folder name
mkdir -p "${RELEASE_DIR}/${THIS_RELEASE}"

# Copying Version
rsync -av ${CODE_VERSION}/  ${RELEASE_DIR}/${THIS_RELEASE}

# Get Latest version
VERSION=$(ls ${RELEASE_DIR}/ | tail -n 1)

# Generate REVISION
echo ${DEPLOYMENT_ID} > ${RELEASE_DIR}/${VERSION}/REVISION

# Generate Symlink to latest version
rm -rf ${PROJECT_FOLDER}; ln -s ${RELEASE_DIR}/${VERSION} ${PROJECT_FOLDER}


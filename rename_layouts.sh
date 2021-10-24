#!/bin/bash

# utils
normal=`tput sgr0`
green=`tput setaf 2`
function success() {
  echo -e "${green}$1${normal}"
}

# get argument
pptx=$1
if [ "$pptx" = "" ];
then
	echo "Usage: $1 <pptx file>"
	exit 1
fi

# variable
WORK_FOLDER=.tmp_pptx
TARGET_FILE=${pptx/.ppt/ NEW.ppt}

# clean up and unzip
success "Cleaning up working folder"
success "Extracting contents from PPTX files"
rm -rf ${WORK_FOLDER} 2> /dev/null
unzip -qq -o "${pptx}" -d ${WORK_FOLDER}

# rename
success "Updating layouts"
./update_layouts.sh ${WORK_FOLDER}

# now zip it
success "Rebuilding PPTX"
rm "${TARGET_FILE}" 2> /dev/null
cd ${WORK_FOLDER}
zip -qq -r "../${TARGET_FILE}" *
cd - > /dev/null

# cleanup
success "Finishing"
rm -rf ${WORK_FOLDER} 2> /dev/null

# open file
success "Done!"
open "${TARGET_FILE}"

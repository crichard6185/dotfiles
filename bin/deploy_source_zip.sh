#!/bin/bash

repo_names_array=( ca_server encryptor_api files_api im_ios_sdk im_server ios_secure_assets keystore_api upload_server analytics_api file_processor deadbolt chef_knife )

if [ "$#" -ne 2 ]; then
    echo "Usage: deploy_source {git branch, tag, or SHA to deploy} {output zip file}"
    exit 1
fi
DEPLOY_BRANCH=$1
OUTPUT_FILE=$2
TEMP_DIR=temp_$(date +%F%T)

echo
echo "This script shallow clones the following repos:"
for repo_name in "${repo_names_array[@]}"
do
  echo -e https://gitlab.asynchrony.com/proj-1016/${repo_name}.git " \t\t " revision: ${DEPLOY_BRANCH}
done
echo This may take some time...
read -p "Press [Enter] key to continue"
echo

mkdir ${TEMP_DIR}
cd ${TEMP_DIR}

# and now loop through the repo names:
for repo_name in "${repo_names_array[@]}"
do
  git clone https://gitlab.asynchrony.com/proj-1016/${repo_name}.git --depth 1 -b ${DEPLOY_BRANCH}
  cd ${repo_name}
  git submodule update --init --recursive
  cd ..
  rm -f ${repo_name}/.git/shallow
done

echo
echo Source shallow cloned.  Zipping output...
echo
zip -r ../${OUTPUT_FILE} .
echo
echo Zip file created.  Cleaning up...
cd ..
rm -rf ${TEMP_DIR}
echo Done!
echo


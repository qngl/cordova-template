#!/bin/bash

set -ex

CUR_DIR=`pwd`

# Add node_module binaries to path, e.g. cordova
export PATH="$CUR_DIR/../../node_modules/.bin:$PATH"

. $CUR_DIR/../build.shared.sh

BUILD_CMD="cordova build browser --verbose $RELEASE_MODE"

cordova prepare browser --verbose
cordova clean browser --verbose
$BUILD_CMD

if [[ $APP == "dealer" ]]; then
  cp -R $CUR_DIR/platforms/browser/www/* $CUR_DIR/../../dist/dealer/
else
  cp -R $CUR_DIR/platforms/browser/www/* $CUR_DIR/../../dist/
fi
echo $APP $CLASSIFIER

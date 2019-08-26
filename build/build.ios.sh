#!/bin/bash

set -ex

CUR_DIR=`pwd`

# Add node_module binaries to path, e.g. cordova
export PATH="$CUR_DIR/../../node_modules/.bin:$PATH"

. $CUR_DIR/../build.shared.sh

BUILD_CMD="cordova build ios --verbose $VERSION_MODE $RELEASE_MODE --buildConfig=../$APP/buildConfig.json --buildFlag=-UseModernBuildSystem=0"

rm -rf $CUR_DIR/platforms/ios/build
cordova prepare ios --verbose
cordova clean ios --verbose
$BUILD_CMD

cp $CUR_DIR/platforms/ios/build/device/*.ipa $CUR_DIR/../../build/$APP.ipa
echo $APP $CLASSIFIER

#!/bin/bash

set -ex

CUR_DIR=`pwd`

# Add node_module binaries to path, e.g. cordova
export PATH="$CUR_DIR/../../node_modules/.bin:$PATH"

. $CUR_DIR/../build.shared.sh

BUILD_CMD="cordova build android --verbose $RELEASE_MODE -- --keystore=../sign/xxx.jks --storePassword=xxxx --alias=xxxx --password=xxxx"

cordova prepare android --verbose
cordova clean android --verbose
$BUILD_CMD


if [[ $RELEASE_MODE == *"--release"* ]]; then
  APK_TYPE="release"
else
  APK_TYPE="debug"
fi

# the apk path seems to be related to android sdk version, release apk path could be apk/release/android-release.apk or apk/android-release.apk
if [[ -f $CUR_DIR/platforms/android/build/outputs/apk/android-$APK_TYPE.apk ]]; then
  cp $CUR_DIR/platforms/android/build/outputs/apk/android-$APK_TYPE.apk $CUR_DIR/../../build/$APP.apk
elif [[ -f $CUR_DIR/platforms/android/build/outputs/apk/$APK_TYPE/android-$APK_TYPE.apk ]]; then
  cp $CUR_DIR/platforms/android/build/outputs/apk/$APK_TYPE/android-$APK_TYPE.apk $CUR_DIR/../../build/$APP.apk
fi

echo $APP $CLASSIFIER

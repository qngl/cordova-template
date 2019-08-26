#!/bin/bash

set -ex

CUR_DIR=`pwd`

if [[ $# == 0 ]]; then
  echo "Usage: ./build.sh local [ENV] [signature]"
  exit 0
else
  ENV=$1
fi

if [[ $@ == *"release"* ]]; then
  CLASSIFIER="release"
  RELEASE_MODE="--device --release"
elif [[ $@ == *"dev"* ]]; then
  CLASSIFIER="development"
  RELEASE_MODE="--device --debug"
else
  CLASSIFIER="local"
  RELEASE_MODE="--debug"
fi

if [[ $@ == *"version"* ]]; then
  VERSION_MODE="--inc-version"
else
  VERSION_MODE="--no-inc"
fi

if [[ $ENV == "cons" ]]; then
  BASEURL="https://cons.xxxxxxxx.com"
fi
if [[ $ENV == "prod" ]]; then
  BASEURL="https://www.xxxxxxx.com"
fi
if [[ $ENV == "local.ios" ]]; then
  BASEURL="http://10.38.38.75:8081"
fi
if [[ $ENV == "local" ]]; then
  BASEURL="http://10.0.2.2"
fi

export BASEDOMAIN="$BASEURL"
if [[ $APP == "dealer" ]]; then
  BASEURL="$BASEURL/dealer"
fi
export BASEURL

CLASSIFIER="$CLASSIFIER.$ENV"


CP_CMD="cp $CUR_DIR/../../src/envs/env.mobile.$ENV.$APP.js $CUR_DIR/www/env.js"
$CP_CMD

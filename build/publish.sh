#!/bin/bash

CUR_DIR=`pwd`

FILE=$CUR_DIR/../../build/$APP.$EXT

if [[ $# == 0 ]]; then
  echo "Usage: ./publish.sh cons|prod|local"
else
  ENV=$1
  DATE=`date +%Y%m%d`

  cp $FILE $CUR_DIR/../../../apps/$ENV/$APP.$DATE.$EXT

  APIKEY=xxxx
  USERKEY=xxxxx

  if [[ $1 == "prod" ]]; then
    APIKEY=xxxxxx
    USERKEY=xxxxx
  fi

  curl  -F "file=@$FILE" \
        -F "_api_key=$APIKEY" \
        -F "userKey=$USERKEY" \
        -F "buildUpdateDescription=$APP $ENV" \
        https://www.pgyer.com/apiv2/app/upload
fi

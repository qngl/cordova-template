#!/bin/bash

set -ex

. ./build.browser.sh $@
. ./build.android.sh $@
. ./build.ios.sh $@

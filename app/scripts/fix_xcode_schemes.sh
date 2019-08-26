#!/bin/sh

# Cordova creates (and deletes) the xcodeproj on the fly during builds. This hook makes use of the
# `xcodeproj` gem to open the project and add schemes that were not in it after cordova added it.
# The right schemes are required for the project to build with the right codesigning.

# See https://github.com/fastlane/fastlane/blob/master/fastlane/lib/fastlane/actions/recreate_schemes.rb
# for the source code.

# !!TODO !! claude commented out , asks liqiang if file is still usable
# set -ex

# echo `pwd`

# (cd platforms/ios && xcodebuild -list)

# fastlane run recreate_schemes project:"platforms/ios/FSCO Dealer.xcodeproj" --verbose
# fastlane run automatic_code_signing path:"platforms/ios/FSCO Dealer.xcodeproj" team_id:"5EZB9WZ9EA" --verbose

# echo `pwd`

# (cd platforms/ios && xcodebuild -list)

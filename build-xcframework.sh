#!/bin/sh

rm -rf "stage"
rm -rf "dist"
mkdir "stage"
mkdir "dist"

PACKAGE_DIRECTORY=`pwd`
STAGE="${PACKAGE_DIRECTORY}/stage"

IOS_ARCHIVE="${STAGE}/libsmb2-ios.xcarchive"
MACOS_ARCHIVE="${STAGE}/libsmb2-macos.xcarchive"
TVOS_ARCHIVE="${STAGE}/libsmb2-tvos.xcarchive"

OUTPUT="${PACKAGE_DIRECTORY}/dist/libsmb2.xcframework"

echo 'Archiving for iOS...'
xcodebuild archive -scheme libsmb2 -destination 'generic/platform=iOS' -destination 'generic/platform=iOS Simulator' -archivePath "${IOS_ARCHIVE}" SKIP_INSTALL=NO BUILD_LIBRARY_FOR_DISTRIBUTION=YES > /dev/null

echo 'Archiving for macOS...'
xcodebuild archive -scheme libsmb2-macOS -destination 'generic/platform=OS X' -archivePath "${MACOS_ARCHIVE}" SKIP_INSTALL=NO BUILD_LIBRARY_FOR_DISTRIBUTION=YES > /dev/null

echo 'Archiving for tvOS...'
xcodebuild archive -scheme libsmb2-tvOS -destination 'generic/platform=tvOS' -destination 'generic/platform=tvOS Simulator' -archivePath "${TVOS_ARCHIVE}" SKIP_INSTALL=NO BUILD_LIBRARY_FOR_DISTRIBUTION=YES > /dev/null

echo 'Creating xcframework...'
xcodebuild -create-xcframework \
    -framework "${IOS_ARCHIVE}/Products/Library/Frameworks/libsmb2.framework" \
    -framework "${MACOS_ARCHIVE}/Products/Library/Frameworks/libsmb2_macOS.framework" \
    -framework "${TVOS_ARCHIVE}/Products/Library/Frameworks/libsmb2_tvOS.framework" \
    -output "${OUTPUT}"

rm -rf "${STAGE}"
echo "DONE!!"

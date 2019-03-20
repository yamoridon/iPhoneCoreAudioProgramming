#!/bin/sh

cp -pr $1 $2
mv $2/$1 $2/$2
mv $2/$1.xcodeproj $2/$2.xcodeproj
LANG=C find $2 -type f -exec sed -i -e s/$1/$2/g {} \;
find $2 -name "*-e" -delete
rm -rf $2/$1.xcworkspace
rm -rf $2/Pods
(cd $2; pod install)

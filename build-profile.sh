#!/bin/bash
set -e # Exit if any program returns an error.

#################################################################
# Make the host C++ project. PROFILE
#################################################################
if [ ! -d profile ]; then
    mkdir profile
fi
cd profile
cmake -DCMAKE_BUILD_TYPE=Profile ..
make

#################################################################
# Make the guest Flutter project.
#################################################################
if [ ! -d myapp ]; then
    flutter --local-engine=host_profile_unopt create myapp
fi
cd myapp
cp ../../main.dart lib/main.dart
flutter --local-engine=host_profile_unopt build bundle
cd -

#################################################################
# Run the Flutter Engine Embedder
#################################################################
#./flutter_glfw ./myapp ../../engine/src/third_party/icu/common/icudtl.dat

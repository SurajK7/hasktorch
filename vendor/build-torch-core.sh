#!/bin/bash -eu

# rm -rf ./build
mkdir -p ./build
# mkdir -p ./build-THS
# mkdir -p ./build-THNN

if [ "$(uname)" == "Darwin" ]; then
    if ! [ -x "$(command -v gcc-6)" ]; then
        echo 'Error: gcc-6 is not installed, use homebrew to install it.' >&2
        exit 1
    fi
    echo "Running as OSX ..."
    CXX=g++-6
    CC=gcc-6
elif [ "$(expr substr $(uname -s) 1 5)" == "Linux" ]; then
    if ! [ -x "$(command -v gcc)" ]; then
        echo 'Error: gcc is not installed.' >&2
        exit 1
    fi
    echo "Running as Linux ..."
    CXX=g++
    CC=gcc
else
    echo "Unknown OS"
    exit
fi

echo "Compilers:"
echo "  $CXX"
echo "  $CC"

cd ./build; cmake ../TH-pytorch/CMakeLists.txt -B. -DCMAKE_CXX_COMPILER=$CXX -DCMAKE_CC_COMPILER=$CC -DCXX=$CXX -DCC=$CC; make; cd ..
# cd ./build-THNN; cmake ../THNN-pytorch/CMakeLists.txt -B. -DCMAKE_CXX_COMPILER=$CXX -DCMAKE_CC_COMPILER=$CC -DCXX=$CXX -DCC=$CC; make; cd ..
# cd ./build-THS; cmake ../THS-pytorch/CMakeLists.txt -B. -DCMAKE_CXX_COMPILER=$CXX -DCMAKE_CC_COMPILER=$CC -DCXX=$CXX -DCC=$CC; make; cd ..
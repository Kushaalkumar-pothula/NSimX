#!/bin/bash

echo "Starting NsimX..."
# Remove .txt files
rm -f src/*.txt
echo "Compiling code..."
# Run NsimX
gfortran -o gen src/gen.f90 src/nsimx.f90
echo "Running code..."
# Run executable
./gen
echo "NsimX simulation finished."

#!/bin/bash

echo "Starting NsimX..."
# Remove .txt files
rm -f *.txt
echo "Compiling code..."
# Run NsimX
gfortran -o gen gen.f90 nsimx.f90
echo "Running code..."
# Run executable
gen
echo "NsimX simulation finished."

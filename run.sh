#!/bin/bash

echo "Starting NsimX..."
# Remove .txt files
rm -f *.txt
echo "Compiling code..."
# Run NsimX
gfortran simulate.f90 -o simulate
echo "Running code..."
# Run executable
./simulate
echo "NsimX simulation finished."

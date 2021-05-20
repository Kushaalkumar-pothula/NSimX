#!/bin/bash

echo "Starting NsimX..."
# Remove .txt files
rm -f src/*.txt
echo "Compiling code..."
# Run NsimX
gfortran src/gen.f90 -o src/gen
echo "Running code..."
# Run executable
src/gen
echo "NsimX simulation finished."

#!/bin/bash

echo "====================  NsimX N-body Simulator  ===================="
echo "                      ---------------------                       "
echo "   A fast, gravitational, leapfrog method based N-body simulator  "
echo "=================================================================="
echo "Starting NSimX..."
echo "Compiling code..."
gfortran -o gen src/gen.f90 src/nsimx.f90
echo "Compilation finished successfully."
echo "Running code..."
./gen
echo "Code ran successfully."
mv *.txt ./analysis
cd analysis
python analysis.py
cd ../
echo "NsimX simulation finished."

#!/bin/bash

echo "Starting NsimX..."
# Remove .txt files
file="*.txt"

if [ -f "$file" ] ; then
    rm "$file"
fi

echo "Compiling code..."
# Run NsimX
gfortran simulate.f90 -o simulate

echo "Running code..."
./simulate

echo "NsimX simulation finished."
# NSimX
A simple gravitational N-body simulator based on the Leapfrog integration scheme.

## 1. Installation
*Dependencies*: To run this code, you must have ```gfortran``` (or any other Fortran compiler) installed.
To install NSimX, run the following command in your terminal:
```bash
$ https://github.com/Kushaalkumar-pothula/NSimX.git
```

## 2. Usage
**Warning**: This code is in early development. Proceed with caution.

To run the code, enter the directory where the file ```simulate.f90``` exists and open it in a terminal. Then run the following command:
```bash
gfortran simulate.f90 -o simulate
```
This creates an executable ```simulate```. To run it on Windows, run ```simulate.exe``` from the same directory, and on Unix systems, run ```./simulate```.

---
I has been noticed that the code cannot run completely when there are ```.txt``` files in the same directory. This bug could be resolved later. For now, **remember to move  ```.txt``` files (in the same directory as the code) to another before running it!**.

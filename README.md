# NSimX
A simple gravitational N-body simulator based on the Leapfrog integration scheme.

## 1. Installation
*Dependencies*: To run this code, you must have ```gfortran``` (or any other Fortran compiler) installed.
To install NSimX, run the following command in your terminal:
```bash
$ https://github.com/Kushaalkumar-pothula/NSimX.git
```

## 2. Usage
To run the code, enter the directory where the file ```simulate.f90``` exists and open it in a terminal. Then run the following command:
```bash
cd NSimX
bash run.sh
```
This runs ```simulate.f90``` and creates an executable ```simulate``` which is run using ```./simulate```. 

---

**Warning**: The file ```run.sh``` removes and ```.txt``` files in the directory to prevent bugs. Always move ```.txt``` files into another directory!

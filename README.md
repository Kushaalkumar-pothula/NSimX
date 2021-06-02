# NSimX
A fast gravitational N-body simulator based on the Leapfrog integration scheme.

## 1. Installation
*Dependencies*:
- A C compiler
- Python
  - NumPy
  - Matplotlib
  - imageio


To install NSimX, run the following command in your terminal:
```bash
$ https://github.com/Kushaalkumar-pothula/NSimX.git
```

## 2. Usage
To run the code, first compile `main.c` using a C compiler. The compilation was tested successfully using `gcc`:
```bash
$ gcc main.c -o main
```
This generates an executable which can be run:
```bash
$ ./main
```
Next, run the analysis script:
```
$ python plot.py
```

## 3. Simulation Output
The output files are several text and PNG files and one animation file (MP4). The text files are called "snapshot" files, and contain the positions of all the bodies at a specific time. These files are plotted to make several PNG "frames", which are 3D scatter plots of positions in the snapshot files. These frames are then animated to make a movie.

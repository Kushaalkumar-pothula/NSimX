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

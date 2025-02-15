# Demonstration-benchmark

This repository contains example material used by MegaGiga ASBL for the demonstration of a small speed test comparing the speed of C, Fortran and Python with regards to matrix multiplication.

## Language files

#### benchmark.c

The C version of the program. This program could be made a little faster when using pointers. However, the readability of the program would largly suffer from this optimization

#### benchmark.f90

The Fortran 90 version of the program. This program uses the ```matmul()``` function. This is to our opinion not a 'cheet' since this function belongs to the default Fortran 90 syntax and does not require to import extra modules.

#### benchmark.py

The Python version of the program. Note that the declaration and initialisation of the matrices is not taken into account when timing the program. It would be a nice exercise to time how long it takes to initialize a large matrix in Python.

Nota that no external modules (as numpy) are used, since most of them are written in an other language than Python for reasons of speed.

## Executable files

To run this benchmark, the following commands are used:

    make init
    source venv/bin/activate
    make build
    deactivate
    make exec
    make clean
 
Note that the ```Makefile``` contains Linux commands, but adapting it to a Windows environment is not a major obstacle.

The following files are created by the ```make``` process:

    File            Size (bytes)    Contents
    ----            ------------    --------
    benchmark_c          16008      Compilation of benchmark.c
    benchmark_f          16672      Compilation of benchmark.f90
    benchmark_p1          1108      Python script
    benchmark_p2       7812016      Python script packed with pyinstaller
    benchmark_p3      14410016      Python script compiled with Nuitka and gcc

## Results

The programs do two tests. One test is adding numbers to a long integer (integer in the case of Python). The second test is the initialisation of two matrices, the multiplication of the two and the sum of all their elements.

The numerical results of the test are:

    Test           Result (integer)
    ----           ----------------
    Test 1      5.000.000.500.000.000
    Test 2         33.979.281.250.000

The times it took each program to run the tests are:

    Language            File           Time 1 (sec)    Time 2 (sec)
    --------            ----           ------------    ------------
    C                   benchmark_c       0.000001        0.395538
    Fortran 90          benchmark_f       0.000001        0.171882
    Python (script)     benchmark_p1    136.155672       58.965943
    Python (packed)     benchmark_p2    183.697916       61.405433
    Python (compiled)   benchmark_p3     71.476802       48.658299

## Conclusions

* The times to run the tests are clearly in the advantage of Fortran and C. The larger the arrays the more difference can be seen between C and Fortran. This is probably due to the efficiency of the Fortran ```matmul()``` function.
* The Python script is slower, but the packed Python script (pyinstaller) is substantially slower than the ordinary Python script, which came to a surprise to us. The compiled Python script (Nuitka) is substantially faster than the packed and the non-packed Python script. This is no surprise. However, the difference between the Nuitka result and C respectively Fortran is still very large.

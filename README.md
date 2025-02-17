# Demonstration-benchmark

This repository contains example material used by MegaGiga ASBL for the demonstration of a small speed test comparing the speed of C, Cobol, Fortran, Pascal and Python with regards to matrix multiplication. Note that this benchmark has didactic purposes rather than obtaining the most optimal (binary) code.

## Language files

#### benchmark.c

The C version of the program. This program could be made a little faster when using pointers. However, the readability of the program would largly suffer from this optimization.

#### benchmark.cob

The Cobol version of the program. This program could be made a little faster when using comp variable types.

#### benchmark.f90

The Fortran 90 version of the program. This program uses the ```matmul()``` function. This is to our opinion not a 'cheet' since this function belongs to the default Fortran 90 syntax and does not require to import extra modules.

#### benchmark.c

The Pascal version of the program.

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
    benchmark_a         103952      Compilation of benchmark.pas
    benchmark_b          22976      Compilation of benchmark.cob
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
    Test 1        50.000.050.000.000
    Test 2        11.144.592.000.000

The times it took each program to run the tests are:

    Language            File           Time 1 (sec)    Time 2 (sec)
    --------            ----           ------------    ------------
    C                   benchmark_c       0.000002        0.395538
    Cobol               benchmark_b       7.149999        9.379999
    Fortran 90          benchmark_f       0.000002        0.089258
    Pascal              benchmark_a       0.085000        0.388000
    Python (script)     benchmark_p1     12.666679       26.322305
    Python (packed)     benchmark_p2     17.424252       34.582635
    Python (compiled)   benchmark_p3      8.227660       25.748264

## Conclusions

* The times to run the tests are clearly in the advantage of Fortran, C and Pascal with Cobol coming in as fourth. The larger the arrays the more difference can be seen between C and Fortran. This is probably due to the efficiency of the Fortran ```matmul()``` function.
* The Python script is slower, but the packed Python script (pyinstaller) is substantially slower than the ordinary Python script, which came as a surprise to us. The compiled Python script (Nuitka) is substantially faster than the packed script and alittle faster the non-packed Python script. This is no surprise. However, the difference between the Nuitka result and C respectively Fortran and Pascal is still remarkable.
* Cobol floats between Fortran, C and Pascal on the one side and Python on the other side. This is probably due to the fact that COBOL is not mode for mathematical challenges, but for readability and record handling.

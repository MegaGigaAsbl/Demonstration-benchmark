#include <stdio.h>
#include <time.h>

#define M_SIZE 400

int main() {

    long i, j, k;
    clock_t start_time, end_time;
    double time1, time2;

    long m1[M_SIZE][M_SIZE];
    long m2[M_SIZE][M_SIZE];
    long m3[M_SIZE][M_SIZE];

    long result1, result2;

    // ----------------------------------------------------

    start_time = clock();

    result1 = 0;
    for (i = 0; i < 100; i++) {
        for (j = 1; j < 1000001; j++)
            result1 += j;
    }

    end_time = clock();
    time1 = (double)(end_time - start_time) / CLOCKS_PER_SEC;

    // ----------------------------------------------------

    start_time = clock();

    for (i = 0; i < M_SIZE; i++) {
        for (j = 0; j < M_SIZE; j++) {
            m1[i][j] = i+1 + j+1;
            m2[i][j] = i+1 + j+1;
        }
    }

    for (i = 0; i < M_SIZE; i++) {
        for (j = 0; j < M_SIZE; j++) {
            m3[i][j] = 0;
            for (k = 0; k < M_SIZE; k++) {
                m3[i][j] += m1[i][k] * m2[k][j];
            }
        }
    }

    result2 = 0;
    for (i = 0; i < M_SIZE; i++) {
        for (j = 0; j < M_SIZE; j++) {
            result2 += m3[i][j];
        }
    }

    end_time = clock();
    time2 = (double)(end_time - start_time) / CLOCKS_PER_SEC;

    // ----------------------------------------------------

    printf("C       : Result= %ld, Time= %10.6f sec, Result= %ld, Time= %10.6f sec\n",
           result1, time1, result2, time2);

    return 0;
}

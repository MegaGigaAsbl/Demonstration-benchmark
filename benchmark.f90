program performance_test

    implicit none

    integer(4), parameter :: M_SIZE = 500

    integer(8) :: i, j, k
    real(8)    :: start_time, end_time
    real(8)    :: time1, time2, time3

    integer(8), dimension(M_SIZE, M_SIZE) :: m1, m2, m3

    integer(8) :: result1, result2

    ! -----------------------------------------------------

    call cpu_time(start_time)

    result1 = 0
    do i = 1, 100
        do j = 1, 10000000
            result1 = result1 + j
        end do
    end do

    call cpu_time(end_time)
    time1 = end_time - start_time

    ! -----------------------------------------------------

    call cpu_time(start_time)

    do i = 1, M_SIZE
        do j = 1, M_SIZE
            m1(i,j) = i+j;
            m2(i,j) = i+j;
        end do
    end do

    m3 = matmul(m1,m2)

    result2 = 0;
    do i = 1, M_SIZE
        do j = 1, M_SIZE
            result2 = result2 + m3(i,j);
        end do
    end do

    call cpu_time(end_time)
    time2 = end_time - start_time

    ! -----------------------------------------------------

    print '(A,I16,A,F10.6,A,A,I14,A,F10.6,A)',                      &
        'Fortran : Result= ', result1, ', Time= ', time1, ' sec, ', &
                  'Result= ', result2, ', Time= ', time2, ' sec'

end program performance_test

program Main

    implicit none

    real, dimension(4,4) :: something_special = reshape( (/ &
    1.0000e+00, 1.2500e-01, 1.8750e-01, 8.1250e-01, &
    3.1250e-01, 6.8750e-01, 6.2500e-01, 5.0000e-01, &
    5.6250e-01, 4.3750e-01, 3.7500e-01, 7.5000e-01, &
    2.5000e-01, 8.7500e-01, 9.3750e-01, 6.2500e-02 &
    /), (/ 4,4 /), order=(/2,1/) )

    real, dimension(-3:3,0:2) :: different_special = reshape( (/ &
    9.0909e-01,1.9091e+00,8.1818e-01,1.4545e+00,4.5455e-01, &
    1.2727e+00,1.8182e-01,2.7273e-01,3.6364e-01,6.3636e-01, &
    1.0000e+00,1.3636e+00,1.6364e+00,1.7273e+00,1.8182e+00, &
    7.2727e-01,1.5455e+00,5.4545e-01,1.1818e+00,9.0909e-02, &
    1.0909e+00 /), (/7,3/), order=(/1,2/) )

    real, dimension(0:2, 0:3) :: simple_matrix = reshape( (/ &
    1, 2, 3, 4, &
    4, 5, 6, 7, &
    0, 0, 0, 1 /), &
    (/ 3,4 /), order=(/2,1/))

    call matrix_stats(something_special)
    call matrix_stats(different_special)
    call matrix_stats(simple_matrix)

contains

    subroutine matrix_stats(array)

        real :: array(:,:)
        integer nrows, ncols, i, j
        real x(2+size(array,1)+size(array,2))

        nrows = size(array,1)
        ncols = size(array,2)

        print '("Number of rows:",i3,", number of columns:",i3,", number of elements:",i4,".")',nrows,ncols,nrows*ncols

        x = 0.0
        x(1) = huge(x(1))
        x(2) = tiny(x(2))
        do j = 1, ncols
            do i = 1, nrows
                if (array(i,j) < x(1)) x(1) = array(i,j)
                if (array(i,j) > x(2)) x(2) = array(i,j)
                x(2+nrows+j) = x(2+nrows+j) + array(i,j)
                x(2+i) = x(2+i) + array(i,j)
            enddo
        enddo

        print '("Smallest value:",es12.4,", largest value:",es12.4,".")',x(1),x(2)
        print '("Range row indices:  1-",i2,", range column indicies:  1-",i2,".")',nrows,ncols

        write(*, '(a)', advance='no') 'Sum rows: '
        do i = 1, nrows - 1
            write(*,'(es11.4, " -")',advance='no') x(2+i)
        enddo
        write(*,'(es11.4, ".")') x(2+nrows)

        write(*, '(a)', advance='no') 'Sum columns: '
        do i = 1, ncols - 1
            write(*,'(es11.4, " -")',advance='no') x(2+nrows+i)
        enddo
        write(*,'(es11.4, ".")') x(2+nrows+ncols)
        
    end subroutine
end program

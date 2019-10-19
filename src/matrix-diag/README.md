# Example of grabbing an alias for a matrix diagonal

Pros: Should be fast to optimize and relatively convenient for programmers
Cons: The diagonal is immutable, and does not remain synchronized with the original A matrix

``` Fortran
program main
  use iso_fortran_env, only : dp => real64
  implicit none
  integer, parameter :: N=9
  integer :: i, j
  real(dp), allocatable :: A(:,:)

  A = reshape([ ( (10*j + i, i=1,N ), j=1,N) ], [N, N])

  associate( diag => [ (A(i,i), i=1,N) ] )
    write(*,'("diag: ",*(g0,:,", "))') nint(diag)
    A(1,1) = 1010
    write(*,'("diag: ",*(g0,:,", "))') nint(diag)
  end associate
  write(*,'(A)') "A:"
  do j = 1, N
     write(*,'(*(g0,:,", "))') nint(A(:,j))
  end do
end program
```

This produces the result:

```
diag: 11, 22, 33, 44, 55, 66, 77, 88, 99
diag: 11, 22, 33, 44, 55, 66, 77, 88, 99
A:
1010, 12, 13, 14, 15, 16, 17, 18, 19
21, 22, 23, 24, 25, 26, 27, 28, 29
31, 32, 33, 34, 35, 36, 37, 38, 39
41, 42, 43, 44, 45, 46, 47, 48, 49
51, 52, 53, 54, 55, 56, 57, 58, 59
61, 62, 63, 64, 65, 66, 67, 68, 69
71, 72, 73, 74, 75, 76, 77, 78, 79
81, 82, 83, 84, 85, 86, 87, 88, 89
91, 92, 93, 94, 95, 96, 97, 98, 99
```

Relates to https://github.com/j3-fortran/fortran_proposals/issues/14

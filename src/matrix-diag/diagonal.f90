program main
  use iso_fortran_env, only : dp => real64
  implicit none
  integer, parameter :: N=9
  integer :: i, j
  real(dp), allocatable :: A(:,:)

  A = reshape([ ( (10*j + i, i=1,N ), j=1,N) ], [N, N])

  associate( diag => [ (A(i,i), i=1,N) ] )
    write(*,'("diag: ",*(g0,:,", "))') nint(diag)
  end associate
  write(*,'(A)') "A:"
  do j = 1, N
     write(*,'(*(g0,:,", "))') nint(A(:,j))
  end do
end program

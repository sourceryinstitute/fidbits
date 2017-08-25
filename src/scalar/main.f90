program main
  !! Demonstrate how to pass a Fortran derived type with allocatable array components
  !! to a C procedure, which sees it as a struct with pointer components.
  use iso_c_binding, only : c_ptr, c_loc, c_int
  implicit none

  type :: foo
    integer, allocatable :: array(:)
    integer :: array_size
  end type

  type, bind(c) :: foo_for_c
    type(c_ptr) :: array_c_ptr
    type(c_ptr) :: array_size_c_ptr
  end type

  interface
    function print_me(foo_struct) bind(C) result(return_code)
      import foo_for_c
      type(foo_for_c), intent(in), value :: foo_struct
      integer :: return_code
    end function
  end interface

  block
    type(foo), target :: bar

    bar%array = [0,1,2,3,4]
    bar%array_size = size(bar%array)

    if (0_c_int /= print_me( foo_for_c(c_loc(bar%array),c_loc(bar%array_size)) ) ) error stop "Test failed."
  end block

 print *,"Test passed."

end program

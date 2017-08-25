module foo_module
  use iso_c_binding, only : c_ptr, c_loc, c_int
  implicit none

  private
  public :: foo, foo_for_c

  type :: foo
    integer, allocatable :: array(:)
    integer :: array_size
  end type

  type, bind(c) :: foo_for_c
    type(c_ptr) :: array_c_ptr
    type(c_ptr) :: array_size_c_ptr
  end type

  interface foo_for_c
    module procedure foo_array
  end interface

contains

  elemental function foo_array(object) result(foo_object_for_c)
    type(foo), intent(in), target :: object
    type(foo_for_c) :: foo_object_for_c
    foo_object_for_c =  foo_for_c(c_loc(object%array),c_loc(object%array_size))
  end function

end module

program main
  use foo_module, only : foo, foo_for_c
  !! Demonstrate how to pass a Fortran derived type with allocatable array components
  !! to a C procedure, which sees it as a struct with pointer components.
  use iso_c_binding, only : c_ptr, c_loc, c_int
  implicit none

  interface
    function print_all(foo_struct, num_objects) bind(C) result(return_code)
      use iso_c_binding
      import foo_for_c
      implicit none
      type(foo_for_c), intent(in) :: foo_struct(:)
      integer(c_int), value, intent(in) :: num_objects
      integer :: return_code
    end function
  end interface

  block
    integer :: i
    type(foo), target :: bar(2)

    bar(1)%array = [0,1,2]
    bar(1)%array_size = size(bar(1)%array)

    bar(2)%array = [3,4,5,6,7,8]
    bar(2)%array_size = size(bar(2)%array)

    if (0_c_int /= print_all( foo_for_c(bar), size(bar)) ) error stop "Test failed."
  end block

 print *,"Test passed."

end program

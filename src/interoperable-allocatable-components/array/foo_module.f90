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

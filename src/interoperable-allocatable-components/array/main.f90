program main
  use foo_module, only : foo, foo_for_c
  !! Demonstrate a C function invocation with an actual argument that is a derived-type array wherein each
  !! element is an object with allocatable array components. The C function has a dummy argument that is an
  !! array of structs with pointer components corresponding to the Fortran derived type's components.
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

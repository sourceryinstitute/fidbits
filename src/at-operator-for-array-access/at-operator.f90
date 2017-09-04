module field_interface
  !! Define an operator notation for accessing an array at a location by mapping
  !! each component of an integer to an index of the array being accessed.
  implicit none

  type field
    real, allocatable :: nodal_values(:,:,:)
  contains
    procedure :: at
    generic :: operator(.at.)=>at
  end type

  integer, parameter :: space_dimension=3

  interface
    pure module function at(this,location) result(element)
      !! Return the component array element at the provided indicial location
      implicit none
      class(field), intent(in) :: this
      integer, intent(in) :: location(space_dimension)
      integer :: element
    end function
  end interface

end module

submodule(field_interface) field_definitions
contains
  module procedure at
    implicit none
    element = this%nodal_values(location(1),location(2),location(3))
  end procedure
end submodule

program main
  !! Demonstrate the .at. operator for accessing array elements
  use field_interface
  implicit none
  integer :: i,j,k,cube_corners(2,2,2)=reshape([(i,i=1,2**3)],[2,2,2])
    !! Store sequential numbering of cube corners

  do concurrent(i=1:2,j=1:2,k=1:2)
   associate(n=>[i,j,k])
    call assert( (field(cube_corners) .at. n) == cube_corners(i,j,k), ".at. notation works")
      !! Use the intrinsic field structure constructor to verify the .at. notation
   end associate
  end do
  print *,"Test passed."

contains
  pure subroutine assert(assertion,description)
    logical, intent(in) :: assertion
    character(len=*), intent(in) :: description
    if (.not. assertion) error stop "Assertion '"//description// "' failed."
  end subroutine
end program

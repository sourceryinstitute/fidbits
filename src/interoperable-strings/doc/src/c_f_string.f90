!! author: Izaak "Zaak" Beekman
!! date: 2017-09-29
!! display: true
!! graph: true
!!
!! Module to convert c strings to Fortran strings while trying to minimize
!! copies

module c_f_string_m
  !! author: Izaak "Zaak" Beekman
  !! date: 2017-09-29
  !! display: true
  !! graph: true
  !!
  !! Module to convert c strings to Fortran strings while trying to minimize
  !! copies
  implicit none
  private
  public :: c_f_string, c_str_to_fortran

  interface
     !! author: Izaak "Zaak" Beekman
     !! date: 2017-09-29
     !! display: true
     !! graph: true
     !!
     !! Interface with C std lib's `strlen`
     function strlen(str) result(res) bind(c, name='strlen')
       !! author: Izaak "Zaak" Beekman
       !! date: 2017-09-29
       !! display: true
       !! graph: true
       !!
       !! C's std lib `strlen` function
       use, intrinsic :: ISO_C_BINDING, only: c_ptr, c_size_t

       type(c_ptr), intent(in), value :: str !! C string
       integer(c_size_t) :: res !! Length of string, i.e.,
                                !! `merge(index(str,c_null_char)-1,0,index(str,c_null_char)>0)`
     end function
  end interface

contains
  subroutine c_f_string(c_str, f_str)
    !! author: Izaak "Zaak" Beekman
    !! date: 2017-09-29
    !! display: true
    !! graph: true
    !! proc_internals: true
    !!
    !! Recast a C string as a Fortran scalar character pointer
    !!
    !! @warning `f_str` will become a dangling pointer if the thing pointed at
    !! by `c_str` becomes undefined, USE WITH CAUTION!
    !!
    !! @warning `f_str` must be of type `c_char`. Client code should declare
    !! the actual argument corresponding to `f_str` as
    !! `character(kind=c_char,len=:), pointer` and then perform type conversion
    !! native `character()` kind via assignment.
    !!
    !! @note This solution was inspired by @ianh's post on the Intel Fortran
    !! compiler forum at
    !! <https://software.intel.com/en-us/forums/intel-visual-fortran-compiler-for-windows/topic/392505>
    use, intrinsic :: ISO_C_BINDING, only: c_char, c_f_pointer, c_ptr
    type(c_ptr), intent(in) :: c_str
    !! C `char` string to convert to a scalar Fortran string
    character(kind=c_char, len=:), pointer, intent(out) :: f_str
    !! Scalar `character` `pointer` of type `c_char` corresponding to `c_str`
    character(kind=c_char), pointer :: char_array(:)
    !! Temp array of length 1 characters

    call c_f_pointer(c_str, char_array, [strlen(c_str)])
    call char_array_to_scalar_ptr(size(char_array), char_array, f_str)

  contains

    subroutine char_array_to_scalar_ptr(scalar_len, scalar, ptr)
      !! author: Izaak "Zaak" Beekman
      !! date: 2017-09-29
      !! display: true
      !! graph: true
      !! proc_internals: true
      !!
      !! Internal procedure to recast pointer to array of length 1 characters
      !! as pointer scalar character variable of length >= 1

      use, intrinsic :: ISO_C_BINDING, only: c_ptr
      integer, intent(in) :: scalar_len
      !! Length of `character` `pointer` being passed in
      character(kind=c_char, len=scalar_len), intent(in), target :: scalar(1)
      !! Temporary rank 1, `size() = 1` pointer to character of `len=scalar_len`
      character(kind=c_char, len=:), intent(out), pointer :: ptr
      !! Scalar return pointer to persist casting as scalar `character`

      ptr => scalar(1)
    end subroutine
  end subroutine

  function c_str_to_fortran(c_str) result(res)
    !! author: Izaak "Zaak" Beekman
    !! date: 2017-09-29
    !! display: true
    !! graph: true
    !!
    !! Return a Fortran scalar string corresponding to a C string using
    !! [[c_f_string(proc)]] and then casting it as a non-pointer
    !!
    !! @note This will probably cause a temporary variable to be allocated

    use, intrinsic :: ISO_C_BINDING, only: c_char, c_ptr
    type(c_ptr), intent(in) :: c_str
    !! C string to be converted
    character(len=:), allocatable :: res
    !! Function return, a native Fortran, scalar `character` variable
    character(kind=c_char, len=:), pointer :: f_ptr_str
    !! Temporary variable to point to C string as a native Fortran pointer

    call c_f_string(c_str,f_ptr_str)
    res = f_ptr_str(:) ! realloc on assignment, type conversion if possible
                       ! and required
  end function
end module

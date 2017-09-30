!! author: Izaak "Zaak" Beekman
!! date: 2017-09-29
!! display: true
!! graph: true
!!
!! Example program to show the usage of [[c_f_string(proc)]] and [[c_str_to_fortran(proc)]]

program main
  !! author: Izaak "Zaak" Beekman
  !! date: 2017-09-29
  !! display: true
  !! graph: true
  !!
  !! Example program to show the usage of [[c_f_string(proc)]] and [[c_str_to_fortran(proc)]]
  use c_f_string_m, only: c_f_string, c_str_to_fortran
  use, intrinsic :: ISO_FORTRAN_ENV, only: stdout => output_unit
  use, intrinsic :: ISO_C_BINDING, only: c_char, c_ptr, c_size_t

  implicit none

  integer, parameter :: n_elem = 7

  interface
     !! author: Izaak "Zaak" Beekman
     !! date: 2017-09-29
     !! display: true
     !! graph: true
     !!
     !! Interface with `SpeciesName` from [[str_array.c]]
     function SpeciesName_C(idx) result(res) bind(c, name='SpeciesName')
       !! author: Izaak "Zaak" Beekman
       !! date: 2017-09-29
       !! display: true
       !! graph: true
       !!
       !! Interface for function `SpeciesName` declared in [[str_array.c]]
       use, intrinsic :: ISO_C_BINDING, only: c_size_t, c_ptr
       integer(c_size_t), value, intent(in) :: idx
       !! Index of const char* array to retrieve
       type(c_ptr) :: res
       !! Returned string
     end function
  end interface

  block
    integer :: i
    integer(c_size_t) :: c_idx
    character(kind=c_char,len=:), pointer :: f_char_ptr

    do i = 1, n_elem
       c_idx = i - 1
       write(stdout, '(A, I0, A, A)') "SpeciesName_C(", i, "): ", c_str_to_fortran(SpeciesName_C(c_idx))
       call c_f_string(SpeciesName_C(c_idx),f_char_ptr)
       write(stdout, '(A, I0, A, A)') "SpeciesName_C(", i, "): ", f_char_ptr
    end do

  end block

end program

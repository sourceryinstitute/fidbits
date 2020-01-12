program main
  !! author: Damian Rouson
  !!
  !! Tabulate scenarios that do or do not preserve array bounds
  implicit none
  character(len=*), parameter :: output_file= 'table.md'
  character(len=*), parameter :: markdown_row = '(*(G0,:,"|"))'
  character(len=*), parameter :: heading1 = "Bounds-preserving", heading2 = "Fortran feature"
  integer, parameter :: width(*)=[len(heading1), len(heading2)]
  integer, allocatable :: a(:), b(:), c(:)
  integer file_unit

  open(file=output_file, newunit=file_unit)
  write(file_unit, markdown_row) heading1, heading2
  write(file_unit, markdown_row) horizontal_line(heading1), horizontal_line(heading2)

  !  --- True cases ----

  allocate(a(-1:1))
  b = a
  write(file_unit, markdown_row) &
    table_entry(width(1), all([lbound(b), ubound(b)] == [lbound(a), ubound(a)])), "intrinsic assignment"

  allocate(c, source = a)
  write(file_unit, markdown_row) &
     table_entry(width(1), all([lbound(c), ubound(c)] == [lbound(a), ubound(a)])), "source allocation without specified bounds"

  call allocatable_assumed_shape(a)

  associate( n => a)
    write(file_unit, markdown_row) &
      table_entry(width(1), all([lbound(n), ubound(n)] == [lbound(a), ubound(a)])), "associate name"
  end associate

  !  --- False cases ----

  call non_allocatable_assumed_shape(a)

  write(file_unit, markdown_row) &
    table_entry(width(1), all([lbound(function_result()), ubound(function_result())] == [-1, 1])), "function result"

contains

  subroutine non_allocatable_assumed_shape(d)
    integer d(:)
    write(file_unit, markdown_row) &
      table_entry(width(1), all([lbound(d), ubound(d)] == [lbound(a), ubound(a)])), "non-allocatable, assumed-shape dummy argument"
  end subroutine

  subroutine allocatable_assumed_shape(d)
    integer, allocatable :: d(:)
    write(file_unit, markdown_row) &
      table_entry(width(1), all([lbound(d), ubound(d)] == [lbound(a), ubound(a)])), "allocatable, assumed-shape dummy argument"
  end subroutine

  function function_result() result(d)
    integer, allocatable :: d(:)
    allocate(d(-1:1))
  end function

  pure function horizontal_line(string) result(line)
    character(len=*), intent(in) :: string
    character(len=:), allocatable :: line
    line = repeat("-",ncopies=len(string))
  end function

  pure function table_entry(result_length, bounds_match) result(entry_string)
    integer, intent(in) :: result_length
    logical, intent(in) :: bounds_match
    character(len=:), allocatable :: entry_string
    associate( true =>"True"//repeat(" ",ncopies=result_length-len("True")) )
      associate( false=>"False"//repeat(" ",ncopies=len(true)-len("False")) )
      entry_string  = merge(true, false, bounds_match)
      end associate
    end associate
  end function

end program
